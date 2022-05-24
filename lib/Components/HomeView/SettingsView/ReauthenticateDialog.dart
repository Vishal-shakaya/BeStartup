import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:sign_button/sign_button.dart';
class ReauthenticateWidget extends StatefulWidget {
  ReauthenticateWidget({Key? key}) : super(key: key);

  @override
  State<ReauthenticateWidget> createState() => _ReauthenticateWidgetState();
}

class _ReauthenticateWidgetState extends State<ReauthenticateWidget> {
  final _formKey = GlobalKey<FormBuilderState>();

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

  @override
  Widget build(BuildContext context) {
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
        var resp;
        // SUCCESS RESPONSE :
        if (resp['response']) {
          EndLoading();
          // Rediret to User Type Page :
          // Get.toNamed(user_registration_url);
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
      }

      // ERROR HANDLING :
      else {
        print('error found');
      }
    }

    // Change Theme :
    Color input_text_color  = Get.isDarkMode ? dartk_color_type2 : light_black;
    Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
    Color input_label_color = Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

    return Container(
      child: FormBuilder(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        
              // HEADER TEXT : 
              AutoSizeText.rich(
                TextSpan(
                    text: 'User Confirmation', style: TextStyle(fontSize: 18)),
                style: Get.textTheme.headline3,
              ),
              
              ///////////////////////////
              // FORM INPUT FIELDS : 
              ///////////////////////////
             
              // 1. EMAIL FIELD
              Container(
                width: context.width*0.18,
                margin: EdgeInsets.only(top:context.height*0.04),
                child: Column(
                  children: [
                    Label(input_label_color, 'Email addresss'),
                    EmailInputField(input_text_color, context, input_foucs_color),
        
                    // 2. PASSWORD FIELD : 
                    Label(input_label_color, 'Password'),
                    PasswodInputField(
                        context, input_text_color, input_foucs_color),
                  ],
                ),
              ),
        
        
              // SUBMIT FORM BUTTON : 
              SubmitFormButton(SubmitLofinForm),
        
             // SOCIAL AUTH BUTTON ROW : 
              SocialReAuthRow(context) 
        
            ],
          ),
        ),
      ),
    );
  }

  Container SocialReAuthRow(BuildContext context) {
    return Container(
        width: context.width*0.15,
        margin: EdgeInsets.only(top:context.height*0.07),
        child:Row(
          mainAxisSize:MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: Get.isDarkMode? ButtonType.googleDark: ButtonType.google,
              elevation: 3,
              buttonSize: ButtonSize.medium,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: ButtonType.twitter,
              elevation: 3,
              buttonSize: ButtonSize.medium,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: ButtonType.linkedin,
              elevation: 3,
              buttonSize: ButtonSize.medium,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType:ButtonType.apple,
              elevation: 3,
              buttonSize: ButtonSize.medium,
              onPressed: () {
              print('click');
              }),
            ),
          ]
        )
          );
  }

  Container SubmitFormButton(Future<Null> SubmitLofinForm()) {
    return Container(
            width: 220,
            height: 42,
            margin: EdgeInsets.only(top: 20),
            child: a.GradientElevatedButton(
                gradient: g1,
                onPressed: () async {
                  await  SubmitLofinForm();
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.orange)
                ))),
                child: Text('Login',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ))),
            );
  }
  //////////////////////////////
  /// METHODS SECTION:
  /// /////////////////////////

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
        fontSize: 14,
        fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
        color: input_text_color,
      ),
      decoration: InputDecoration(
          hintText: 'enter password',
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.orange.shade300,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }

  FormBuilderTextField EmailInputField(
      Color input_text_color, BuildContext context, Color input_foucs_color) {
    return FormBuilderTextField(
      name: 'email',
      style: TextStyle(
          fontSize: 14,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: input_text_color),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(context, errorText: 'enter valid email')
      ]),
      decoration: InputDecoration(
          hintText: 'enter mail ',
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Colors.orange.shade300,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }

  Container Label(Color input_label_color, title) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: input_label_color)),
    );
  }
}
