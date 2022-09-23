import 'dart:convert';
import 'package:be_startup/AppState/StartupState.dart';

import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ProductSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ServiceSection.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:be_startup/Components/StartupView/StartupVisionSection/StartupVisionSection.dart';

import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupView extends StatefulWidget {
  StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  String? pageParam = Get.parameters['data'];
  var founderConnector = Get.put(FounderConnector());
  var detailViewState = Get.put(StartupDetailViewState());

  double page_width = 0.90;
  double heading_fontSize = 32; 

  @override
  Widget build(BuildContext context) {
    var decode_data = jsonDecode(pageParam!);

    GetLocalStorageData() async {
      await detailViewState.SetStartupId(id: decode_data['startup_id']);
      await detailViewState.SetFounderId(id: decode_data['founder_id']);
      await detailViewState.SetIsUserAdmin(admin: decode_data['is_admin']);

      final found_resp = await founderConnector.FetchFounderDetailandContact(
          user_id: decode_data['founder_id']);

      if (found_resp['response']) {
        final registor_mail = found_resp['data']['userDetail']['email'];
        final primary_mail = found_resp['data']['userContect']['primary_mail'];

        var mail = await CheckAndGetPrimaryMail(
            primary_mail: primary_mail, default_mail: registor_mail);

        await detailViewState.SetFounderMail(mail: mail);
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading Startup Details');
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
     page_width = 0.90;
     heading_fontSize = 32; 
    // DEFAULT :
    if (context.width > 1700) {
        page_width = 0.90;
        heading_fontSize = 32; 
      print('1700');
    }
    // DEFAULT :
    if (context.width < 1700) {
      print('1700');
    }

    // DEFAULT :
    if (context.width < 1600) {
        page_width = 0.90;
        heading_fontSize = 32; 
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
        page_width = 0.90;
        heading_fontSize = 30; 
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      heading_fontSize = 28; 
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      heading_fontSize = 28; 
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
        heading_fontSize = 25; 
        page_width = 1;
      print('480');
    }

    return Container(
      padding: const EdgeInsets.all(5),
      width: context.width * page_width,
      
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
            const StartupVisionSection(),

            // PRODUCT HEADING :
            StartupHeaderText(
              title: 'Product',
              font_size: heading_fontSize,
            ),

            // PRODUCT AND SERVIVES :
            const ProductSection(),

            // SERVICE HEADING :
            StartupHeaderText(
              title: 'Services',
              font_size: heading_fontSize,
            ),

            // SERVICE SECTION :
            ServiceSection(),

            InvestorSection(),
          ],
        ),
      ),
    );
  }
}
