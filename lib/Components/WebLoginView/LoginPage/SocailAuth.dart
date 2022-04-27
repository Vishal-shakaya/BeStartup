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
        SignInButton(
            buttonType:
                Get.isDarkMode ? ButtonType.googleDark : ButtonType.google,
            elevation: 3,
            onPressed: () {
            Get.toNamed(select_investor_choise);
              print('click');
            }),
        SignInButton(
            buttonType: ButtonType.twitter,
            elevation: 3,
            onPressed: () {
            Get.toNamed(home_page_url);
            print('click');
            }),
        SignInButton(
            buttonType: ButtonType.linkedin,
            elevation: 3,
            onPressed: () {
              Get.toNamed(startup_view_url);
              print('click');
            }),
        SignInButton(
            buttonType: ButtonType.apple,
            elevation: 3,
            onPressed: () {
              Get.toNamed(create_business_vision_url, preventDuplicates: false);
              print('click');
            }),
      ],
    ));
  }
}
