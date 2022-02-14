import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoHeading extends StatelessWidget {
  String? heading_text = '';
  InfoHeading({this.heading_text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40, bottom: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$heading_text', style: Get.theme.textTheme.headline1)
          ],
        ));
  }
}
