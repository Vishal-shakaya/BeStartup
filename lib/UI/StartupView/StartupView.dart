import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: context.width * 0.90,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // CONTAIN : 
            // 1 THUMBNAIL : 
            // 2 PROFILE PICTURE : 
            // 3 TABS :
            // 4 INVESTMENT CHART : 
            StartupInfoSection(),

            // VISION SECTION : 
            
          ],
        ),
      ),
    );
  }
}