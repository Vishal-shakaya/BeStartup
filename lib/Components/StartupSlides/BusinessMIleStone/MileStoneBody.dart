import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/MileStoneStore.dart';
import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/AddMileButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/MileStoneTag.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MileStoneBody extends StatefulWidget {
  const MileStoneBody({Key? key}) : super(key: key);

  @override
  State<MileStoneBody> createState() => _MileStoneBodyState();
}

class _MileStoneBodyState extends State<MileStoneBody> {
  double mile_cont_width = 0.70;
  double mile_cont_height = 0.70;

  double list_tile_width = 0.4;
  double list_tile_height = 0.30;

  double addbtn_top_margin = 0.05;

  double subhead_sec_width = 400;
  double subhead_sec_height = 80;

  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    /// RESPONSIVE BREAK  POINTS :
    /// DEFAULT 1500 :
    /// ///////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      print('greator then 1500');
       mile_cont_width = 0.70;
       mile_cont_height = 0.70;

       list_tile_width = 0.4;
       list_tile_height = 0.30;

       addbtn_top_margin = 0.05;

       subhead_sec_width = 400;
       subhead_sec_height = 80;
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {print('1200');}

    if (context.width < 1000) {print('1000');}

    // TABLET :
    if (context.width < 800) {print('800');}
    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
      list_tile_width = 0.6;
      }

    // PHONE:
    if (context.width < 480) {print('480');}

    var milestones = mileStore.GetMileStonesList();
    print(milestones);
    return Column(
      children: [
        Container(
            width: context.width * mile_cont_width,
            height: context.height * mile_cont_height,
            child: Column(children: [
              // SUBHEADING SECTION :
              SubHeadingSection(context),

              // ADD TAG BUTTON :
              AddMileButton(),

              //////////////////////////////
              // LIST OF TAGS :
              // 1.Show milestone Info:
              // 2.Delete milestone :
              // 3.Edit MileStone :
              //////////////////////////////
              Container(
                  width: context.width * list_tile_width,
                  height: context.height * list_tile_height,
                  margin: EdgeInsets.only(top: 10),
                  child: Obx(
                    () {
                      return ListView.builder(
                          itemCount: milestones.length,
                          itemBuilder: (context, intex) {
                            return MileStoneTag(
                              milestone: milestones[intex],
                              index: intex,
                              key: UniqueKey(),
                            );
                          });
                    },
                  ))
            ])),

            BusinessSlideNav(slide:SlideType.milestone)
      ],
    );
  }

  ////////////////////////
  /// SUBHEADING SECTION :
  /// /////////////////////
  Column SubHeadingSection(BuildContext context) {
    return Column(
      children: [
        // Important note :
        AutoSizeText('Why Milestone,s Important!',
            style: Get.textTheme.headline2),

        SafeArea(
          child: Container(
              alignment: Alignment.topCenter,
              width:  subhead_sec_width,
              height: subhead_sec_height,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              // Decoration:
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10))),
              child: AutoSizeText.rich(
                TextSpan(children: [
                  TextSpan(
                      text: milestone_subHeading_text,
                      style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black))
                ]),
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
