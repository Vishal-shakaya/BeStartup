import 'package:be_startup/AppState/StartupState.dart';

import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupDetailButtons.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/UpdateInvestmentDialog.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class InvestmentChart extends StatefulWidget {
  InvestmentChart({Key? key}) : super(key: key);

  @override
  State<InvestmentChart> createState() => _InvestmentChartState();
}

class _InvestmentChartState extends State<InvestmentChart> {
  var startupConnector = Get.put(StartupViewConnector());

  double invest_btn_width = 150;

  double invest_btn_height = 37;

  double static_sec_width = 210;

  double static_sec_height = 205;

  var my_context = Get.context;

  var desire_amount;

  var invested_amount;

  var team_members;

  var is_admin;

  var startup_id;
  var user_id;
  bool? is_liked=false;

/////////////////////////////////////////
  /// GET REQUIRED PARAM :
/////////////////////////////////////////
  IsStartupLiked() async {
    final resp = await startupConnector.IsStartupLiked(
      startup_id: startup_id,
      user_id: user_id,
    );

    if (resp['code'] == 101) {
      is_liked = true;
    }
    if (resp['code'] == 111) {
      is_liked = false;
    }
  }

  // Update Investment amount UI :
  UpdateInvestmentAmount({required data}) async {
    setState(() {
      invested_amount = data;
    });
  }

  //////////////////////////////////////////////
  /// Verify Phoneno :
  ///////////////////////////////////////////////
  UpdateInvetAlert({task, updateMail}) async {
    showDialog(
        barrierDismissible: false,
        context: my_context!,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                  width: context.width * 0.20,
                  height: context.height * 0.30,
                  child: UpdateInvestmentDialog(
                    updateInvestmentFun: UpdateInvestmentAmount,
                  )));
        });
  }

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    var startupDetialView = Get.put(StartupDetailViewState());
    var userStateView = Get.put(UserState());
 
    startup_id =  await startupDetialView.GetStartupId();
    user_id = await startupDetialView.GetFounderId();
    is_admin =await startupDetialView.GetIsUserAdmin();

    final resp =
        await startupConnector.FetchBusinessDetail(startup_id: startup_id);
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

    // Set liked default state :
    await IsStartupLiked();
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

  //////////////////////////////////////////
  /// MAIN METHOD :
  //////////////////////////////////////////
  Container MainMethod(context) {
    return Container(
      width: static_sec_width,
      height: static_sec_height,
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shadowColor: primary_light,
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
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StaticRow(title: 'Team', value: "$team_members"),
              StaticRow(title: 'Desire', value: "₹ $desire_amount"),
              StaticRow(title: 'Invest', value: "₹ $invested_amount"),

              // Submit Button :
              is_admin == true
                  ? SubmitButton()
                  : StartupDetailButtons(
                      startup_id: startup_id,
                      user_id: user_id,
                      is_saved: is_liked,
                    )
            ],
          )),
        ),
      ),
    );
  }

/////////////////////////////////////////////
  /// External Methods :
/////////////////////////////////////////////
  Container SubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () {
          is_admin ? UpdateInvetAlert() : () {};
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: invest_btn_width,
            height: invest_btn_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Text(
              is_admin == true ? 'Update' : 'Invest now',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Container StaticRow({title, value}) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(7),
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
              overflow: TextOverflow.ellipsis),
          Tooltip(
            message: value,
            child: Container(
              width: 80,
              child: AutoSizeText.rich(
                  TextSpan(
                      text: value,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type2,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                  style: Get.textTheme.headline5,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
