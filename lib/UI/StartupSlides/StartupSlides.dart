import 'dart:js';
import 'package:be_startup/Components/Slides/BusinessCatigory/CatigoryBody.dart';
import 'package:be_startup/Components/Slides/BusinessSlide/BusinessBody.dart';
import 'package:be_startup/Components/Slides/BusinessThumbnail/ThumbnailBody.dart';
import 'package:be_startup/Components/Slides/BusinessVision/VisionBody.dart';
import 'package:be_startup/Components/Slides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/RegisterationSlides/UserType.dart';
import 'package:be_startup/Components/Slides/BusinessSlide/BusinessIcon.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StartupSlides extends StatefulWidget {
  StartupSlides({Key? key}) : super(key: key);

  @override
  State<StartupSlides> createState() => _StartupSlidesState();
}

class _StartupSlidesState extends State<StartupSlides> {
  @override
  Widget build(BuildContext context) {

 
   List<PageViewModel> slides =[

   /////////////////////////////////////////  
   ///  BUSINESS SLIDE :
   ///  1. BUSINESS ICON : 
   ///  2. INPUT FIELD TAKE BUSINESS NAME :  
   /////////////////////////////////////////  
    PageViewModel(
    /// HEADING SECTION : 
      titleWidget:SlideHeading(heading: business_slide_heading,),
    // BODY SECTION
       bodyWidget: BusinessBody()

    ), 
   /////////////////////////////////////////  
   // BUSINESS THUMBNAIL : 
   // 1 UPLOD IAMGE : 
   // THUMBNIAL SIZE : null 
   /////////////////////////////////////////  
    PageViewModel(
    /// HEADING SECTION : 
      titleWidget:SlideHeading(heading: thumbnail_slide_heading,),
    // BODY SECTION
       bodyWidget: ThumbnailBody()
    ),

   /////////////////////////////////////////  
   /// VISION : 
   /// PUPOSE OF STARTUP : 
   /////////////////////////////////////////  
    PageViewModel(
    /// HEADING SECTION : 
      titleWidget:SlideHeading(heading: vision_Heading_text,),
    // BODY SECTION
       bodyWidget: VisionBody()
    ),
   /////////////////////////////////////////  
   /// VISION : 
   /// PUPOSE OF STARTUP : 
   /////////////////////////////////////////  
    PageViewModel(
    /// HEADING SECTION : 
      titleWidget:SlideHeading(heading: catigory_Heading_text,),
    // BODY SECTION
       bodyWidget: CatigoryBody()
    ),

   /////////////////////////////////////////  
  // PRODUCT SLIDE : 
  // ADD PRODUCT : 
   /////////////////////////////////////////  
    PageViewModel(
    /// HEADING SECTION : 
      titleWidget:SlideHeading(heading: product_heading_text,),
    // BODY SECTION
       bodyWidget: CatigoryBody()
    ),


    
  ]; 



    return Container(
      child: IntroductionScreen(
      pages: slides,
      onDone: () {
        // When done button is press
      },
      showBackButton: false,
      showSkipButton: true,
      next:Text('next'),
      
      skip: const Text("Skip"),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    ));
  }
}
