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
  // MANAGE ROUTE :
  SubmitRoute(route) {
    if (route == StartupPageRoute.team) {
      Get.toNamed(team_page_url, );
    }
    if (route == StartupPageRoute.invest) {
      Get.toNamed(invest_page_url, );
    } 
    if (route == StartupPageRoute.vision) {
      Get.toNamed(vision_page_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SubmitRoute(widget.route);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
              right: Radius.circular(10),
            ),
          ),
          child: AutoSizeText.rich(TextSpan(
              text: widget.title,
              style: GoogleFonts.robotoSlab(
                textStyle: TextStyle(),
                color: light_color_type4,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )))),
    );
    ;
  }
}
