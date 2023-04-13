import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image.asset(logo_image,
          height: 300,
          width: 300,
          fit: BoxFit.scaleDown),
    );
  }
}
