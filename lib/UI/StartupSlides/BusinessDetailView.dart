import 'package:be_startup/Components/StartupSlides/BusinessDetailSlide/BusinessBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessDetailView extends StatelessWidget {
  const BusinessDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: business_slide_heading,),
              BusinessBody() 
          ]
        )
      ),
    );
  }
}