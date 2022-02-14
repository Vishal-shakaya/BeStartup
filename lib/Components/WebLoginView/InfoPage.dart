// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:be_startup/Components/WebLoginView/InfoPage/FeatureBlock.dart';
import 'package:be_startup/Components/WebLoginView/InfoPage/InfoHeading.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'InfoPage/ReverseBlock.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      // HEADER TEXT:
      InfoHeading(
        heading_text: login_page_info_heading,
        ),

      // FEATURE SECTION :
      // Left image right text:
      FeatureBlock(
        heading_text: feature1_header,
        body_text:feature1_body,
        gradient1: g1, 
      ),

      //Right Imgage left text:
      ReverseBlock(
        heading_text: feature2_header,
        body_text:feature2_body,
        gradient1: g1, 
      ),
      
      FeatureBlock(
        heading_text: feature3_header,
        body_text:feature3_body,
        gradient1: g1, 
      ),

      //Right Imgage left text:
      ReverseBlock(
        heading_text: feature4_header,
        body_text:feature4_body,
        gradient1: g1, 
      ),
      
    ]));
  }
}
