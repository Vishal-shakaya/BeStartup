import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;


class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
    var myAuth = Get.put(MyAuthentication(), tag: 'signup_user');

  // Change Theme :
  final _formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;

  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;


  // SUBMIT SIGNUP FORM :
  SubmitSignupForm() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      String email = _formKey.currentState!.value['email'];
      String password = _formKey.currentState!.value['password'];
      _formKey.currentState!.reset();
    } else {
      print('error found');
    }

    // IF SUCCESS THTN GO FORWORD :
    // Get.toNamed(startup_view_url);
  }

  @override
  Widget build(BuildContext context) {
return Container(
        width: 400,
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    
                  // EMAIL INPUT FILED :
                  EmailLabel(),
                  EmailInputField(context),

                  // PASSWORD INPUT FILED :
                  PasswordLabel(),
                  PasswordField(context),
                ])),

                  /// SIGNUP BUTTON  :
                  Container(
                    width: 270,
                    height: 42,
                    margin: EdgeInsets.only(top: 40),
                    child: a.GradientElevatedButton(
                        gradient: g1,
                        onPressed: () async {
                          await SubmitSignupForm();
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18.0),
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




 /////////////////////////////////
 /// COMPONENT SECTION :  
 ///////////////////////////////// 
  FormBuilderTextField PasswordField(BuildContext context) {
    return FormBuilderTextField(
          name: 'password',
          obscureText: is_password_visible,
          style: TextStyle(
              fontSize: 15,
              fontWeight: Get.isDarkMode
                  ? FontWeight.w400
                  : FontWeight.w600,
              color: input_text_color),
          keyboardType:
              TextInputType.emailAddress,

          // Validate password
          validator:
              FormBuilderValidators.compose([
            FormBuilderValidators.minLength(
                context, 8,
                errorText: 'invalid password')
          ]),

          decoration: InputDecoration(
              hintText: 'enter password',
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: Colors.orange.shade300,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 1.5,
                      color:
                          Colors.teal.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 2,
                      color: input_foucs_color)),
              // errorText: 'invalid email address',
              // constraints: BoxConstraints(),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15))),
        );
  }

  Container PasswordLabel() {
    return Container(
            padding: EdgeInsets.all(4),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Text('Password',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: input_label_color)),
          );
  }

  FormBuilderTextField EmailInputField(BuildContext context) {
    return FormBuilderTextField(
          name: 'email',
          style: TextStyle(
              fontSize: 15,
              fontWeight: Get.isDarkMode
                  ? FontWeight.w400
                  : FontWeight.w600,
              color: input_text_color),
          keyboardType:
              TextInputType.emailAddress,
          validator:
              FormBuilderValidators.compose([
            FormBuilderValidators.email(context,
                errorText: 'enter valid email')
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
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 1.5,
                      color:
                          Colors.teal.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 2,
                      color: input_foucs_color)),
              // errorText: 'invalid email address',
              // constraints: BoxConstraints(),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15))),
        );
  }

  Container EmailLabel() {
    return Container(
        padding: EdgeInsets.all(4),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10),
        child: Text('Email addresss',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: input_label_color)),
      );
  }
}