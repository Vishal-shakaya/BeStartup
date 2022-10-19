
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSideImage extends StatelessWidget {
  const LoginSideImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
              child: Image.asset('assets/images/side_login_image.png',
                height: context.height *0.50,
                width: context.width *0.50, 
                fit: BoxFit.scaleDown)
                );
  }
}
