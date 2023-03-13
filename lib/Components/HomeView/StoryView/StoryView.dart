import 'package:be_startup/Components/HomeView/StoryView/SaveStoryButton.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryCeoProfile.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryHeading.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryMileStone.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryThumbnail.dart';
import 'package:be_startup/Components/HomeView/StoryView/ViewStoryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryView extends StatefulWidget {
  var startup_name;
  var user_id;
  StoryView({
    required this.startup_name,
    required this.user_id,
    Key? key,
  }) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  double header_section_height = 0.35;

  @override
  Widget build(BuildContext context) {
    print('Main Id ${widget.user_id}');

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
                      user_id: widget.user_id,
                    ),

                    // STARTUP CEO  PROFILE WITH NAME :
                    StoryCeoProfile(
                      user_id: widget.user_id,
                    ),

                    // STARTUP NAME OR HEADING :
                    StoryHeading(
                      startup_name: widget.startup_name,
                    ),

                    // INFO MINI CHART :
                    // StoryInfoChart(),
                    ViewStoryButton(
                      user_id: widget.user_id,
                    )
                  ],
                ),
              ),

              // MILESTONES:
              StoryMileStone(
                user_id: widget.user_id,
              ),

              // SAVE BUTTON :
              SaveStoryButton(
                user_id: widget.user_id,
              )
            ],
          ),
        ),
      ),
    );
  }
}
