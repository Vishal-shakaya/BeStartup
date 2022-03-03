import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/MileStoneStore.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/AddMileButton.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/MileStoneTag.dart';
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
  double mile_cont_height = 0.90;

  double list_tile_width = 0.4;
  double list_tile_height = 0.30;

  double addbtn_top_margin = 0.05;

  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');

  @override
  Widget build(BuildContext context) {
    var milestones = mileStore.GetMileStonesList();
    print(milestones);
    return Container(
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
        ]));
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

        Container(
            alignment: Alignment.topCenter,
            width: context.width * 0.2,
            height: context.height * 0.09,
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
      ],
    );
  }
}
