import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/Widgets/ForgotPasswordDialogAlert.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:get/get.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  String login_text = 'Login';
  var myAuth = Get.put(MyAuthentication(), tag: 'current_user');

  // SUCCESS DIALOG :
  InfoDialog(context) async {
    CoolAlert.show(
        widget: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              AutoSizeText.rich(TextSpan(
                  text: 'Email not Verified',
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(),
                    color: light_color_type3,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )))
            ],
          ),
        ),
        context: context,
        width: 300,
        type: CoolAlertType.info);
  }

  // LOADING SPINNER :
  StartLoading() {
    var dialog = SmartDialog.showLoading(
        background: Colors.white,
        maskColorTemp: Color.fromARGB(146, 252, 250, 250),
        widget: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ));
    return dialog;
  }

  // END LOAIDNG  :
  EndLoading() async {
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    // Change Theme :
    Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
    Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
    Color input_label_color =
        Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

    // SUBMIT LOGIN FORM :
    SubmitLofinForm() async {
      _formKey.currentState!.save();
      // START LOADING :
      StartLoading();

      if (_formKey.currentState!.validate()) {
        String email = _formKey.currentState!.value['email'];
        String password = _formKey.currentState!.value['password'];
        // _formKey.currentState!.reset();
        // LOGIN USER :
        var resp = await myAuth.LoginUser(email: email, password: password);
        // SUCCESS RESPONSE :
        if (resp['response']) {
          EndLoading();
          _formKey.currentState?.reset();
          // Rediret to User Type Page :
          Get.toNamed(user_registration_url);
        }

        // EMAIL NOT VERIFY THEN FIRT ASK FOR VERIFY EMAIL :
        if (resp['data'] == 'email_not_verify') {
          EndLoading();
          InfoDialog(context);
          return;
        }

        // ERROR RESPONSE :
        if (!resp['response']) {
          EndLoading();
          // CLOSE SNAKBAR :
          Get.closeAllSnackbars();
          // Error Alert :
          Get.snackbar(
            '',
            '',
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            duration: Duration(seconds: 8),
            backgroundColor: Colors.red.shade50,
            titleText: MySnackbarTitle(title: 'Error accure'),
            messageText: MySnackbarContent(message: "${resp['data']}"),
            maxWidth: context.width * 0.50,
          );
        }
      } else {
        print('error found');
      }
    }

    // Start Forgoting Password :
    ForgotPasswordMethod() async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                    width: context.width * 0.20,
                    height: context.height * 0.30,
                    child: ForgotPasswordAlert(
                      key: UniqueKey(),
                    )));
          });
    }

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(children: [
                  // 1. EMAIL FIELD
                  Label(input_label_color, 'Email addresss'),
                  EmailInputField(input_text_color, context, input_foucs_color),

                  // 2. PASSWORD
                  Label(input_label_color, 'Password'),
                  PasswodInputField(
                      context, input_text_color, input_foucs_color),

                  // 3.LOOGIN BUTTON:
                  LoginButton(SubmitLofinForm),

                  // 5. Forgot password :
                  ResetPasswordButton(ForgotPasswordMethod)
                ]))
          ]),
        ));
  }

/////////////////////////////////////////
  /// EXTERNAL METHODS :
/////////////////////////////////////////

// Password Reset Button :
  Container ResetPasswordButton(ForgotPasswordMethod) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          ForgotPasswordMethod();
        },
        child: AutoSizeText.rich(
          TextSpan(text: 'click here to forgot password !'),
          style: TextStyle(color: light_color_type3, fontSize: 14),
        ),
      ),
    );
  }

  // Login Button :
  Container LoginButton(SubmitLofinForm) {
    return Container(
      width: 270,
      height: 42,
      margin: EdgeInsets.only(top: 20),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            await SubmitLofinForm();
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            // side: BorderSide(color: Colors.orange)
          ))),
          child: Text('$login_text',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ))),
    );
  }

  // Take Password Input :
  FormBuilderTextField PasswodInputField(
      BuildContext context, Color input_text_color, Color input_foucs_color) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 8,
            errorText: 'invalid password')
      ]),
      style: TextStyle(
        fontSize: 15,
        fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
        color: input_text_color,
      ),
      decoration: InputDecoration(
          hintText: 'enter password',
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.orange.shade300,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  // Take Email Input :
  FormBuilderTextField EmailInputField(
      Color input_text_color, BuildContext context, Color input_foucs_color) {
    return FormBuilderTextField(
      name: 'email',
      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: input_text_color),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(context, errorText: 'enter valid email')
      ]),
      decoration: InputDecoration(
          hintText: 'enter mail ',
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Colors.orange.shade300,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  // Labels of input field :
  Container Label(Color input_label_color, title) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: input_label_color)),
    );
  }
}
