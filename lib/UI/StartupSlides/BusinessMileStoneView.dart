import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/MileStoneBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessMileStone extends StatelessWidget {
  const BusinessMileStone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: milestone_heading_test,),
              MileStoneBody(),  
          ]
        )
      ),
    );
  }
}