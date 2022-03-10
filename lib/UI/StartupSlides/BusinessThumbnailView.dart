import 'package:be_startup/Components/StartupSlides/BusinessThumbnail/ThumbnailBody.dart';
import 'package:be_startup/Components/StartupSlides/BusinessVision/VisionBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessThumbnailView extends StatelessWidget {
  const BusinessThumbnailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: thumbnail_slide_heading,),
              ThumbnailBody()  
          ]
        )
      ),
    );
  }
}