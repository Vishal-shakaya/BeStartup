import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.w,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 22, bottom:20),
      padding: EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style:Get.theme.textTheme.headline1,
          children:[
            TextSpan(
              text:login_page_heading_text,

              style: context.width<800
              ? TextStyle(
                fontSize: 35)
              :TextStyle()
              
            )
          ]
        ),
      ),
    );
  }
}
