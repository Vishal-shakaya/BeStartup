import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;

class PHLoginForm extends StatefulWidget {
  String button_text = '';
  bool is_form_login; 
  PHLoginForm({ 
    required this.button_text,
    required this.is_form_login});

  @override
  State<PHLoginForm> createState() => _PHLoginFormState();
}

class _PHLoginFormState extends State<PHLoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  @override
  Widget build(BuildContext context) {

    Color input_text_color =
        Get.isDarkMode ? Colors.grey.shade100 : Colors.black87;
    Color input_foucs_color =
        Get.isDarkMode ? Colors.tealAccent : Colors.teal.shade400;
    Color input_label_color =
        Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade900;


//////////////////////////////////
/// MANAGE LOGIN AND SIGNUP FOROM: 
//////////////////////////////////

  SubmitForm() async{
    if(widget.is_form_login){
      // SUBMIT LOGIN FORM :
      SubmitLoginForm() async {
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
    }

  else{
        // SUBMIT SIGNUP FORM :
        SubmitSignupForm() async {
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

  }

  }


    return Container(
        width: context.width * 0.80,
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(children: [
                  ////////////////////////////
                  // EMAIL  SECTION
                  ///////////////////////////

                  // EMAIL HEADER :
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Email addresss',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: input_label_color)),
                  ),

                  // EMAIL INPUT FILED :
                  Container(
                    height: 52,
                    child: FormBuilderTextField(
                      name: 'email',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: Get.isDarkMode
                              ? FontWeight.w400
                              : FontWeight.w600,
                          color: input_text_color),
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
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.teal.shade300)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 2, color: input_foucs_color)),
                          // errorText: 'invalid email address',
                          // constraints: BoxConstraints(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),

                  ////////////////////////////
                  // PASSWORD SECTION
                  ///////////////////////////
                  ///
                  // PASSWORD LABEL:
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: input_label_color)),
                  ),

                  // PASSWORD INPUT FILED :
                  Container(
                    height: 52,
                    child: FormBuilderTextField(
                      name: 'password',
                      obscureText: is_password_visible,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: Get.isDarkMode
                              ? FontWeight.w400
                              : FontWeight.w600,
                          color: input_text_color),
                      keyboardType: TextInputType.emailAddress,

                      // Validate password
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 8,
                            errorText: 'invalid password')
                      ]),

                      decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.orange.shade300,
                          ),
                          // suffix: InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         is_password_visible = false;
                          //       });
                          //     },
                          //     child: Icon(
                          //         Icons.remove_red_eye,
                          //         color: input_label_color)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.teal.shade300)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 2, color: input_foucs_color)),
                          // errorText: 'invalid email address',
                          // constraints: BoxConstraints(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ])),

            /////////////////////////
            /// LOGIN BUTTON :
            /// /////////////////////
            Container(
              width: 270,
              height: 42,
              margin: EdgeInsets.only(top: 20),
              child: a.GradientElevatedButton(
                  gradient: g1,
                  onPressed: () async {
                    await SubmitForm();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.orange)
                  ))),
                  child: Text('${widget.button_text}',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ))),
            )
          ],
        ));
  }
}
