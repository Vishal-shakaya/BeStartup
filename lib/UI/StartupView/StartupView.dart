import 'dart:convert';
import 'package:be_startup/AppState/StartupState.dart';

import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ProductSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ServiceSection.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:be_startup/Components/StartupView/StartupVisionSection/StartupVisionSection.dart';
import 'package:be_startup/Utils/Colors.dart';

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

  double product_bottom_space = 0.04;

  double product_top_space = 0.12;

  double prouduct_bottom_space = 0.03;

  double service_bottom_height = 0.04; 

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

    product_bottom_space = 0.04;

    product_top_space = 0.12;

    prouduct_bottom_space = 0.03;

    service_bottom_height = 0.04; 

    // DEFAULT :
    if (context.width > 1700) {
      page_width = 0.90;
      heading_fontSize = 32;

      product_bottom_space = 0.04;

      product_top_space = 0.12;

      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.04; 
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
        product_top_space = 0.10;

        product_bottom_space = 0.04;

        prouduct_bottom_space = 0.03;

        service_bottom_height = 0.03; 
      print('1500');
    }

    if (context.width < 1200) {
      page_width = 0.90;
      heading_fontSize = 30;
      print('1200');
    }
    
    if (context.width < 1300) {
      page_width = 0.90;
      heading_fontSize = 30;

      product_top_space = 0.09;

      product_bottom_space = 0.03;

      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03; 
      print('1300');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      product_top_space = 0.03;

      product_bottom_space = 0.03;

      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03; 
      heading_fontSize = 28;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      product_top_space = 0.03;

      product_bottom_space = 0.03;

      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.02; 
      heading_fontSize = 28;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      product_top_space = 0.03;

      product_bottom_space = 0.03;

      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03; 
      heading_fontSize = 25;
      page_width = 1;
      print('480');
    }

    return Container(
      padding: const EdgeInsets.all(5),
      color: my_theme_background_color,
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

            SizedBox(height: context.height * product_top_space),

            // PRODUCT HEADING :
            StartupHeaderText(
              title: 'Product',
              font_size: heading_fontSize,
              
            ),

            SizedBox(height: context.height * product_bottom_space),

            // PRODUCT AND SERVIVES :
            const ProductSection(),

            SizedBox(height: context.height * prouduct_bottom_space),

            // SERVICE HEADING :
            StartupHeaderText(
              title: 'Services',
              font_size: heading_fontSize,
            ),

            SizedBox(height: context.height * service_bottom_height),
            // SERVICE SECTION :
            ServiceSection(),

            InvestorSection(),
          ],
        ),
      ),
    );
  }
}
