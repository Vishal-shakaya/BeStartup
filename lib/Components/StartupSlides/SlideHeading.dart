import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Messages.dart';

class SlideHeading extends StatelessWidget {
  String? heading = '';
  SlideHeading({this.heading});

  @override
  Widget build(BuildContext context) {
    double? fontSize = 40;

    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      fontSize = 35;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      fontSize = 30;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      fontSize = 25;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    if (context.width < 360) {
      print('360');
    }

    return Container(
      alignment: Alignment.center,
      height: context.height * 0.15,
      child: AutoSizeText.rich(
        TextSpan(style: Get.textTheme.headline1,
         children: [
          TextSpan(
              text: this.heading,
              style: TextStyle(
                fontSize: fontSize, 
                color: slide_header_color
                  //  fontSize: 35
                  ))
        ]),
      ),
    );
  }
}
