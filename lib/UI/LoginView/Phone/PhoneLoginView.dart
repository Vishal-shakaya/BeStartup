import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Components/PhoneLoginVIew/PHBottomBar.dart';
import 'package:be_startup/Components/PhoneLoginVIew/PHLoginIcon.dart';
import 'package:be_startup/Components/PhoneLoginVIew/PHSocialAuth.dart';
import 'package:be_startup/Components/PhoneLoginVIew/PhLoginForm.dart';
import 'package:be_startup/Components/PhoneLoginVIew/SignupView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneLoginView extends StatefulWidget {
  PhoneLoginView({Key? key}) : super(key: key);

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  bool is_login_page = true;
  String main_text = ' Account';
  String desc_text = 'Create New';
  String btn_text = 'Login';
  bool is_form_login = true; 
  // Switch Login Page to Signup Page:
  SetPageState() {
    // Configure Signup Page:
    if (is_login_page) {
      setState(() {
        is_login_page = false;
        btn_text = 'Signup';
        desc_text = 'Back To';
        main_text = ' Login';
      });

      // Configure Login Page
    } else {
      setState(() {
        is_login_page = true;
        btn_text = 'Login';
        desc_text = 'Create New';
        main_text = ' Account';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          child: Column(children: [
            // Show logo in Login Page :
            // Else show upload picture widget:
            is_login_page ? PHLoginIcon() : SignupView(),

            PHLoginForm(
              is_form_login:is_form_login,
              button_text:btn_text),
            PHSocailAuth(),
            PHBottomBar(
              setPageState: SetPageState,
              main_text: main_text,
              desc_text: desc_text,
            ),
          ]),
        )),
      ),
    );
  }
}
