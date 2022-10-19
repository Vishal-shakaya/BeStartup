import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top:20),
      child: Image.asset(logo_image,
          height: 150,
          width: 250,
          fit: BoxFit.scaleDown),
    );
  }
}
