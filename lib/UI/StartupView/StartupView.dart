import 'dart:convert';
import 'package:be_startup/AppState/DetailViewState.dart';
import 'package:be_startup/AppState/PageState.dart';
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
  var detailViewState = Get.put(StartupDetailViewState());

  @override
  Widget build(BuildContext context) {
    
    var decode_data = jsonDecode(pageParam!);
    
    GetLocalStorageData() async {
      await detailViewState.SetStartupId(id: decode_data['startup_id']);
      await detailViewState.SetFounderId(id: decode_data['founder_id']);
      await detailViewState.SetIsUserAdmin(admin: decode_data['is_admin']);
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
            const StartupVisionSection(),

            // PRODUCT HEADING :
            StartupHeaderText(
              title: 'Product',
              font_size: 32,
            ),

       
            // PRODUCT AND SERVIVES :
            const ProductSection(),


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


            const InvestorSection(),
          ],
        ),
      ),
    );
  }
}
