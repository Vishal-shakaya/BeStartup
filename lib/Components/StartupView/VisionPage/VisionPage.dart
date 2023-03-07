import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/VisionPage/StartupMIlesStone.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionPage extends StatefulWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
  var detailViewState = Get.put(StartupDetailViewState());
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  var final_data;
  var startup_id;
  var user_id;
  var is_admin;

  double page_width = 0.80;

  double vision_page_width = 0.50;

  double vision_page_height = 0.38;

  double heading_top_spacer = 0.01;

  double headingfonSize = 30;

  double edit_btn_top_spacer = 0.01;

  double edit_btn_bottom_spacer = 0.01;

  double vision_elevation = 1;

  double vision_card_left_radius = 15;

  double vision_card_right_radius = 15;

  double vision_cont_width = 0.45;

  double vision_cont_height = 0.40; 

  double vision_cont_padding = 20;

  double vison_text_fontSize = 14;

  double vision_text_lineHeight = 1.8;

  int vision_maxlines = 18;

  double milestone_spacer = 0.02;

  double milestone_fontSize = 30;

  double edit_btn_cont_width = 0.48;

  double edit_btn_top_margin = 0.02;

  double edit_btn_width = 85;

  double edit_btn_height = 30;

  double edit_btn_iconSize = 15;

  double edit_btn_fontSize = 15;

  EditVision() {
    final param = jsonEncode({
      'type': 'update',
      'user_id': user_id,
      'is_admin': is_admin,
    });

    Get.toNamed(create_business_vision_url, parameters: {'data': param});
  }

  EditMilestone() {
    final param = jsonEncode({
      'type': 'update',
      'user_id': user_id,
      'is_admin': is_admin,
    });
    Get.toNamed(create_business_milestone_url, parameters: {'data': param});
  }

  //////////////////////////////////
  // GET REQUIREMENTS :
  //////////////////////////////////
  GetLocalStorageData() async {
    startup_id = await detailViewState.GetStartupId();
    user_id = await detailViewState.GetFounderId();
    is_admin = await detailViewState.GetIsUserAdmin();

    try {
      final vision =
          await startupConnect.FetchBusinessVision(user_id: user_id);
      final_data = vision['data']['vision'];

      return final_data;
    } catch (e) {
      return final_data;
    }
  }

  @override
  Widget build(BuildContext context) {
    page_width = 0.80;

    vision_page_width = 0.50;

    vision_page_height = 0.38;

    heading_top_spacer = 0.01;

  

    headingfonSize = 30;

    edit_btn_top_spacer = 0.01;

    edit_btn_bottom_spacer = 0.01;

    vision_elevation = 1;

    vision_card_left_radius = 15;

    vision_card_right_radius = 15;

    vision_cont_width = 0.45;
    
    vision_cont_height = 0.40; 

    vision_cont_padding = 20;

    vison_text_fontSize = 14;

    vision_text_lineHeight = 1.8;

    vision_maxlines = 18;

    milestone_spacer = 0.02;

    milestone_fontSize = 30;

    edit_btn_cont_width = 0.48;

    edit_btn_top_margin = 0.02;

    edit_btn_width = 85;

    edit_btn_height = 30;

    edit_btn_iconSize = 15;

    edit_btn_fontSize = 15;

    // DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.50;

      vision_cont_height = 0.40; 

      vision_cont_padding = 20;

      vison_text_fontSize = 14;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;

      edit_btn_cont_width = 0.48;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 85;

      edit_btn_height = 30;

      edit_btn_iconSize = 15;

      edit_btn_fontSize = 15;
      print(' 1700');
    }

    // DEFAULT :
    if (context.width < 1600) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.55;

      vision_cont_padding = 20;

      vison_text_fontSize = 14;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;


      edit_btn_cont_width = 0.55;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 85;

      edit_btn_height = 28;

      edit_btn_iconSize = 14;

      edit_btn_fontSize = 14;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.60;
      
      vision_cont_height = 0.40; 

      vision_cont_padding = 20;

      vison_text_fontSize = 14;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;


      edit_btn_cont_width = 0.60;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;

      edit_btn_height = 28;

      edit_btn_iconSize = 13;

      edit_btn_fontSize = 13;
      print('1500');
    }

    if (context.width < 1200) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.65;
      
      vision_cont_height = 0.40; 

      vision_cont_padding = 20;

      vison_text_fontSize = 14;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;


      edit_btn_cont_width = 0.70;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;

      edit_btn_height = 28;

      edit_btn_iconSize = 13;

      edit_btn_fontSize = 13;
      print('1200');
    }

    if (context.width < 1000) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.85;
      
      vision_cont_height = 0.38; 

      vision_cont_padding = 20;

      vison_text_fontSize = 14;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;


      edit_btn_cont_width = 0.85;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;

      edit_btn_height = 28;

      edit_btn_iconSize = 13;

      edit_btn_fontSize = 13;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
            page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 30;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.85;
      
      vision_cont_height = 0.38; 

      vision_cont_padding = 20;

      vison_text_fontSize = 13;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.02;

      milestone_fontSize = 30;


      edit_btn_cont_width = 0.85;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;

      edit_btn_height = 28;

      edit_btn_iconSize = 13;

      edit_btn_fontSize = 13;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      page_width = 0.80;

      vision_page_width = 0.50;

      vision_page_height = 0.38;

      heading_top_spacer = 0.01;

      headingfonSize = 25;

      edit_btn_top_spacer = 0.01;

      edit_btn_bottom_spacer = 0.01;

      vision_elevation = 1;

      vision_card_left_radius = 15;

      vision_card_right_radius = 15;

      vision_cont_width = 0.85;
      
      vision_cont_height = 0.38; 

      vision_cont_padding = 20;

      vison_text_fontSize = 13;

      vision_text_lineHeight = 1.8;

      vision_maxlines = 18;

      milestone_spacer = 0.01;

      milestone_fontSize = 25;


      edit_btn_cont_width = 0.85;

      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;

      edit_btn_height = 28;

      edit_btn_iconSize = 12;

      edit_btn_fontSize = 12;
      
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    //////////////////////////////////
    // SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Startup Vision',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

