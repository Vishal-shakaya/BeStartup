import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';

class SocailAuth extends StatefulWidget {
  const SocailAuth({Key? key}) : super(key: key);

  @override
  State<SocailAuth> createState() => _SocailAuthState();
}

class _SocailAuthState extends State<SocailAuth> {
  bool is_theme_light = false;
  var auth = Get.put(MySocialAuth(), tag: 'socail_auth');
  @override
  Widget build(BuildContext context) {
    return Container(
        // alignment: Alignment.centerLeft,
        // margin: EdgeInsets.only(right: 70),
        child: Wrap(
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.down,
      spacing: 15,
      children: [
        // GOOGLE :
        SignInButton(
            buttonType:
                Get.isDarkMode ? ButtonType.googleDark : ButtonType.google,
            elevation: 3,
            onPressed: () async {
              GetPlatform.isWeb
                  ? await auth.SignInWithGoogleInWeb()
                  : await auth.SigninWithGoogleInAndroid();
            }),

        // TWITTER :
        SignInButton(
            buttonType: ButtonType.twitter,
            elevation: 3,
            onPressed: () async {
              GetPlatform.isWeb
                ? await auth.signInWithTwitterInWeb()
                : await auth.signInWithTwitterAndroid();
            }),

        // FACEBOOK :
        SignInButton(
            buttonType:
                Get.isDarkMode ? ButtonType.facebookDark : ButtonType.facebook,
            elevation: 3,
            onPressed: () async {
              GetPlatform.isWeb
                  ? await auth.signInWithFacebookInWeb()
                  : await auth.signInWithFacebookInAndroid();
            }),

        // APPLE :.
        SignInButton(
            buttonType: ButtonType.apple,
             elevation: 3, 
             onPressed: () {}),

        SignInButton(
            buttonType: ButtonType.mail,
            elevation: 3,
            onPressed: () async {
              await auth.Logout();
            }),
      ],
    ));
  }
}
