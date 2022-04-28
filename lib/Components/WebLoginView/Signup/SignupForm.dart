import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:stylish_dialog/stylish_dialog.dart';

class SignupDetailForm extends StatefulWidget {
  SignupDetailForm({Key? key}) : super(key: key);

  @override
  State<SignupDetailForm> createState() => _SignupDetailFormState();
}

class _SignupDetailFormState extends State<SignupDetailForm> {
  var myAuth = Get.put(MyAuthentication(), tag: 'signup_user');

  // Change Theme :
  final _formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  bool is_password_match = false;
  var pass_controller;

  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

  // SUCCESS DIALOG :
  SuccessDialog(context) async {
    CoolAlert.show(
        widget: Container(
          child: Column(
            children: [],
          ),
        ),
        context: context,
        width: 300,
        type: CoolAlertType.success);
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

  // SUBMIT SIGNUP FORM :
  SubmitSignupForm(context, width) async {
    _formKey.currentState!.save();
    StartLoading();
    if (_formKey.currentState!.validate()) {
      String email = _formKey.currentState!.value['email'];
      String password = _formKey.currentState!.value['password'];
      // String confirm_password =
      //     _formKey.currentState!.value['confirmPassword'];
        

      // print(confirm_password);
      _formKey.currentState!.reset();

      // SIGNUP PROCESS :
      var resp = await myAuth.SignupUser(email: email, password: password);
      print('Signup Response ${resp}');

      // SUCCESS RESPONSE :
      if (resp['response']) {
        EndLoading();
        SuccessDialog(context);
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
          maxWidth: width,
        );
      }
    } else {
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
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: width,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 390,
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(children: [
                // EMAIL INPUT FILED :
                Label('Email'),
                EmailInputField(context),

                // PASSWORD INPUT FILED :
                Label('Password'),
                PasswordField(context),

                // CONFIRM PASSWORD FIELD:
                Label('Confirm password'),

                ConfirmPasswordField()
            ])),

              /// SIGNUP BUTTON  :
              Container(
                width: 270,
                height: 42,
                margin: EdgeInsets.only(top: 40),
                child: a.GradientElevatedButton(
                    gradient: g1,
                    onPressed: () async {
                      await SubmitSignupForm(context, context.width * 0.50);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.orange)
                    ))),
                    child: Text('Signup',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ))),
              ),
          ],
      ));
  }
  
  
  
  ///////////////////////
  /// METHODS : 
  ///////////////////////
  Container Label(title) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 12),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: input_label_color)),
    );
  }


  FormBuilderTextField ConfirmPasswordField() {
    return FormBuilderTextField(
                  name: 'confirmPassword',
                  obscureText: is_password_visible,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
                      color: input_text_color),
                  keyboardType: TextInputType.emailAddress,

                  // Validate password
                  validator: FormBuilderValidators.compose([
                    (val) {
                      if (val != pass_controller) {
                        print(pass_controller);
                        print(val);
                        return 'password not match';
                      }
                    }
                  ]),

                  decoration: InputDecoration(
                      hintText: 'confirm password',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      prefixIcon: Icon(
                        Icons.remove_red_eye_rounded,
                        color: Colors.orange.shade300,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1.5, color: Colors.teal.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(width: 2, color: input_foucs_color)),
                      // errorText: 'invalid email address',
                      // constraints: BoxConstraints(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                );
  }



  /////////////////////////////////
  /// COMPONENT SECTION :
  /////////////////////////////////
  FormBuilderTextField PasswordField(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      
      onChanged: (val){
        pass_controller=val; 
      },
      obscureText: is_password_visible,
      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: input_text_color),
      keyboardType: TextInputType.emailAddress,

      // Validate password
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 8,
            errorText: 'invalid password'),
      ]),

      decoration: InputDecoration(
          hintText: 'enter password',
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.orange.shade300,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }


  FormBuilderTextField EmailInputField(BuildContext context) {
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
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Colors.orange.shade300,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

}
