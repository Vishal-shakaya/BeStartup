import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionOne.dart';
import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionTwo.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticDetailSectionBody extends StatelessWidget {
  const StaticDetailSectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top:context.height*0.01,
        bottom: context.height*0.08 ),
      
      width: context.width*0.60,
      height: context.width*0.25,
      
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 15,
        shadowColor: Colors.blueGrey,
        child: Row(
          children :  [
            
          // SECTION ONE :   
          StaticSectionOne(),

          // DIVIDER : 
          VerticalDivider(), 

           // INVESTOR :   
           Expanded(
            child: Container(
              child: StatiSectionTwo(),
            )),  

          ]
        ),
      ),
    );
  }
}

