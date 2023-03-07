import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/StartupState.dart';

import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({Key? key}) : super(key: key);

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  var startupConnector =
      Get.put(StartupViewConnector(), tag: "startup_connector");
  var detailViewState = Get.put(StartupDetailViewState());

  var why_text;

  double notice_cont_width = 0.20;

  double notice_block_padding = 20;

  double invest_btn_width = 300;

  double invest_btn_height = 50;

  double invest_btn_fontSize = 22;

  double invest_btn_letterSpacing = 2.5;

  double invest_btn_left_radius = 20;

  double page_width = 0.80;

  double invest_page_width = 0.50;

  double invest_page_height = 0.38;

  double invest_btn_elevation = 10;

  double invest_btn_cont_padd = 5;

  double heading_space = 0.01;

  double header_text_fontSize = 30;

  double subheading_text = 15;

  double inves_text_top_space = 0.02;

  double terms_text_fontSize = 19;

  double desc_bottom_sapce = 0.05;

  double edit_btn_width = 0.48;

  double edit_btn_cont_width = 90;

  double edit_btn_cont_height = 30;

  double edit_btn_icon_size = 15;

  double notce_cont_radius = 10;

  double desc_box_elevation = 1;

  double desc_box_left_radius = 15;

  double desc_box_right_radius = 15;

  double desc_box_cont_width = 0.45;

  double desc_box_cont_height = 0.22;

  double desc_box_padd = 20;

  double desc_box_radius = 15;

  double desc_box_fontSize = 15;

  double desc_box_height = 1.8;

  double desc_max_lines = 6; 

  double notice_fontSize = 14; 

  var startup_id;
  var user_id;
  var is_admin;

  EditInvestment() {
    var param = jsonEncode({
      'type': 'update',
      'user_id': user_id,
      'is_admin': is_admin,
    });

    Get.toNamed(create_business_whyInvest_url, parameters: {'data': param});
  }

  ////////////////////////////////
  /// GET REQUIREMENTS :
  ////////////////////////////////
  GetLocalStorageData() async {
    is_admin = await detailViewState.GetIsUserAdmin();
    user_id = await detailViewState.GetFounderId();

    try {
      final resp =
          await startupConnector.FetchBusinessWhy(user_id: user_id);
      why_text = resp['data']['why_text'];
      return why_text;
    } catch (e) {
      return why_text;
    }
  }

  @override
  Widget build(BuildContext context) {
     notice_fontSize = 14; 
    
     notice_cont_width = 0.20;

     notice_block_padding = 20;

     invest_btn_width = 300;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;

     invest_page_width = 0.50;

     invest_page_height = 0.38;

     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.48;

     edit_btn_cont_width = 90;

     edit_btn_cont_height = 30;

     edit_btn_icon_size = 15;

     notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.45;

     desc_box_cont_height = 0.22;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 15;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1700) {
           notice_cont_width = 0.20;

     notice_block_padding = 20;

     invest_btn_width = 300;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;

     invest_page_width = 0.50;

     invest_page_height = 0.38;

     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.48;

     edit_btn_cont_width = 90;

     edit_btn_cont_height = 30;

     edit_btn_icon_size = 15;

     notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.45;

     desc_box_cont_height = 0.22;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 15;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
    notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     notice_cont_width = 0.25;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.55;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 15;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 20;

     invest_btn_width = 300;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;

     invest_page_width = 0.50;

     invest_page_height = 0.38;

     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.48;

     edit_btn_cont_width = 90;

     edit_btn_cont_height = 30;

     edit_btn_icon_size = 15;


      print('1500');
    }

    if (context.width < 1200) {

     notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     invest_page_width = 0.60;

     invest_page_height = 0.38;

     notice_cont_width = 0.35;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.60;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 14;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 20;

     invest_btn_width = 300;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;


     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.48;

     edit_btn_cont_width = 90;

     edit_btn_cont_height = 30;

     edit_btn_icon_size = 15;
      print('1200');
    }

    if (context.width < 1000) {
      notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     invest_page_width = 0.60;

     invest_page_height = 0.38;

     notice_cont_width = 0.35;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.70;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 14;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 20;

     invest_btn_width = 300;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;


     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.70;

     edit_btn_cont_width = 80;

     edit_btn_cont_height = 25;

     edit_btn_icon_size = 14;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      notice_fontSize = 13;
      notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     invest_page_width = 0.60;

     invest_page_height = 0.38;

     notice_cont_width = 0.40;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.80;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 14;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 18;

     invest_btn_width = 250;

     invest_btn_height = 50;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;


     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.70;

     edit_btn_cont_width = 80;

     edit_btn_cont_height = 25;

     edit_btn_icon_size = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     invest_page_width = 0.60;

     invest_page_height = 0.38;

     notice_cont_width = 0.55;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.90;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 12;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 15;

     invest_btn_width = 220;

     invest_btn_height = 47;

     invest_btn_fontSize = 22;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;


     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 25;

     subheading_text = 14;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.85;

     edit_btn_cont_width = 75;

     edit_btn_cont_height = 25;

     edit_btn_icon_size = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      notice_fontSize = 12;

      notce_cont_radius = 10;

     desc_box_elevation = 1;

     desc_box_left_radius = 15;

     invest_page_width = 0.60;

     invest_page_height = 0.38;

     notice_cont_width = 0.80;

     desc_box_right_radius = 15;

     desc_box_cont_width = 0.90;

     desc_box_cont_height = 0.23;

     desc_box_padd = 20;

     desc_box_radius = 15;

     desc_box_fontSize = 12;

     desc_box_height = 1.8;

     desc_max_lines = 6; 
     

     notice_block_padding = 18;

     invest_btn_width = 200;

     invest_btn_height = 40;

     invest_btn_fontSize = 19;

     invest_btn_letterSpacing = 2.5;

     invest_btn_left_radius = 20;

     page_width = 0.80;


     invest_btn_elevation = 10;

     invest_btn_cont_padd = 5;

     heading_space = 0.01;

     header_text_fontSize = 30;

     subheading_text = 15;

     inves_text_top_space = 0.02;

     terms_text_fontSize = 19;

     desc_bottom_sapce = 0.05;

     edit_btn_width = 0.90;

     edit_btn_cont_width = 60;

     edit_btn_cont_height = 25;

     edit_btn_icon_size = 12;
      print('480');
    }

    ////////////////////////////////
    /// SET REQUIREMENTS :
    ////////////////////////////////
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

  Container MainMethod(BuildContext context) {
    return Container(
      child: Container(
        width: context.width * invest_page_width,
        height: context.height * invest_page_height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADING :
              SizedBox(
                height: context.height * heading_space,
              ),

              StartupHeaderText(
                title: 'Investment',
                font_size: header_text_fontSize,
              ),

              // Edit BUtton
              EditButton(context),

              // SubHeading :
              Container(
                child: StartupHeaderText(
                  title: 'Why you invest in us !',
                  font_size: subheading_text,
                ),
              ),

              SizedBox(
                height: context.height * inves_text_top_space,
              ),

              // VISION TEXT:
              Description(context),

              SizedBox(
                height: context.height * desc_bottom_sapce,
              ),

              StartupHeaderText(
                title: 'Terms & Conditions',
                font_size: terms_text_fontSize,
              ),

              // Notice Section :
              NoticeContainer(context, notice_block_padding, notice_cont_width),

              // Invet Button :
              SizedBox(
                height: context.height * desc_bottom_sapce,
              ),

              InvestButton(invest_btn_width, invest_btn_height)
            ],
          ),
        ),
      ),
    );
  }

  Container EditButton(BuildContext context) {
    return Container(
      width: context.width * edit_btn_width,
      alignment: Alignment.topRight,
      child: Container(
        width: edit_btn_cont_width,
        height: edit_btn_cont_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: border_color)),
        child: TextButton.icon(
            onPressed: () {
              EditInvestment();
            },
            icon: Icon(
              Icons.edit,
              size: edit_btn_icon_size,
            ),
            label: Text(
              'Edit',
              style: TextStyle(fontSize: edit_btn_icon_size),
            )),
      ),
    );
  }

  ClipPath Description(BuildContext context) {
    return ClipPath(
      child: Card(
        elevation: desc_box_elevation,
        shadowColor: shadow_color1,
        
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(desc_box_left_radius),
          right: Radius.circular(desc_box_right_radius),
        )),
       
        child: Container(
            width: context.width * desc_box_cont_width,
            height: context.height*desc_box_cont_height, 

            padding: EdgeInsets.all(desc_box_padd),
            decoration: BoxDecoration(
                border: Border.all(color: border_color),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(desc_box_radius),
                    right: Radius.circular(desc_box_radius))),
           
            child: SingleChildScrollView(
              child: AutoSizeText.rich(
                TextSpan(
                    text: why_text,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type3,
                        fontSize: desc_box_fontSize,
                        height: desc_box_height,
                        fontWeight: FontWeight.w600)),
                style: Get.textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            )),
      ),
    );
  }



  InkWell InvestButton(double invest_btn_width, double invest_btn_height) {
    return InkWell(
      highlightColor: primary_light_hover,
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(invest_btn_left_radius),
          right: Radius.circular(invest_btn_left_radius)),
      onTap: () {},
      child: Card(
        elevation: invest_btn_elevation,
        shadowColor: light_color_type3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(invest_btn_cont_padd),
          width: invest_btn_width,
          height: invest_btn_height,
          decoration: BoxDecoration(
              color: primary_light,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(invest_btn_left_radius),
                  right: Radius.circular(invest_btn_left_radius))),
          child: Text(
            'Invest now',
            style: TextStyle(
                letterSpacing: invest_btn_letterSpacing,
                color: Colors.white,
                fontSize: invest_btn_fontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Container NoticeContainer(
      BuildContext context, notice_block_padding, notice_cont_width) {
    return Container(
      padding: EdgeInsets.all(notice_block_padding),
      margin: EdgeInsets.only(top: context.height * 0.02),
      decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(notce_cont_radius),
              right: Radius.circular(notce_cont_radius))),
      child: Visibility(
          visible: true,
          child: Container(
              width: context.width * notice_cont_width,
              child: AutoSizeText.rich(TextSpan(
                  style: const TextStyle(
                    wordSpacing: 1,
                     color: Colors.black),
                  children: [
                    TextSpan(
                      text: thumbnail_important_text,
                      style: TextStyle(fontSize: notice_fontSize )
                       ), ] ), 
                      textAlign: TextAlign.center,
                      ))),
    );
  }
}
