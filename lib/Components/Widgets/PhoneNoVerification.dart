import 'dart:async';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class PhoneNoVerifyDialogAlert extends StatefulWidget {
  var noOperation;
  PhoneNoVerifyDialogAlert({this.noOperation, Key? key}) : super(key: key);

  @override
  State<PhoneNoVerifyDialogAlert> createState() =>
      _PhoneNoVerifyDialogAlertState();
}

class _PhoneNoVerifyDialogAlertState extends State<PhoneNoVerifyDialogAlert> {
  var auth = Get.put(MyAuthentication(), tag: 'my_auth');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  TextEditingController otpEditingController = TextEditingController();

  bool hasError = false;
  String final_otp = "";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final optformKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType>? errorAnimationController;
  FirebaseAuth fireauth = FirebaseAuth.instance;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  var valid_number;
  bool is_otp_field = false;
  var confirmResult;
  var currentUser;
  var verificanId;

  // Error Snacknar :
  ErrorSnakbar({title, message}) async {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      margin: EdgeInsets.only(top: 10),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.shade50,
      titleText: MySnackbarTitle(title: title),
      messageText: MySnackbarContent(message: message),
      maxWidth: context.width * 0.50,
    );
  }

  // Success Alert :
  SuccessAlert({message}) {
    CoolAlert.show(
        context: context,
        width: 200,
        title: 'Successful',
        type: CoolAlertType.success,
        widget: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold),
        ));
  }

  // SUBMIT PHONE NO TO SEND OTP:
  SubmitPhoneNo() async {
    final is_valid = formKey.currentState!.validate();
    if (is_valid) {
      formKey.currentState!.save();

      var resp = await auth.VerifyPhoneNo(
        number:valid_number.toString(),
        is_update:NumberOperation.update );
        
      if (resp['response']) {
        confirmResult = resp['data']['confirmationResult'];
        currentUser = resp['data']['currentUser'];
        verificanId = resp['data']['verificanId'];
        setState(() {
          is_otp_field = true;
        });
      }
      if (!resp['response']) {
        await ErrorSnakbar(title: 'Error', message: resp['message']);
      }
    }
  }


  // GET OTP AND SEND FOR VERIFICATION:
  // If Success then link phone no to login user :
  // else show error :
  VerifyNumber() async {
    final resp = await auth.VerifyOtp(
        currentUser: currentUser,
        confirmationResult: confirmResult,
        otp: final_otp, );
    if (!resp['response']) {
      await ErrorSnakbar(title: 'Re-check OTP', message: resp['message']);
    }

    if (resp['response']) {
      Navigator.of(context).pop();
      SuccessAlert(message: 'Number Verified ');
    }
  }

  // Updating Phone number
  UpdatePhoneNo() async {
        final resp = await auth.UpdatePhoneNo(
        verificationId: verificanId,
        otp: final_otp);
    if (!resp['response']) {
      await ErrorSnakbar(title: 'Re-check OTP', message: resp['message']);
    }

    if (resp['response']) {
      Navigator.of(context).pop();
      SuccessAlert(message: 'Number Updateded ');
    }
  }

  // Check if update phone no or just vrify : process accordingly :
  VerifingOtp() async {
    if (widget.noOperation == NumberOperation.update) {
      await UpdatePhoneNo();
    } else {
      await VerifyNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ))
            ],
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          is_otp_field ? OtpInputField(context) : InputNumberField(),
          SizedBox(
            height: context.height * 0.05,
          ),
          SubmitFormButton(),
        ],
      ),
    );
  }

  Container OtpInputField(BuildContext context) {
    return Container(
        child: PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(20),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.white,
            enableActiveFill: false,
            // errorAnimationController: errorController,
            controller: otpEditingController,
            onCompleted: (v) {
              print("Completed $v");
              VerifingOtp();
            },
            onChanged: (value) {
              print(value);
              setState(() {
                final_otp = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            }));
  }

  Form InputNumberField() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                // print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                // print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                valid_number = number;
              },
            )
          ],
        ),
      ),
    );
  }

  Container SubmitFormButton() {
    return Container(
      width: 300,
      height: 42,
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            await SubmitPhoneNo();
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            // side: BorderSide(color: Colors.orange)
          ))),
          child: Text('Next',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ))),
    );
  }
}
