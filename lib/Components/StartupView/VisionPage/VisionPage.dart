import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/VisionPage/StartupMIlesStone.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class VisionPage extends StatelessWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;
    return Container(
      width: context.width * page_width,

      child: Container(
        width: context.width*0.50,
        height: context.height*0.38,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADING : 
              SizedBox(height: 15,),
              StartupHeaderText(title:'Vision'),
              SizedBox(height: 20,),
              // VISION TEXT:  
              ClipPath(
                child: Card(
                  elevation: 1,
                  shadowColor: shadow_color1,
                  shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.horizontal(
                        left: Radius.circular(15), 
                        right: Radius.circular(15), 
                  )),
                  child: Container(
                    width:context.width * 0.45, 
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color:border_color),
                      borderRadius:BorderRadius.horizontal(
                        left: Radius.circular(15), 
                        right: Radius.circular(15)
                      )
                    ),
                
                    child:AutoSizeText.rich(
                      TextSpan(
                        text:long_string,
                        style:GoogleFonts.openSans(
                              textStyle: TextStyle(),
                              color: light_color_type3,
                              fontSize: 16,
                              height:1.6
                            )
                        ), 
                        style: Get.textTheme.headline2,
                    )
                  ),
                ),
              ), 


              SizedBox(height: 25,),
              StartupHeaderText(title:'MileStone'),
              SizedBox(height: 20,),

              // MILESTONES : 
               StartupMileStone() 

            ],
          ),
        ),       
    ),
    );
  }
}