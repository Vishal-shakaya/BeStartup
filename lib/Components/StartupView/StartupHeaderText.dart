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

    // double heading_fontSize = 32;
    // heading_fontSize = 32;
    // if (context.width > 1700) {
    //     heading_fontSize = 32;
    //     print('Greator then 1700');
    // }

    // if (context.width < 1700) {
    //     print('1700');
    // }

    // if (context.width < 1600) {
    //     print('1500');
    // }

    // // PC:
    // if (context.width < 1500) {
    //     print('1500');
    // }

    // if (context.width < 1300) {
    //     heading_fontSize = 30;
    //     print('1300');
    // }

    // if (context.width < 1200) {
    //     heading_fontSize = 30;
    //     print('1200');
    // }

    // if (context.width < 1000) {
    //     print('1000');
    // }

    // // TABLET :
    // if (context.width < 800) {
    //     heading_fontSize = 28;
    //     print('800');
    // }


    // // SMALL TABLET:
    // if (context.width < 640) {
    //     heading_fontSize = 28;
    //     print('640');
    // }

    // // PHONE:
    // if (context.width < 480) {
    //     heading_fontSize = 25;
    //     print('480');
    // }

    return Container(
      margin: EdgeInsets.only(top: context.height * 0.05),
      child: AutoSizeText.rich(TextSpan(
          style: context.textTheme.headline2,
          children: [
            TextSpan(
                text: title,
                style: TextStyle(
                  color: startup_heding_color,
                  fontSize: font_size))
          ])),
    );
  }
}
