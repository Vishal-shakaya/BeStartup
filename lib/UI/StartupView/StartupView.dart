import 'dart:convert';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ProductSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ServiceSection.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:be_startup/Components/StartupView/StartupVisionSection/StartupVisionSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupView extends StatefulWidget {
  StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  String? pageParam = Get.parameters['data'];

  @override
  Widget build(BuildContext context) {
    var decode_data = jsonDecode(pageParam!);
    SetStartupDetailViewId(decode_data['startup_id']);
    SetIsUserAdmin(decode_data['is_admin']);
    SetStartupFounderId(decode_data['founder_id']);
    // Decode Param
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
            // 1 HEADING :
            // 2 STARTUP VISION DESCRIPTION:
            StartupVisionSection(),

            // PRODUCT HEADING :
            StartupHeaderText(
              title: 'Product',
              font_size: 32,
            ),

            // PRODUCT AND SERVIVES :
            ProductSection(),

            // SERVICE HEADING :
            StartupHeaderText(
              title: 'Services',
              font_size: 32,
            ),

            // SERVICE SECTION :
            ServiceSection(),

            // INVESTOR HEADING:
            StartupHeaderText(
              title: 'Investors',
              font_size: 32,
            ),

            InvestorSection(),
          ],
        ),
      ),
    );
  }
}
