import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:responsive_framework/responsive_framework.dart';
class LoginSideImage extends StatelessWidget {
  const LoginSideImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
              // height: Get.height *0.80,
              // width: Get.width *0.50, 
          // margin:EdgeInsets.only(bottom:500),
          child: Image.asset('assets/images/side_login_image.png',
              height: context.height *0.50,
              width: context.width *0.50, 
              fit: BoxFit.scaleDown)
              );
  }
}
