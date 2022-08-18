import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:cool_alert/cool_alert.dart';

class PHLoginForm extends StatefulWidget {
  String button_text = '';
  bool is_form_login;
  PHLoginForm({required this.button_text, required this.is_form_login});

  @override
  State<PHLoginForm> createState() => _PHLoginFormState();
}

class _PHLoginFormState extends State<PHLoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;

  // THEME COLORS:
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    String? confirm_password;
    TextEditingController confirm_pass_field = TextEditingController();

    ////////////////////////////////////////
    /// CHECK IF BOTH PASS MATCHED :
    /// IF NOT MATCH THEN SHOW ERROR:
    /// ELSE JUST MOVE FORWORD [SIGNUP USER ] :
    ////////////////////////////////////////
    ConfirmPassword() {
      confirm_password = confirm_pass_field.text;
      if (password != confirm_password) {
        FocusManager.instance.primaryFocus?.unfocus();
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: 'Password does not match',
            text: 'please enter signup password');
        print('password not match');
      } else {
        Navigator.of(context).pop();
        print('match passwod');
      }
    }

    /////////////////////////////////
    // CONFIRM PASSOWRD ALERT :
    // GET CONF_PASS AND STORE IN VAR:
    /////////////////////////////////
    ConfirmPasswordDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('Securiy Check',
                              style: Get.textTheme.headline2)),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Icon(Icons.cancel_outlined,
                            color: Colors.blueGrey.shade300, size: 20))
                  ],
                ),
                content: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  width: context.width * 0.99,
                  height: context.height * 0.27,
                  // alignment: Alignment.center,

                  child: Column(
                    children: [
                      TextField(
                        controller: confirm_pass_field,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            color: Colors.orange.shade300,
                          ),
                          hintText: 'confirm password',
                          contentPadding: EdgeInsets.all(16),
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.teal.shade300)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 2, color: input_foucs_color)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),

                      // CONFIRM BUTTON :
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton.icon(
                            onPressed: () async {
                              ConfirmPassword();
                            },
                            icon: Icon(Icons.check,
                                size: 17, color: Colors.blue.shade300),
                            label: Text(
                              'confirm',
                              style: TextStyle(
                                  color: Colors.blue.shade400,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  ),
                ),
              ));
    }

//////////////////////////////////////
    // SUBMIT LOGIN FORM :
//////////////////////////////////////
    SubmitLoginForm() async {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        email = _formKey.currentState!.value['email'];
        password = _formKey.currentState!.value['password'];
        _formKey.currentState!.reset();
      }

     
    }

//////////////////////////////////////
    // SUBMIT SIGNUP FORM :
    // 1 CHECK PASS LENGTH :
    // 2 PASS1 == PASS2
//////////////////////////////////////
    SubmitSignupForm() async {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        String email = _formKey.currentState!.value['email'];
        String password = _formKey.currentState!.value['password'];

        ////////////////////////////
        // CONFIRM PASSWORD :
        // 1 GET BOTH PASSWORD  :
        ////////////////////////////
        ConfirmPasswordDialog();

        // RESET FORM TO DEFAUL STATE :
        _formKey.currentState!.reset();
      }

       Get.toNamed(
        user_registration_url,
      );
    }

//////////////////////////////////////
// MANAGE LOGIN AND SIGNUP FOROM:
//////////////////////////////////////
    SubmitForm() async {
      if (widget.is_form_login) {
        SubmitLoginForm();
      } else {
        SubmitSignupForm();
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
                  FormBuilderTextField(
                    name: 'email',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
                        color: input_text_color),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(context,
                          errorText: 'enter valid email')
                    ]),
                    decoration: InputDecoration(
                        hintText: 'enter mail ',
                        contentPadding: EdgeInsets.all(16),
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
                            borderSide:
                                BorderSide(width: 2, color: input_foucs_color)),
                        // errorText: 'invalid email address',
                        // constraints: BoxConstraints(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),

                  ////////////////////////////
                  // PASSWORD SECTION
                  ///////////////////////////

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
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: is_password_visible,

                    style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
                        color: input_text_color),
                    keyboardType: TextInputType.emailAddress,

                    // Validate password
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(context, 8,
                          errorText: 'invalid password')
                    ]),

                    decoration: InputDecoration(
                        hintText: 'password',
                        contentPadding: EdgeInsets.all(16),
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: Colors.orange.shade300,
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
                    SubmitForm();
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
