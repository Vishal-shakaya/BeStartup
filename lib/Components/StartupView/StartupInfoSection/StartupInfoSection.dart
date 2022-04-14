import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/InvestmentChart.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/ProfileImage.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupNavigation.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupInfoSection extends StatefulWidget {
  StartupInfoSection({Key? key}) : super(key: key);

  @override
  State<StartupInfoSection> createState() => _StartupInfoSectionState();
}

class _StartupInfoSectionState extends State<StartupInfoSection> {
  double image_cont_width = 0.6;
  double image_cont_height = 0.20;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.45,
        child: Stack(
          children: [
            // THUMBNAIL SECTION:
            Thumbnail(context),

            // PROFILE PICTURE :
            ProfileImage(),

            // TABS
            Positioned(
              top: context.height * 0.25,
              left: context.width * 0.10,
              child: Container(
                  width: context.width * 0.55,
                  height: 65,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      StartupNavigation(title: 'Team', route: () {}),
                      StartupNavigation(title: 'Vision', route: () {}),
                      StartupNavigation(title: 'Invest', route: () {}),

                      // STATIC SECTION WITH INVEST BUTTON : 
                     InvestmentChart()
                    ],
                  )),
            )
          ],
        ));
  }



  Card Thumbnail(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(19),
        right: Radius.circular(19),
      )),
      child: Container(
          height: context.height * 0.23,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(19),
              right: Radius.circular(19),
            ),
            child: Image.network(
                'https://www.postplanner.com/hubfs/how_to_get_more_likes_on_facebook.png',
                width: context.width * image_cont_width,
                height: context.height * image_cont_height,
                fit: BoxFit.cover),
          )),
    );
  }
}
