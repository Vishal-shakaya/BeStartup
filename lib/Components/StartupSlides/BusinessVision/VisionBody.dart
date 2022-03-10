import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionBody extends StatefulWidget {
  VisionBody({Key? key}) : super(key: key);

  @override
  State<VisionBody> createState() => _VisionBodyState();
}

class _VisionBodyState extends State<VisionBody> {
  final formKey = GlobalKey<FormBuilderState>();
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  int vision_cur_len = 1;
  int? vision_max_len = 20;
  bool vision_is_focus = true;

  double vision_cont_width = 0.50;
  double vision_cont_height = 0.70;
  double vision_subheading_text = 20;
  int maxlines = 15; 

  SubmitVision(context) {
    // IF VISION NOT DEFINAE THEN :
    CoolAlert.show(
        context: context,
        width: 200,
        title: 'Define Vision',
        type: CoolAlertType.info,
        widget: Text(
          'Withou vison there is no Startup',
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade700,
              fontWeight: FontWeight.bold),
        ));
  }

  ResetVisionForm() {}

  @override
  Widget build(BuildContext context) {
    
    if (context.width > 1200) {
       maxlines = 15; 
       vision_subheading_text = 20;
       vision_cont_width = 0.50;
       vision_cont_height = 0.70;
    }

    // PC:
    if (context.width < 1200) {
       maxlines = 15; 
       vision_subheading_text = 20;
       vision_cont_width = 0.70;
       vision_cont_height = 0.70;
    }

    if (context.width < 1000) {
       maxlines = 15; 
       vision_cont_width = 0.70;
       vision_cont_height = 0.70;

    }

    // TABLET :
    if (context.width < 800) {
       maxlines = 15; 
       vision_cont_width = 0.80;
       vision_cont_height = 0.70;
    }
    // SMALL TABLET:
    if (context.width < 640) {
       maxlines = 11; 
       vision_cont_width = 0.80;
       vision_cont_height = 0.70;

    }

    // PHONE:
    if (context.width < 480) {
       maxlines = 15; 
       vision_cont_width = 0.60;
       vision_cont_height = 0.70;

    }

    return Column(
      children: [
        Container(
          width: context.width * vision_cont_width,
          height: context.height * vision_cont_height,
          child: Column(
            children: [
              // SUB HEADING :
              Container(
                margin: EdgeInsets.only(top: context.height * 0.05),
                child: AutoSizeText.rich(
                    TextSpan(
                      style: context.textTheme.headline2, 
                      children: [
                    TextSpan(
                      text: vision_subHeading_text,
                      style: TextStyle(
                        color: light_color_type3,
                        fontSize: vision_subheading_text ))
                ])),
              ),
          
              Container(
                margin: EdgeInsets.only(top: context.height * 0.04),
                height: maxlines * 24.0,
                child: TextField(
                  style: GoogleFonts.robotoSlab(
                    fontSize: 16,
                  ),
                  maxLength: 2000,
                  scrollPadding: EdgeInsets.all(10),
                  maxLines: maxlines,
                  decoration: InputDecoration(
                      helperText: 'min allow 200 ',
                      hintText: "you,r vision",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey.shade200,
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1.5, color: Colors.blueGrey.shade200)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 2, color: primary_light)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
        ),

        BusinessSlideNav(slide:SlideType.vision)
      ],
    );
  }
}
