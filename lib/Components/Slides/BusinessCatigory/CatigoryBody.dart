import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/Slides/BusinessCatigory/CatigoryChip.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Helper.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatigoryBody extends StatefulWidget {
  CatigoryBody({Key? key}) : super(key: key);

  @override
  State<CatigoryBody> createState() => _CatigoryBodyState();
}

double vision_cont_width = 0.60;
double vision_cont_height = 0.90;
double vision_subheading_text = 20;

class _CatigoryBodyState extends State<CatigoryBody> {
  @override
  Widget build(BuildContext context) {

    // DEFAULT : 
		if(context.width>1500){
       vision_cont_height = 0.90;
       vision_cont_width = 0.60;
       vision_subheading_text = 20;
      
	  }
		if(context.width<1500){
       vision_cont_height = 0.90;
       vision_cont_width = 0.75;
       vision_subheading_text = 20;
      
	  }
		
       // PC:
		if(context.width<1200){
      vision_cont_width = 0.80;
      vision_subheading_text = 20;
	   }
		
		if(context.width<1000){
      vision_cont_width = 0.85;
      vision_subheading_text = 20;
	  }
	   
  
   // TABLET : 
   if(context.width<800){
      vision_cont_width = 0.80;
      vision_subheading_text = 20;

   }
   // SMALL TABLET: 
   if(context.width<640){
      vision_cont_width = 0.90;
      vision_subheading_text = 18;

   }

   // PHONE: 
   if(context.width<480){
      vision_cont_width = 0.99;
      vision_subheading_text = 16;

   }

    // CAREAT CATIGORY CHIPS: 
    List<CatigoryChip> catigory_list = [];
    business_catigories.forEach((cat) {
      catigory_list.add(CatigoryChip(key: UniqueKey(), catigory: cat, ));
    });

    return Container(
        width: context.width * vision_cont_width,
        height: context.height * vision_cont_height,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: context.height * 0.05),
              child: AutoSizeText.rich(
                  TextSpan(style: context.textTheme.headline2, children: [
                TextSpan(
                    text: catigory_subHeading_text,
                    style: TextStyle(
                        color: light_color_type3,
                        fontSize: vision_subheading_text))
              ])),
            ),
            Container(
              margin: EdgeInsets.only(top: context.height * 0.05),
              child: Wrap(
                spacing: 2,
                alignment: WrapAlignment.center,
                // crossAxisAlignment: WrapCrossAlignment.center,
                children: catigory_list,
              ),
            )
          ],
        ));
  }
}
