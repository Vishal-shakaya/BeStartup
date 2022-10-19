// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:be_startup/Components/WebLoginView/ExplainVideoSection/BusinessTycoonSection.dart';
import 'package:be_startup/Components/WebLoginView/ExplainVideoSection/ExplainHeaderSection.dart';
import 'package:be_startup/Components/WebLoginView/InfoPage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/HeaderText.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/LogoContainer.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage.dart';
import 'package:be_startup/Components/Widgets/BottomBar.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WebLoginView extends StatefulWidget {
  WebLoginView({Key? key}) : super(key: key);

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> {
  BlobController blobCtrl = BlobController();

  List<TyperAnimatedText> temp_quat = [];

  GetQuatList() async {
    qual_list.forEach((key, val) {
      print('${key} : value : ${val}');

      TyperAnimatedText quat = TyperAnimatedText(
        '$val',
        textStyle: GoogleFonts.robotoSlab(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 86, 106, 116),
          height:2
        ),

        textAlign: TextAlign.center,
        speed: const Duration(milliseconds: 100),
      );

      temp_quat.add(quat);
    });

    return temp_quat;
  }



  @override
  Widget build(BuildContext context) {
    GetQuatList();

    // RESPONSIVE POINTS :
    // 1 800 Login Tabs:
    // 2 1150 Hide image:
    // 3 890 Info Page  :
    // 4.800 Info Page Andd Responsive Row:
    return SingleChildScrollView(
      // Login Page :
      child: Stack(
        children: [
          Blob1(context),

          Blob2(context),

          // Web View :
          Column(
            children: [
            // Header Heading:
            HeaderText(),

            QuatSection(context),

            // BE STARTUP LOGO:
            LogoContainer(),

            //  LOGIN FORM AND SIDE IMAGE:
            LoginPage(),

            // INFO PAGE:
            InfoPage(),


            ExplainHeaderSection(), 

            BusinessTycoonSection(), 

            // BOTTAM BAR :
            BottomBar(),
          ]),
        ],
      ),
    );
  }










  Container QuatSection(BuildContext context) {
    return Container(
            alignment: Alignment.topCenter,
            width: context.width*0.35,
            height: context.height*0.10,
            margin: EdgeInsets.only(top:context.height*0.02),

            child: AnimatedTextKit(
              animatedTexts: temp_quat,

              totalRepeatCount: 4,
              pause:  Duration(milliseconds: 100),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ));
  }

  Positioned Blob2(BuildContext context) {
    return Positioned(
          left: context.width * 0.52,
          top: context.height * 0.01,
          child: Blob.animatedFromID(
            id: [
              '7-5-359',
              '7-4-339',
            ],
            styles: BlobStyles(
                fillType: BlobFillType.stroke,
                gradient: LinearGradient(
                        colors: [Color(0xFF4ca1af), Color(0xFFc4e0e5)])
                    .createShader(Rect.fromLTRB(0, 0, 300, 300))),
            size: 1150,
            duration: Duration(milliseconds: 3000),
            loop: true,
          ),
        );
  }

  Positioned Blob1(BuildContext context) {
    return Positioned(
          left: context.width * 0.52,
          top: context.height * 0.00,
          child: Blob.animatedFromID(
            id: [
              '7-5-359',
              '7-4-359',
            ],
            styles: BlobStyles(
                gradient: LinearGradient(
                        colors: [Color(0xFF4ca1af), Color(0xFFc4e0e5)])
                    .createShader(Rect.fromLTRB(0, 0, 300, 300))),
            size: 1150,
            duration: Duration(milliseconds: 2000),
            loop: true,
          ),
        );
  }
}
