import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupHeaderText extends StatelessWidget {
   String? title;
   double? font_size =30;  
   StartupHeaderText({
    required this.title, 
    this.font_size, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.05),
      child: AutoSizeText.rich(TextSpan(
          style: context.textTheme.headline2,
          children: [
            TextSpan(
                text: title,
                style: TextStyle(color: startup_heding_color, fontSize: font_size))
          ])),
    );
  }
}
