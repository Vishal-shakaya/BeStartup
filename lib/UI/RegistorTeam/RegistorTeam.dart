import 'package:be_startup/Components/RegistorTeam/Slides/RegistorFounder/RegistorFounderBody.dart';
import 'package:be_startup/Components/RegistorTeam/Slides/RegistorTeam/RegistorTeamBody.dart';
import 'package:be_startup/Components/Slides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RegistorTeam extends StatefulWidget {
  RegistorTeam({Key? key}) : super(key: key);

  @override
  State<RegistorTeam> createState() => _RegistorTeamState();
}

class _RegistorTeamState extends State<RegistorTeam> {
  @override
  Widget build(BuildContext context) {

 
   List<PageViewModel> slides =[

   /////////////////////////////////////////  
   ///  FOUNDER REGISTRATION SLIDE :
   ///  1. PROFILE ICON UPLOAD : 
   ///  2. TAKE FOUNDER DETAIL AN DCONTACT INFO  :  
   /////////////////////////////////////////  
    PageViewModel(
      /// HEADING SECTION : 
       titleWidget:SlideHeading(heading: registor_founder_head_text,),
      // BODY SECTION
       bodyWidget: RegistorFounderBody()

    ), 

   /////////////////////////////////////////  
   ///  CREATE TEAM SLIDE  :
   ///  1. OPTIONAL FOR NOW  : 
   /////////////////////////////////////////  
    PageViewModel(
      /// HEADING SECTION : 
       titleWidget:SlideHeading(heading: registor_team_head_text,),
      // BODY SECTION
       bodyWidget: RegistorTeamBody()

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
