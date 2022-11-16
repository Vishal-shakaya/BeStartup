import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticSectionOne extends StatelessWidget {
  var pixels;
  StaticSectionOne({
    this.pixels,
    Key? key,
  }) : super(key: key);

  double sec_one_card_width = 0.14;
  double sec_one_card_height = 0.07;

  double investor_wrap_spacing = 0.07;
  double investor_fontSize = 25;
  double investor_no_fontSize = 35;

  double founder_spacing = 0.05;
  double founder_fontSize = 25;
  double founder_no_fontSize = 35;

  @override
  Widget build(BuildContext context) {
     sec_one_card_width = 0.14;
     sec_one_card_height = 0.07;

     investor_wrap_spacing = 0.07;
     investor_fontSize = 25;
     investor_no_fontSize = 35;

     founder_spacing = 0.05;
     founder_fontSize = 25;
     founder_no_fontSize = 35;


    // DEFAULT :
    if (context.width > 1700) {
        sec_one_card_width = 0.14;
        sec_one_card_height = 0.07;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 25;
        investor_no_fontSize = 35;

        founder_spacing = 0.05;
        founder_fontSize = 25;
        founder_no_fontSize = 35;
         print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
        sec_one_card_width = 0.14;
        sec_one_card_height = 0.07;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 25;
        investor_no_fontSize = 35;

        founder_spacing = 0.05;
        founder_fontSize = 25;
        founder_no_fontSize = 35;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
        sec_one_card_width = 0.14;
        sec_one_card_height = 0.07;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 22;
        investor_no_fontSize = 30;

        founder_spacing = 0.05;
        founder_fontSize = 22;
        founder_no_fontSize = 30;
      print('1500');
    }

    if (context.width < 1200) {
        sec_one_card_width = 0.16;
        sec_one_card_height = 0.07;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 20;
        investor_no_fontSize = 26;

        founder_spacing = 0.05;
        founder_fontSize = 20;
        founder_no_fontSize = 26;
      print('1200');
    }

    if (context.width < 1000) {
        sec_one_card_width = 0.18;
        sec_one_card_height = 0.07;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 20;
        investor_no_fontSize = 26;

        founder_spacing = 0.05;
        founder_fontSize = 20;
        founder_no_fontSize = 26;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        sec_one_card_width = 0.18;
        sec_one_card_height = 0.06;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 18;
        investor_no_fontSize = 20;

        founder_spacing = 0.05;
        founder_fontSize = 18;
        founder_no_fontSize = 20;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
        sec_one_card_width = 0.18;
        sec_one_card_height = 0.06;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 16;
        investor_no_fontSize = 18;

        founder_spacing = 0.05;
        founder_fontSize = 16;
        founder_no_fontSize = 18;
        print('640');
    }

    // PHONE:
    if (context.width < 480) {
        sec_one_card_width = 0.18;
        sec_one_card_height = 0.06;

        investor_wrap_spacing = 0.07;
        investor_fontSize = 13;
        investor_no_fontSize = 16;

        founder_spacing = 0.05;
        founder_fontSize = 13;
        founder_no_fontSize = 16;
      print('480');
    }

    ////////////////////////////////
    // STARTUP DETAIL SECTION :
    // 1. Investor Static :
    // 2. Founder Static  :
    // 3. StartupIndia Logo :
    ////////////////////////////////

    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Startup Logo :
            AnimatedOpacity(
              duration: Duration(milliseconds: 3000),
              opacity: pixels >= 3900 ? 1.0 : 0.0,
              child: Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: GlowContainer(
                  width: context.width * sec_one_card_width,
                  height: context.height * sec_one_card_height,
                  glowColor: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  padding: EdgeInsets.all(10),
                  child: Image.asset(indian_startup_logo),
                ),
              ),
            ),

            // INVESTOR SECTION :
            Container(
              child: Wrap(
                spacing: context.width * investor_wrap_spacing,
                children: [
                  // Investor Text :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: investor_fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: 'INVESTORS')),

                  // Number of Investor :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: investor_no_fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: '75')),
                ],
              ),
            ),

            ////////////////////////////////
            /// Founder Section :
            ////////////////////////////////
            Container(
              child: Wrap(
                spacing: context.width * founder_spacing,
                children: [
                  // FOUNDER Text :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: founder_fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: 'FOUNDRES')),

                  // Number of FOUNDER :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: founder_no_fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: '20K+'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
