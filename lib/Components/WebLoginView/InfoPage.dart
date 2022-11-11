// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:be_startup/Components/WebLoginView/InfoPage/FeatureBlock.dart';
import 'package:be_startup/Components/WebLoginView/InfoPage/FeatureBlock1.dart';
import 'package:be_startup/Components/WebLoginView/InfoPage/InfoHeading.dart';
import 'package:be_startup/Components/WebLoginView/InfoPage/ReverseBlock1.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'InfoPage/ReverseBlock.dart';



class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

 
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
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
              image: homeProfessionalImage,
              ),
        
              //Right Imgage left text:
              ReverseBlock(
              heading_text: feature2_header,
              body_text:feature2_body,
              gradient1: g1, 
              image: homeInvestorImage,
              ),
              
              FeatureBlock1(
              heading_text: feature3_header,
              body_text:feature3_body,
              gradient1: g1, 
              image: homeAttractiveProfileImage,
              ),
        
              //Right Imgage left text:
              ReverseBlock1(
              heading_text: feature4_header,
              body_text:feature4_body,
              gradient1: g1, 
              image: homePlatformSupportImage,
              ),
              
            ]),
        ));
  }
}
