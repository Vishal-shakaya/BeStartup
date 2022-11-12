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

  @override
  Widget build(BuildContext context) {
    print('GETTING PIXESL  ${pixels}');

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
              duration: Duration(milliseconds: 2000),
              opacity: pixels >=3900 ? 1.0 : 0.0,

              child: Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: GlowContainer(
                  width: context.width * 0.14,
                  height: context.height * 0.07,
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
                spacing: context.width * 0.07,
                children: [
                  // Investor Text :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: 'INVESTORS')),
            
                  // Number of Investor :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: 38,
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
                spacing: context.width * 0.05,
                children: [
                  // FOUNDER Text :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                          text: 'FOUNDRES')),
            
                  // Number of FOUNDER :
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.robotoSlab(
                            color: light_color_type2,
                            fontSize: 38,
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
