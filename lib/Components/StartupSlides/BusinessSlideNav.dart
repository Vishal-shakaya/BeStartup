import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SlideType {
  detail,
  thumbnail,
  vision,
  milestone,
  catigory,
  product,
}

class BusinessSlideNav extends StatefulWidget {
  Function? submitform;
  SlideType? slide;
  BusinessSlideNav({this.submitform, this.slide, Key? key})
      : super(key: key);

  @override
  State<BusinessSlideNav> createState() => _BusinessSlideNavState();
}

class _BusinessSlideNavState extends State<BusinessSlideNav> {
  BackWordButton(slide) {
    // 1. Detail view:
    if (slide == SlideType.detail) {
      Get.toNamed(user_registration_url);
    }
    // 2.Thumbnail view <- Null  view :
    if (slide == SlideType.thumbnail) {
      Get.toNamed(create_business_detail_url);
    }
    // 2.Thumbnail view <- Detail view :
    if (slide == SlideType.vision) {
      Get.toNamed(create_business_thumbnail_url);
    }
    // 2.Thumbnail view <- Vision view :
    if (slide == SlideType.catigory) {
      Get.toNamed(create_business_vision_url);
    }
    // 2.Thumbnail view <- Catigory view :
    if (slide == SlideType.product) {
      Get.toNamed(create_business_catigory_url);
    }

    // 2.Thumbnail view <- Product view :
    if (slide == SlideType.milestone) {
      Get.toNamed(create_business_product_url);
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
      Get.toNamed(create_business_product_url);
    }
    // 2.Thumbnail view -> Milestone view :
    if (slide == SlideType.product) {
      Get.toNamed(create_business_milestone_url);
    }

    // 2.Thumbnail view -> Null view :
    if (widget.slide == SlideType.milestone) {
         widget.submitform!();
      // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.50,
      height: context.height*0.15,
      child: Row(
        children: [
          // Back Button:
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    BackWordButton(widget.slide);
                  },
                  child: Text('BACK'))),

          // Animation:
          Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('progress indicatior')],
                ),
              )),

          // NextSlideButton
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    ForwordButton(widget.slide);
                  },
                  child: Text('NEXT'))),
        ],
      ),
    );
  }
}
