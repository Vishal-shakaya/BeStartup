import 'package:be_startup/Components/RegistorTeam/Slides/RegistorFounder/FounderImage.dart';
import 'package:be_startup/Components/RegistorTeam/Slides/RegistorFounder/RegistorFounderForm.dart';
import 'package:be_startup/Components/Slides/BusinessSlide/BusinessForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Components/Slides/BusinessSlide/BusinessIcon.dart';


class RegistorFounderBody extends StatelessWidget {
  const RegistorFounderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.7,
      /////////////////////////////////////////  
      ///  BUSINESS SLIDE :
      ///  1. BUSINESS ICON : 
      ///  2. INPUT FIELD TAKE BUSINESS NAME :  
      /////////////////////////////////////////  
        child: Column(
          children: [

            // UPLOAD FOUNDER IMAGE : 
            FounderImage(),

           // REGISTRATION FORM :  
            RegistorFounderForm()
            
            ],
        ));
  }
}
