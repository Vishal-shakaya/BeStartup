import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Messages.dart';

class SlideHeading extends StatelessWidget {
  String? heading = '';
  SlideHeading({this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.height * 0.15,
      child: AutoSizeText.rich(
        TextSpan(style: Get.textTheme.headline1, children: [
          TextSpan(
              text: this.heading,
              style: TextStyle(
                  //  fontSize: 35
                  ))
        ]),
      ),
    );
  }
}
