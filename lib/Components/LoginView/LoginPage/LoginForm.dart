import 'package:be_startup/Backend/Firebase/LoginUser.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/HelpingFun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginForm extends StatefulWidget {
  String? form_type;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  MyFirebaseStore my_store = MyFirebaseStore();
  String login_text = 'Login';

  @override
  Widget build(BuildContext context) {
    // Change Theme : 
    Color input_text_color = Get.isDarkMode ?  Colors.grey.shade100: Colors.black87;
    Color input_foucs_color = Get.isDarkMode ? Colors.tealAccent : Colors.teal.shade400;
    Color input_label_color = Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade900;

    // SUBMIT LOGIN FORM : 
    SubmitLofinForm() async {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        String email = _formKey.currentState!.value['email'];
        String password = _formKey.currentState!.value['password'];
        _formKey.currentState!.reset();
        // LOGIN USER :
        // await my_store.LoginUser(email: email, password: password);
      } else {
        print('error found');
      }
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
                  Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: Text('Email addresss',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: input_label_color)),
                  ),

                  FormBuilderTextField(
                    name: 'email',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: Get.isDarkMode? FontWeight.w400:FontWeight.w600 ,
                      color:input_text_color 
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
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
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.teal.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color:input_foucs_color)),
                        // errorText: 'invalid email address',
                        // constraints: BoxConstraints(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),

                  // 2. PASSWORD
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: input_label_color)),
                  ),

                  // PASSWORD BUTTON :
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(context, 8,
                          errorText: 'invalid password')
                    ]),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: Get.isDarkMode? FontWeight.w400:FontWeight.w600 ,
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
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.teal.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 2, color: input_foucs_color)),
                        // errorText: 'invalid email address',
                        // constraints: BoxConstraints(),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),

                  // LOOGIN BUTTON:
                  Container(
                    width: 270,
                    height: 42,
                    margin: EdgeInsets.only(top: 20),
                    child: a.GradientElevatedButton(
                        gradient: g1,
                        onPressed: () async {
                          await SubmitLofinForm();
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Colors.orange)
                        ))),
                        child: Text('$login_text',
                            style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ))),
                  ),
                ]))
          ]),
        ));
  }
}
