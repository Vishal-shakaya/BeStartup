import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoHeading extends StatelessWidget {
  String? heading_text = '';
  InfoHeading({this.heading_text});

  double top_margin = 40;
  double bottom_margin = 60;
  double font_size = 40; 


  @override
  Widget build(BuildContext context) {
		// DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
      }
  
    if (context.width < 1700) {
      print('1700');
      }
  
    if (context.width < 1600) {
      print('1600');
      }

    // PC:
    if (context.width < 1500) {
      print('1500');
      }

    if (context.width < 1200) {
      print('1200');
      }
    
    if (context.width < 1000) {
      print('1000');
      }

    // TABLET :
    if (context.width < 800) {
      print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
      print('480');
      }

    return Container(
        margin:  EdgeInsets.only(top: top_margin, bottom: bottom_margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$heading_text',
              style: GoogleFonts.merriweather(
                textStyle: TextStyle(),
                color: login_page_heading_color,
                fontSize: font_size,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            )
          ],
        ));
  }
}
