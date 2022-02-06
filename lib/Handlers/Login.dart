import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/UI/LoginView/Phone/MobileLoginView.dart';
import 'package:be_startup/UI/LoginView/Web/WebLoginView.dart';

class LoginHandler extends StatelessWidget {
  const LoginHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool is_mobile = GetPlatform.isMobile;

    return Scaffold(
      body: is_mobile 
      ? MobileLoginView() 
      : WebLoginView()
    );
  }
}
