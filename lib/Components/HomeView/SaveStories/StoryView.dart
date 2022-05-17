import 'package:be_startup/Components/HomeView/SaveStories/StoryCeoProfile.dart';
import 'package:be_startup/Components/HomeView/SaveStories/StoryHeading.dart';
import 'package:be_startup/Components/HomeView/SaveStories/StoryMileStone.dart';
import 'package:be_startup/Components/HomeView/SaveStories/StoryThumbnail.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveStories extends StatefulWidget {
  const SaveStories({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveStories> createState() => _SaveStoriesState();
}

class _SaveStoriesState extends State<SaveStories> {
  double header_section_height = 0.35;
  bool is_saved = true;

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
                  SaveStoryThumbnail(),

                  // STARTUP CEO  PROFILE WITH NAME :
                  SaveStoryCeoProfile(),

                  // STARTUP NAME OR HEADING :
                  SaveStoryHeading(),

                  // INFO MINI CHART :
                  // StoryInfoChart(),
                  InvestButton(context)
                ],
              ),
            ),

            // MILESTONES:
            SaveStoryMileStone(),

            // SAVE BUTTON :
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      is_saved ? is_saved=false : is_saved=true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                    margin:
                        EdgeInsets.only(right: context.width * 0.02, top: 5),
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
            )
          ],
        ),
      ),
    );
  }

  Positioned InvestButton(BuildContext context) {
    return Positioned(
                  top: context.height * 0.23,
                  left: context.width * 0.38,
                  child: Container(
                      // width: context.width * 0.48,
                      alignment: Alignment.topRight,
                      // margin: EdgeInsets.only(top: context.height*0.04),
                      child: Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: primary_light2)),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.currency_rupee_sharp,
                              size: 15,
                              color: Colors.teal.shade500,
                            ),
                            label: Text(
                              'Invest',
                              style: TextStyle(color: Colors.teal.shade500),
                            )),
                      )),
                );
  }
}
