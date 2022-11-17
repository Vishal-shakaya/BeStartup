import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionOne.dart';
import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionTwo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticDetailSectionBody extends StatelessWidget {
  var pixels;
  StaticDetailSectionBody({required this.pixels, Key? key}) : super(key: key);

  double static_cont_width = 0.60;
  double static_cont_height = 0.25;
  double static_margin_bottom = 0.08;

  @override
  Widget build(BuildContext context) {
    var horizontalCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
      shadowColor: Colors.blueGrey,
      child: Row(children: [
        // SECTION ONE :
        StaticSectionOne(
          pixels: pixels,
        ),

        // DIVIDER :
        VerticalDivider(),

        // INVESTOR :
        Expanded(
            child: Container(
          child: StatiSectionTwo(),
        )),
      ]),
    );


    var verticalCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
      shadowColor: Colors.blueGrey,
      child: Column(children: [

        // INVESTOR :
        Expanded(
            child: Container(
              child: StatiSectionTwo(),
        )),


        // DIVIDER :
        Divider(),
        
        
        // SECTION ONE :
        StaticSectionOne(
          pixels: pixels,
        ),

      ]),
    );

    var mainCard = horizontalCard;

    static_cont_width = 0.60;
    static_cont_height = 0.25;
    static_margin_bottom = 0.08;

    // DEFAULT :
    if (context.width > 1700) {
      mainCard = horizontalCard;
      static_cont_width = 0.60;
      static_cont_height = 0.25;
      static_margin_bottom = 0.08;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      mainCard = horizontalCard;
      
      print('1700');
    }

    if (context.width < 1600) {
      static_cont_width = 0.60;
      static_cont_height = 0.27;
      static_margin_bottom = 0.08;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      static_cont_width = 0.64;
      static_cont_height = 0.30;
      static_margin_bottom = 0.08;
      print('1500');
    }

    if (context.width < 1400) {
      print('1400');
    }
    if (context.width < 1300) {
      static_cont_width = 0.65;
      static_cont_height = 0.33;
      static_margin_bottom = 0.08;
      print('1300');
    }
    if (context.width < 1200) {
      static_cont_width = 0.67;
      static_cont_height = 0.35;
      static_margin_bottom = 0.08;
      print('1200');
    }

    if (context.width < 1000) {
      static_cont_width = 0.70;
      static_cont_height = 0.43;
      static_margin_bottom = 0.08;
      print('1000');
    }

    // TABLET :
    if (context.width < 900) {
      static_cont_width = 0.85;
      static_cont_height = 0.45;
      static_margin_bottom = 0.08;
      mainCard = horizontalCard;
    }
    if (context.width < 800) {
      // static_cont_width = 0.60;
      // static_cont_height = 1;
      // static_margin_bottom = 0.01;
      print('800');
    }
    if (context.width < 700) {
      static_cont_width = 0.90;
      static_cont_height = 0.50;
      static_margin_bottom = 0.01;
      print('700');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      // static_cont_width = 0.60;
      // static_cont_height = 1;
      // static_margin_bottom = 0.01;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      static_cont_width = 0.99;
      static_cont_height = 0.50;
      static_margin_bottom = 0.01;
      print('480');
    }

    return AnimatedOpacity(
      duration: Duration(milliseconds: 1100),
      opacity: pixels >= 3900 ? 1.0 : 0.0,
      child: Container(
        margin: EdgeInsets.only(
            top: context.height * 0.01,
            bottom: context.height * static_margin_bottom),
        width: context.width * static_cont_width,
        height: context.width * static_cont_height,
        alignment: Alignment.center,
        child: mainCard
      ),
    );
  }
}
