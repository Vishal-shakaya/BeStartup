import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top:50),
      child: Image.asset('assets/images/logo.png',
          height: 150,
          width: 250,
          fit: BoxFit.scaleDown),
    );
  }
}
