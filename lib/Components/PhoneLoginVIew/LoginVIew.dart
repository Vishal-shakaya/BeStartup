import 'package:be_startup/Backend/Auth/LinkUser.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
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
  var authStore = Get.put(MyAuthentication());

  bool is_password_visible = true;
  var email;

  var password;
  String? confirm_password;
  var pass_controller;
  String password_regex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  // THEME COLORS:
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

//////////////////////////////////////
// SUBMIT LOGIN FORM :
//////////////////////////////////////
  SubmitLoginForm() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      email = _formKey.currentState!.value['email'];
      password = _formKey.currentState!.value['password'];

      // Remove wite space :
      email = email.trim();
      password = password.trim();

      print('Login mail $email');
      print('Login password $password');

      final resp = await authStore.LoginUser(email: email, password: password);

      print(resp);

      // Success Handler :
      if (resp['response']) {
        print('Login Successul');
      }

      // Error Handler :
      if (!resp['response']) {
        print('Error while Login');
      }

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

      email = email.trim();
      password = password.trim();

      print('Singup mail $email');
      print('Singup password $password');

      final resp = await authStore.SignupUser(email: email, password: password);

      print(resp);

      // Success Handler :
      if (resp['response']) {
        print('Singup Successul');
      }

      // Error Handler :
      if (!resp['response']) {
        print('Error while signup');
      }

      _formKey.currentState!.reset();
    
    
    } else {
      print('Error Signup form ');
    }

    // Get.toNamed(
    //   user_registration_url,
    // );
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

  @override
  Widget build(BuildContext context) {
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
                  // EMAIL  :
                  LabelField(label: 'Email Addresss'),
                  EmailAddressInputField(context),

                  // PASSWORD :
                  LabelField(label: 'Password'),
                  PasswordInputField(context),

                  // CONFIRM PASSWORD  :
                  widget.is_form_login == false
                      ? LabelField(label: 'Confirm  Password')
                      : Container(),

                  widget.is_form_login == false
                      ? ConfirmPasswordInputField(context)
                      : Container(),
                ])),

///////////////////////////////////////////////////////////
            /// External MEthods :
///////////////////////////////////////////////////////////

/////////////////////////////////////////////////
            /// Login Button :
/////////////////////////////////////////////////
            Container(
              width: 270,
              height: 42,
              margin: EdgeInsets.only(top: context.height * 0.05),
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
                      style: const TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ))),
            )
          ],
        ));
  }

////////////////////////////////////////
  /// Email Address Input field :
////////////////////////////////////////
  FormBuilderTextField EmailAddressInputField(BuildContext context) {
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
          hintText: 'Enter mail ',
          contentPadding: EdgeInsets.all(16),
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Colors.orange.shade300,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  ////////////////////////////////////////////////////
  /// Password Input Field;
  ////////////////////////////////////////////////////
  FormBuilderTextField PasswordInputField(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: is_password_visible,
      onChanged: (val) {
        pass_controller = val;
      },

      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: input_text_color),
      keyboardType: TextInputType.emailAddress,

      // Validate password
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 8,
            errorText: 'invalid password')
      ]),

      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.all(16),
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.orange.shade300,
            size: 19,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  ////////////////////////////////////////////////////
  /// Confirm  Password Input Field;
  ////////////////////////////////////////////////////
  FormBuilderTextField ConfirmPasswordInputField(BuildContext context) {
    return FormBuilderTextField(
      name: 'confirm_password',
      obscureText: is_password_visible,

      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: input_text_color),
      keyboardType: TextInputType.emailAddress,

      // Validate password
      validator: FormBuilderValidators.compose([
        (val) {
          if (val != pass_controller) {
            return 'password not matched';
          }
        },
      ]),

      decoration: InputDecoration(
          hintText: 'Confrim password',
          contentPadding: EdgeInsets.all(16),
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.remove_red_eye,
            color: Colors.orange.shade300,
            size: 19,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2, color: input_foucs_color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

/////////////////////////////////////////////
  /// Email Label :
/////////////////////////////////////////////
  Container LabelField({label}) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: context.height * 0.018),
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: light_color_type4)),
    );
  }
}
