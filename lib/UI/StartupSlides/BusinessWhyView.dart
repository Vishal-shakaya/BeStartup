import 'package:be_startup/Components/StartupSlides/BusinessVision/VisionBody.dart';
import 'package:be_startup/Components/StartupSlides/BusinessWhyInvest/BusinessWhyInvesBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessWhyInvestView extends StatelessWidget {
  const BusinessWhyInvestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: business_why_head_text,),
              BusinessWhyInvestBody(),  
          ]
        )
      ),
    );
  }
}