import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/MileStoneBody.dart';
import 'package:be_startup/Components/StartupSlides/BusinessPitch/BusinessPitchBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessPitchView extends StatelessWidget {
  const BusinessPitchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: pitch_heading_test,),
              BusinessPitchBody()
          ]
        )
      ),
    );
  }
}