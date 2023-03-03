import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:stylish_dialog/stylish_dialog.dart';

class SignupDetailForm extends StatefulWidget {
  SignupDetailForm({Key? key}) : super(key: key);

  @override
  State<SignupDetailForm> createState() => _SignupDetailFormState();
}

class _SignupDetailFormState extends State<SignupDetailForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  var myAuth = Get.put(MyAuthentication(), tag: 'current_user');
  var pass_controller;

  bool is_password_visible = true;
  bool is_password_match = false;
  String password_regex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  


  ////////////////////////////////////////
  /// After Loing Successful Signup
  /// Show Verify Email Message : 
  ////////////////////////////////////////
  SuccessDialog(context) async {
    CoolAlert.show(
        onConfirmBtnTap: () {
          Get.toNamed(home_route);
        },
        widget: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              AutoSizeText.rich(TextSpan(
                  text: 'Verify Email Before Login',
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
        type: CoolAlertType.success);
  }




///////////////////////////////////
/// Show Loading Spinner 
/// Meantime of login process : 
///////////////////////////////////
  StartLoading() {
    SmartDialog.showLoading(
      builder: (context) {
        return CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ); 
      },
    );
  }

  // END LOAIDNG  :
  EndLoading() async {
    SmartDialog.dismiss();
  }



///////////////////////////////////////////////
/// Submit Signup form detail : 
/// Required param : 
/// 1. mail 
/// 2. password 
/// Then if successful login then show congress 
/// message else show error message : 
///////////////////////////////////////////////
  SubmitSignupForm(context, width) async {
    _formKey.currentState!.save();
    StartLoading();
   
    if (_formKey.currentState!.validate()) {
      String email = _formKey.currentState!.value['email'];
      String password = _formKey.currentState!.value['password'];

      
      // SIGNUP PROCESS :
      var resp = await myAuth.SignupUser(
        email: email.trim(), 
        password: password.trim());
      
        print('Signup Response ${resp}');



      // SUCCESS RESPONSE :
      if (resp['response']) {
        EndLoading();
        SuccessDialog(context);
      }


      // ERROR HANDLING :  
      if (!resp['response']) {
        EndLoading();
        Get.closeAllSnackbars();
        
        Get.showSnackbar(
          MyCustSnackbar(
            width: width,
            type: MySnackbarType.error,
            message: '${resp['data']}',
            title:'Error accure'   ));
      }



    } else {
      EndLoading();
      Get.closeAllSnackbars();

      Get.showSnackbar(
        MyCustSnackbar(
          width: width,
          type: MySnackbarType.error,
          message: common_error_title,
          title:common_error_msg   ));
    }
    
     _formKey.currentState!.validate();
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
          width: 390,
          margin: EdgeInsets.only(top: context.height*0.04),
          padding: EdgeInsets.all(5),
    
          
          child: Column(
            children: [
              FormBuilder(
                  key: _formKey,
                  autoFocusOnValidationFailure : true, 
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
                    child: const Text('Signup',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ))),
              ),
            ],
          )),
    );
  }

  ///////////////////////
  /// METHODS :
  ///////////////////////
  Container Label(title) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: context.height*0.02),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: main_input_label__color)),
    );
  }

  FormBuilderTextField ConfirmPasswordField() {
    return FormBuilderTextField(
      name: 'confirmPassword',
      obscureText: is_password_visible,
      keyboardType: TextInputType.emailAddress,
      
      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: main_input_text_field_color),

      // Validate password
      validator: FormBuilderValidators.compose([
        (val) {
          if (val != pass_controller) {
            return 'password not match';
          }
        },
        FormBuilderValidators.minLength( 8, errorText: 'min length 8')
      ]),

       decoration: InputDecoration(
          hintText: 'Confirm',
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
         
          prefixIcon: Icon(
            Icons.check_circle,
            color: Colors.orange.shade300,
            size: 18,
          ),
         
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1.5, color: Colors.teal.shade300)),
         
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: main_input_border__color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  /////////////////////////////////
  /// COMPONENT SECTION :
  /////////////////////////////////
  FormBuilderTextField PasswordField(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      onChanged: (val) {
        pass_controller = val;
      },
      obscureText: is_password_visible,
      style: TextStyle(
          fontSize: 15,
          fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
          color: main_input_text_field_color),
      keyboardType: TextInputType.emailAddress,

      // Validate password
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength( 8,
            errorText: 'invalid password'),
        FormBuilderValidators.match( password_regex,
            errorText: 'create strong passwod ex:Password@13')
      ]),

      decoration: InputDecoration(
          hintText: 'Password',
          
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          
          hintStyle: const TextStyle(
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
              borderSide: BorderSide(width: 2, color: main_input_border__color)),
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
          color: main_input_text_field_color),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email( errorText: 'enter valid email')
      ]),
      decoration: InputDecoration(
          hintText: 'Mail ',
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          hintStyle: const TextStyle(
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
              borderSide: BorderSide(width: 2, color: main_input_border__color)),
          // errorText: 'invalid email address',
          // constraints: BoxConstraints(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