//////////////////////////////////////////
  /// Main Method :
//////////////////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
      width: context.width * page_width,
      child: Container(
        width: context.width * vision_page_width,
        height: context.height * vision_page_height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADING :
              SizedBox(
                height: context.height * heading_top_spacer,
              ),

              StartupHeaderText(
                title: 'Vision',
                font_size: headingfonSize,
              ),

              SizedBox(
                height: context.height * edit_btn_top_spacer,
              ),

              // EDIT BUTTON :
              EditButton(context, EditVision),

              SizedBox(
                height: context.height * edit_btn_bottom_spacer,
              ),

              // VISION TEXT:
              ClipPath(
                child: Card(
                  elevation: 1,
                  shadowColor: shadow_color1,
                 
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(vision_card_left_radius),
                    right: Radius.circular(vision_card_right_radius),
                  )),
                 
                  child: Container(
                      width: context.width * vision_cont_width,
                      height: context.height * vision_cont_height,
                  
                      padding: EdgeInsets.all(vision_cont_padding),
                      decoration: BoxDecoration(
                          border: Border.all(color: border_color),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(vision_card_left_radius),
                              right: Radius.circular(vision_card_left_radius))),
                      
                      child: SingleChildScrollView(
                        child: RichText(
                         text: TextSpan(
                              text: final_data,
                              style: GoogleFonts.openSans(
                                  color: light_color_type3,
                                  fontSize: vison_text_fontSize,
                                  height: vision_text_lineHeight,
                                  fontWeight: FontWeight.w600)),
                          
                                
                          // maxLines: vision_maxlines,
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: context.height * milestone_spacer,
              ),

              // MILESTONES WIDGET:
              StartupHeaderText(
                title: 'Milestone',
                font_size: milestone_fontSize,
              ),

              SizedBox(
                height: context.height * milestone_spacer,
              ),

              // EDIT MILESTONE BUTTON:
              EditButton(context, EditMilestone),

              SizedBox(
                height: context.height * milestone_spacer,
              ),

              // MILESTONES :
              StartupMileStone()
            ],
          ),
        ),
      ),
    );
  }

  Container EditButton(BuildContext context, Function Edit) {
    return Container(
        width: context.width * edit_btn_cont_width,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: context.height * edit_btn_top_margin),
        child: Container(
          width: edit_btn_width,
          height: edit_btn_height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                Edit();
              },
              icon: Icon(
                Icons.edit,
                size: edit_btn_iconSize,
              ),
              label: Text(
                'Edit',
                style: TextStyle(fontSize: edit_btn_fontSize),
              )),
        ));
  }
}
