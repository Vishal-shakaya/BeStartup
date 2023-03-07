import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoChart extends StatelessWidget {
  var user_id;
  ProfileInfoChart({required this.user_id, Key? key}) : super(key: key);

  var startupConnector = Get.put(StartupViewConnector());
  var my_context = Get.context;

  double invest_btn_width = 100;
  double invest_btn_height = 30;

  double static_sec_width = 0.30;
  double static_sec_height = 0.14;
  double statis_row_width = 0.06;

  double static_val_fontSize = 15;

  var desire_amount;
  var invested_amount;
  var team_members;

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    final resp = await startupConnector.FetchBusinessDetail(user_id: user_id);
    print('resp $resp');
    // Success Handler:
    if (resp['response']) {
      invested_amount = resp['data']['achived_amount'] ?? '';
      team_members = resp['data']['team_members'] ?? '';
      desire_amount = resp['data']['desire_amount'] ?? '';
    }

    // Error Handler :
    if (!resp['response']) {
      invested_amount = '';
      team_members = '';
      desire_amount = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    invest_btn_width = 100;
    invest_btn_height = 30;

    static_sec_width = 0.30;
    static_sec_height = 0.14;
    statis_row_width = 0.06;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 0.30;
      static_sec_height = 0.14;
      statis_row_width = 0.06;

      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 0.40;
      static_sec_height = 0.14;
      statis_row_width = 0.06;

      print('1200');
    }

    if (context.width < 1000) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 0.65;
      static_sec_height = 0.14;
      statis_row_width = 0.08;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 0.80;
      static_sec_height = 0.14;
      statis_row_width = 0.10;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 0.85;
      static_sec_height = 0.14;
      statis_row_width = 0.15;
      static_val_fontSize = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      invest_btn_width = 100;
      invest_btn_height = 30;

      static_sec_width = 1;
      static_sec_height = 0.14;
      statis_row_width = 0.15;
      static_val_fontSize = 12;
      print('480');
    }

    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
                    baseColor: shimmer_base_color,
                    highlightColor: shimmer_highlight_color,
                    child: MainMethod(context)));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  MainMethod(BuildContext context) {
    return Container(
      width: context.width * 30,
      margin: EdgeInsets.only(top: context.height * 0.01),
      alignment: Alignment.center,
      child: Container(
        width: context.width * static_sec_width,
        height: context.height * static_sec_height,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 1,
          // shadowColor: primary_light,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaticRow(title: 'Team'),
                        // StaticRow(title: '$team_members')
                        // Test Amount Unit
                        StaticRow(title: '10')
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaticRow(title: 'Desire'),
                        // StaticRow(title: '₹ $desire_amount')
                        StaticRow(title: '₹ 1.5CR')
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaticRow(title: 'Invest'),
                        // StaticRow(title: '₹ $invested_amount')
                        StaticRow(title: '₹ 1.5L')
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Container StaticRow({title, value}) {
    return Container(
      width: my_context!.width * statis_row_width,
      alignment: Alignment.center,
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(
                text: title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: home_profile_map_color,
                  fontSize: static_val_fontSize,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
          // AutoSizeText.rich(
          //   TextSpan(
          //       text: value,
          //       style: GoogleFonts.openSans(
          //         textStyle: TextStyle(),
          //         color: Colors.black,
          //         fontSize: 12,
          //         fontWeight: FontWeight.w600,
          //       )),
          //   style: Get.textTheme.headline5,
          // ),
        ],
      ),
    );
  }
}
