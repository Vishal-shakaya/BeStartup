import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum SlideType {
  detail,
  thumbnail,
  vision,
  milestone,
  catigory,
  product,
  whyInvest,
  pitch 
}

class BusinessSlideNav extends StatefulWidget {
  Function? submitform;
  SlideType? slide;
  BusinessSlideNav({this.submitform, this.slide, Key? key}) : super(key: key);

  @override
  State<BusinessSlideNav> createState() => _BusinessSlideNavState();
}

class _BusinessSlideNavState extends State<BusinessSlideNav> {
  var slide_width = 0.50;

  BackWordButton(slide) {
    // 1. Detail view:
    if (slide == SlideType.detail) {
      Get.toNamed(user_registration_url);
    }
    // 2.BusinessDetail view <- Null  view :
    if (slide == SlideType.thumbnail) {
      Get.toNamed(create_business_detail_url);
    }
    // 3.Business Thumbnail view <- Detail view :
    if (slide == SlideType.vision) {
      Get.toNamed(create_business_thumbnail_url);
    }
    // 4.BusinessVision view <- Vision view :
    if (slide == SlideType.catigory) {
      Get.toNamed(create_business_vision_url);
    }
    // 5.BusinessCatigory view <- Catigory view :
    if (slide == SlideType.product) {
      Get.toNamed(create_business_catigory_url);
    }

    // BusinessProduct <= Why Invest  :
    if (slide == SlideType.whyInvest) {
      Get.toNamed(create_business_product_url);
    }

    if (slide == SlideType.pitch) {
      Get.toNamed(create_business_whyInvest_url);
    }

    // 6. Business Product view <- Product view :
    if (slide == SlideType.milestone) {
      Get.toNamed(create_business_whyInvest_url);
    }
  }



  ForwordButton(slide) {
    // 1. Detail view -> Thumbnail  view : :
    if (slide == SlideType.detail) {
      // Get.toNamed(create_business_thumbnail_url);
      widget.submitform!();
    }
    // 2.Thumbnail view -> Vision  view :
    if (slide == SlideType.thumbnail) {
      Get.toNamed(create_business_vision_url);
    }
    // 2.Thumbnail view -> Catigory view :
    if (slide == SlideType.vision) {
      widget.submitform!();
      // Get.toNamed(create_business_catigory_url);
    }
    // 2.Thumbnail view -> Product view :
    if (slide == SlideType.catigory) {
      widget.submitform!();
    }
    // 2.Thumbnail view -> Milestone view :
    if (slide == SlideType.product) {
      widget.submitform!();
    }

    if (slide == SlideType.whyInvest) {
      widget.submitform!();
    }

    if (slide == SlideType.pitch) {
      widget.submitform!();
    }

    // 2.Thumbnail view -> Null view :
    if (widget.slide == SlideType.milestone) {
      widget.submitform!();
      // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    slide_width = 0.50;

    Widget backButton = TextButton(
        onPressed: () {
          BackWordButton(widget.slide);
        },
        child: Text(
          'BACK',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          color: next_back_btn_color),
        ));

    Widget nextButton = TextButton(
        onPressed: () {
          ForwordButton(widget.slide);
        },
        child: Text('NEXT', 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: next_back_btn_color)));

    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }


    if (context.width < 1200) {
      print('1200');
      nextButton = Icon(
        Icons.arrow_forward,
        color: next_back_btn_color,
      );

      backButton = Icon(
        Icons.arrow_back,
        color: next_back_btn_color,
      );
    }


    if (context.width < 1000) {
      print('1000');

      nextButton = Icon(
        Icons.arrow_forward,
        color: next_back_btn_color,
      );

      backButton = Icon(
        Icons.arrow_back,
        color: next_back_btn_color,
      );

      slide_width = 0.65;
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
      slide_width = 0.70;
    }

    // PHONE:
    if (context.width < 480) {
      slide_width = 0.70;
      print('480');
    }

    return Container(
      width: context.width * slide_width,
      height: context.height * 0.15,
      child: Row(
        children: [
          // Back Button:
          Expanded(flex: 1, child: backButton),

          // Animation:
          Expanded(
              flex: 8,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('progress indicatior')],
                ),
              )),

          // NextSlideButton
          Expanded(flex: 1, child: nextButton),
        ],
      ),
    );
  }
}
