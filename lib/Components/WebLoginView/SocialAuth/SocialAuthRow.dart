import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:get/get.dart';
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:15),
        child:Row(
          mainAxisSize:MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: Get.isDarkMode? ButtonType.googleDark: ButtonType.google,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: ButtonType.twitter,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType: ButtonType.linkedin,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            ),
            Expanded(
              flex:1,
              child: SignInButton.mini(
              buttonType:ButtonType.apple,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            ),
          ]
        )
    );
  }
}
