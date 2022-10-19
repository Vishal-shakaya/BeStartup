import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplainHeaderSection extends StatelessWidget {
  ExplainHeaderSection({Key? key}) : super(key: key);

  double top_margin = 0.05;
  double bottom_margin = 0.02;
  double padd = 10;
  double  font_size = 40; 


  @override
  Widget build(BuildContext context) {

    ////////////////////////////////////
    /// RESPONSIVENESS : 
    ////////////////////////////////////
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
      // width: 100.w,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
          top: context.height * top_margin,
          bottom: context.height * bottom_margin),
      padding: EdgeInsets.all(padd),

        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Get.theme.textTheme.headline1,
            children: [
              TextSpan(
                  text: 'Our Business Tycoon',
                  style: TextStyle(
                    fontSize:font_size, 
                    color:login_page_heading_color)
                  )
            ]),
        ),
    );
  }
}
