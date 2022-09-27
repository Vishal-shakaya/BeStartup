import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class StartupNavigation extends StatefulWidget {
  StartupPageRoute? route;
  String? title;
  StartupNavigation({required this.route, required this.title, Key? key})
      : super(key: key);

  @override
  State<StartupNavigation> createState() => _StartupNavigationState();
}

class _StartupNavigationState extends State<StartupNavigation> {
 
  double tab_fontSize = 20;
 
  double tab_padding_hor = 20;

  double tab_padding_ver = 14; 

  double tab_left_radius = 10; 

  double tab_right_radius = 10 ; 

  // MANAGE ROUTE :
  SubmitRoute(route) {
    if (route == StartupPageRoute.team) {
      Get.toNamed(
        team_page_url,
      );
    }
    if (route == StartupPageRoute.invest) {
      Get.toNamed(
        invest_page_url,
      );
    }
    if (route == StartupPageRoute.vision) {
      Get.toNamed(vision_page_url);
    }
  }

  @override
  Widget build(BuildContext context) {

    tab_fontSize = 20;
     
    tab_padding_hor = 20;

    tab_padding_ver = 14; 

    tab_left_radius = 10; 

    tab_right_radius = 10 ; 

    // DEFAULT :
    if (context.width > 1700) {
      tab_fontSize = 20;

      tab_padding_hor = 20;

      tab_padding_ver = 14; 
      print('1700');
    }
    // DEFAULT :
    if (context.width < 1700) {
      print('1700');
    }

    // DEFAULT :
    if (context.width < 1600) {
      tab_fontSize = 19;

      tab_padding_hor = 18;

      tab_padding_ver = 14; 
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
        tab_fontSize = 18;

        tab_padding_hor = 18;

        tab_padding_ver = 13; 
      print('1500');
    }

    if (context.width < 1300) {
      print('1300');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
        tab_fontSize = 16;

        tab_padding_hor = 17;

        tab_padding_ver = 12; 
        print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
        tab_fontSize = 14;

        tab_padding_hor = 14;

        tab_padding_ver = 10; 
        print('640');
    }
    if (context.width < 550) {
        tab_fontSize = 13;

        tab_padding_hor = 10;

        tab_padding_ver = 7; 
        print('550');
    }

    // PHONE:
    if (context.width < 480) {
        tab_fontSize = 12;

        tab_padding_hor = 6;

        tab_padding_ver = 4; 

        tab_left_radius = 4; 

        tab_right_radius = 4 ;
        print('480');
    }

    return InkWell(
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
      onTap: () {
        SubmitRoute(widget.route);
      },
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: tab_padding_hor, 
            vertical: tab_padding_ver),
          decoration: BoxDecoration(
            border: Border.all(color: tab_border_color),
            borderRadius:  BorderRadius.horizontal(
              left: Radius.circular(tab_left_radius),
              right: Radius.circular(tab_right_radius),
            ),
          ),
          child: AutoSizeText.rich(TextSpan(
              text: widget.title,
              style: GoogleFonts.robotoSlab(
                textStyle: TextStyle(),
                color: tab_color,
                fontSize: tab_fontSize,
                fontWeight: FontWeight.bold,
              )))),
    );
    ;
  }
}
