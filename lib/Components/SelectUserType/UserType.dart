import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserOption { founder, investor }

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  Color? unselect_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type2;
  Color? select_color = Get.isDarkMode ? tealAccent : primary_light;
  Color? founder_bottom_heading =
      Get.isDarkMode ? dartk_color_type4 : light_color_type2;
  Color? investor_bottom_heading =
      Get.isDarkMode ? dartk_color_type4 : light_color_type2;
  Color? card_hover_color =
      Get.isDarkMode ? tealAccent.withOpacity(0.3) : Colors.blueGrey.shade50;

  String? selected_user_type = null;

  ///////////////////////////////////////
  // CARD AND BUTTON  :
  // 1. WIDTH AND HEIGHT :
  ///////////////////////////////////////
  double card_width = 300;
  double card_height = 430;
  double card_padding = 20;

  double body_cont_height = 570;
  double body_cont_width = 10;

  double con_button_width = 130;
  double con_button_height = 45;
  double con_btn_top_margin = 30;

  double heading_col_height = 0.2;
  double heading_font_size = 35;
  double heading_text_top_mar = 0;

  double bottom_heading_text_size = 27;
  ///////////////////////////////////////////
  /// HANDLER :
  /// 1.CHECK SELECT USER TYPE :
  /// 2. REDIRECT TO SLIDE PAGE :
///////////////////////////////////////////
  OnpressContinue(context) {
    // REQUIRED TO SELECT USER TYPE:
    if (selected_user_type == null) {
      CoolAlert.show(
          context: context,
          width: 200,
          title: 'Select option!',
          type: CoolAlertType.info,
          widget: Text(
            'You has to be Investor or Founder',
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
                fontWeight: FontWeight.bold),
          ));
    }

    // REDIRECT TO CREATE STARTUP PAGE :
    if (selected_user_type == 'founder') {
      // Get.toNamed(startup_slides_url ,preventDuplicates: false);
      Get.toNamed(create_business_detail_url ,preventDuplicates: false);
    }

    // REDIERCT TO STARTUPS VIEW:
    if (selected_user_type == 'investor') {
      print('User Type investor');
      Get.toNamed(investor_registration_form ,preventDuplicates: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////
    // BREAKPOINTS :
    // 1. TAB SIZE :
    // WIDTH : 800 ,650 , 600
    // HEIGHT: 850,700
    ///////////////////////////////////////
    if (context.width < 800) {
      card_width = 250;
      card_height = 300;
      body_cont_height = 500;
    }
    if (context.width > 800) {
      card_width = 300;
      card_height = 430;
      body_cont_height = 570;
    }

    if (context.width < 650) {
      card_width = 220;
      card_height = 250;
      body_cont_height = 450;
    }

    if (context.height < 850) {
      card_width = 220;
      card_height = 300;
      body_cont_height = 450;
    }
    if (context.height < 700) {
      card_width = 220;
      card_height = 250;
      body_cont_height = 400;
    }

    if (context.width < 600) {
      card_width = 210;
      card_height = 250;
      body_cont_height = 400;
      card_padding = 10;
    }
    if (context.height < 700 && context.width < 600) {
      card_width = 170;
      card_height = 200;
      body_cont_height = 300;
      card_padding = 10;
    }

    if (context.height < 550 && context.width < 600) {
      card_width = 150;
      card_height = 150;
      body_cont_height = 250;
      card_padding = 5;
    }

    // PHONE :
    if (context.width < 450) {
      heading_col_height = 0.3;
      heading_font_size = 30;
      bottom_heading_text_size = 20;
      con_btn_top_margin = 40;
      card_width = 150;
      card_height = 220;
      body_cont_height = 300;
      card_padding = 9;
      heading_text_top_mar = 30;
    }

    SelectUserType(option) {
      print('selected');
      setState(() {
        // 1. SELECT FOUNDER LOGIC:
        // 2. UNSELECT INVESTOR :
        if (UserOption.founder == option) {
          founder_bottom_heading = select_color;
          investor_bottom_heading = unselect_color;
          selected_user_type = 'founder';

          // 1. SELECT INVESTOR LOGIC:
          // 2. UNSELECT FOUNDER
        } else if (UserOption.investor == option) {
          investor_bottom_heading = select_color;
          founder_bottom_heading = unselect_color;
          selected_user_type = 'investor';
        }
      });
    }

    return Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ///////////////////////////////
        // Heading Section :
        ///////////////////////////////
        Container(
          height: context.height * heading_col_height,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(top: heading_text_top_mar),
              child: RichText(
                  text: TextSpan(style: Get.textTheme.headline3, children: [
                TextSpan(
                    text: user_type_heading,
                    style: TextStyle(fontSize: heading_font_size))
              ])),
            )
          ]),
        ),

        ////////////////////////////////
        /// BODY SECTION :
        ////////////////////////////////
        Container(
            height: body_cont_height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //////////////////////////////////
                // FOUNDER SECTION :
                //////////////////////////////////
                Container(
                  padding: EdgeInsets.all(card_padding),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    onTap: () {
                      SelectUserType(UserOption.founder);
                    },
                    hoverColor: card_hover_color,
                    child: Card(
                      elevation: 10,
                      shadowColor: primary_light,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2,
                              )),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // IMAGE SECTION :
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      reg_founder_image,
                                      width: card_width,
                                      height: card_height,
                                      fit: BoxFit.contain,
                                    )),

                                // BOTTOM TEXT :
                                Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: RichText(
                                        text: TextSpan(
                                            style: Get.textTheme.headline3,
                                            children: [
                                          TextSpan(
                                              text: 'Founder',
                                              style: TextStyle(
                                                  color: founder_bottom_heading,
                                                  fontSize:
                                                      bottom_heading_text_size))
                                        ])))
                              ],
                            ),
                          )),
                    ),
                  ),
                ),

                //////////////////////////////
                // INVESTOR SECTION :
                //////////////////////////////
                Container(
                    
                  padding: EdgeInsets.all(card_padding),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    onTap: () {
                      SelectUserType(UserOption.investor);
                    },
                    hoverColor: card_hover_color,
                    child: Card(
                      elevation: 10,
                      shadowColor: primary_light,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                          decoration: BoxDecoration(
                              // color:Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2,
                              )),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // IMAGE SECTION :
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      reg_investor_image,
                                      width: card_width,
                                      height: card_height,
                                      fit: BoxFit.contain,
                                    )),

                                // BOTTOM TEXT :
                                Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: RichText(
                                        text: TextSpan(
                                            style: Get.textTheme.headline3,
                                            children: [
                                          TextSpan(
                                              text: 'Investor',
                                              style: TextStyle(
                                                  color:
                                                      investor_bottom_heading,
                                                  fontSize:
                                                      bottom_heading_text_size))
                                        ])))
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              ],
            )),

        // CONTINUE  BUTTON :
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
            child: InkWell(
              highlightColor: primary_light_hover,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20), right: Radius.circular(20)),
              onTap: () {
                OnpressContinue(context);
              },
              child: Card(
                elevation: 10,
                shadowColor: light_color_type3,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  width: con_button_width,
                  height: con_button_height,
                  decoration: BoxDecoration(
                      color: primary_light,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20))),
                  child: Text(
                    'continue',
                    style: TextStyle(
                        letterSpacing: 2.5,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
