import 'package:be_startup/Components/HomeView/StoryView/StoryCeoProfile.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryHeading.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryMileStone.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryThumbnail.dart';
import 'package:be_startup/Components/HomeView/StoryView/ViewStoryButton.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryView extends StatefulWidget {
  var startup_id;
  var founder_id;
  var startup_name; 
  StoryView({
    Key? key,
    required this.startup_id,
    required this.founder_id,
    required this.startup_name, 
  }) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  double header_section_height = 0.35;
  bool is_saved = false;

  @override
  void initState() {
    // TODO: implement initState
    is_saved = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: context.height * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER SECTION :
              // 1 Thumbnail
              // 2 Ceo Profile :
              // 3 Heading and info Chart with inveest Button :
              Container(
                height: context.height * header_section_height,
                child: Stack(
                  children: [
                    // THUMBNAIL SECTION :
                    StoryThumbnail(
                      startup_id: widget.startup_id,
                    ),

                    // STARTUP CEO  PROFILE WITH NAME :
                    StoryCeoProfile(
                      founder_id: widget.founder_id,
                      startup_id: widget.startup_id,
                    ),

                    // STARTUP NAME OR HEADING :
                    StoryHeading(
                      startup_name: widget.startup_name,
                    ),

                    // INFO MINI CHART :
                    // StoryInfoChart(),
                    ViewStoryButton(
                      founder_id: widget.founder_id,
                      startup_id: widget.startup_id,
                    )
                  ],
                ),
              ),

              // MILESTONES:
              StoryMileStone(),

              // SAVE BUTTON :
              SaveStoryButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Row SaveStoryButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              is_saved ? is_saved = false : is_saved = true;
            });
          },
          child: Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.only(right: context.width * 0.02, top: 5),
              child: is_saved
                  ? const Icon(
                      Icons.bookmark,
                      size: 26,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.bookmark_border_rounded,
                      size: 26,
                      color: Colors.grey,
                    )),
        )
      ],
    );
  }
}

