import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoChart extends StatelessWidget {
  var startup_id;
  ProfileInfoChart({required this.startup_id, Key? key}) : super(key: key);

  var startupConnector = Get.put(StartupViewConnector());
  var my_context = Get.context;

  double invest_btn_width = 100;
  double invest_btn_height = 30;

  double static_sec_width = 0.28;
  double static_sec_height = 0.12;
  double statis_row_width = 0.04;
  
  var desire_amount;
  var achived_amount;
  var team_members;

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    final resp =
        await startupConnector.FetchBusinessDetail(startup_id: startup_id);
    // Success Handler:
    if (resp['response']) {
      achived_amount = resp['data']['achived_amount'] ?? '';
      team_members = resp['data']['team_members'] ?? '';
      desire_amount = resp['data']['desire_amount']?? '';
    }

    // Error Handler :
    if (!resp['response']) {
      achived_amount = '';
      team_members = '';
      desire_amount = '';
    }
  }

  @override
  Widget build(BuildContext context) {
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
      margin: EdgeInsets.only(top:context.height * 0.01),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StaticRow(title: 'Team'),
                      StaticRow(title: '$team_members')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StaticRow(title: 'Desire'),
                      StaticRow(title: '₹ $desire_amount')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StaticRow(title: 'Achived'),
                      StaticRow(title: '₹ $achived_amount')
                    ],
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
      padding: EdgeInsets.all(4),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          AutoSizeText.rich(
            TextSpan(
                text: title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: light_color_type2,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
          AutoSizeText.rich(
            TextSpan(
                text: value,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
