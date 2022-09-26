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

  double invest_btn_fontSize = 16;

  double invest_btn_letter_spacing = 2.5;

  double static_sec_width = 210;

  double static_sec_height = 205;

  double dialog_width = 0.20;

  double dialog_height = 0.30;

  double static_row_width = 200;

  double static_row_title_fontSize = 15;

  double static_row_desc_fontSize = 14;

  double static_row_desc_cont_width = 80;

  double static_row_padding = 7;

  double card_top_padding = 10;

  double card_left_padding = 10;

  double card_right_padding = 10;

  double card_bottom_padding = 10;

  var my_context = Get.context;

  var desire_amount;

  var invested_amount;

  var team_members;

  var is_admin;

  var startup_id;
  var user_id;
  bool? is_liked = false;

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
                  width: context.width * dialog_width,
                  height: context.height * dialog_height,
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

    startup_id = await startupDetialView.GetStartupId();
    user_id = await startupDetialView.GetFounderId();
    is_admin = await startupDetialView.GetIsUserAdmin();

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
    invest_btn_width = 150;

    invest_btn_height = 37;

    invest_btn_fontSize = 16;

    invest_btn_letter_spacing = 2.5;

    static_sec_width = 210;

    static_sec_height = 205;

    dialog_width = 0.20;

    dialog_height = 0.30;

    static_row_width = 200;

    static_row_title_fontSize = 15;

    static_row_desc_fontSize = 14;

    static_row_padding = 7;

    static_row_desc_cont_width = 80;

    card_top_padding = 10;

    card_left_padding = 10;

    card_right_padding = 10;

    card_bottom_padding = 10;

    if (context.width > 1600) {
      invest_btn_width = 150;

      invest_btn_height = 37;

      invest_btn_fontSize = 16;

      invest_btn_letter_spacing = 2.5;

      static_sec_width = 210;

      static_sec_height = 205;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_width = 200;

      static_row_title_fontSize = 15;

      static_row_desc_fontSize = 14;

      static_row_desc_cont_width = 80;

      card_top_padding = 10;

      card_left_padding = 10;

      card_right_padding = 10;

      card_bottom_padding = 10;

      print('Greator 1600');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      invest_btn_width = 150;

      invest_btn_height = 37;

      invest_btn_fontSize = 16;

      invest_btn_letter_spacing = 2.5;

      static_sec_width = 210;

      static_row_width = 200;

      static_row_desc_cont_width = 60;

      static_sec_height = 205;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 15;

      static_row_desc_fontSize = 14;

      print('1500');
    }

    if (context.width < 1400) {
      print('1400');
    }

    if (context.width < 1300) {
      invest_btn_width = 140;

      invest_btn_height = 37;

      invest_btn_fontSize = 16;

      invest_btn_letter_spacing = 2.5;

      static_sec_width = 200;

      static_row_width = 200;

      static_row_desc_cont_width = 60;

      static_sec_height = 205;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 15;

      static_row_desc_fontSize = 14;
      print('1300');
    }

    if (context.width < 1200) {
      invest_btn_width = 130;

      invest_btn_height = 36;

      invest_btn_fontSize = 15;

      invest_btn_letter_spacing = 2;

      static_sec_width = 200;

      static_row_width = 200;

      static_row_desc_cont_width = 60;

      static_sec_height = 200;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 14;

      static_row_desc_fontSize = 13;
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      invest_btn_width = 100;

      invest_btn_height = 30;

      invest_btn_fontSize = 13;

      invest_btn_letter_spacing = 2;

      static_sec_width = 170;

      static_row_width = 200;

      static_row_desc_cont_width = 40;

      static_sec_height = 180;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 13;

      static_row_desc_fontSize = 12;

      card_top_padding = 5;

      card_left_padding = 10;

      card_right_padding = 10;

      card_bottom_padding = 10;

      static_row_padding = 6;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      invest_btn_width = 85;

      invest_btn_height = 25;

      invest_btn_fontSize = 12;

      invest_btn_letter_spacing = 1.5;

      static_sec_width = 160;

      static_row_width = 200;

      static_row_desc_cont_width = 35;

      static_row_padding = 5;

      static_sec_height = 170;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 13;

      static_row_desc_fontSize = 12;

      card_top_padding = 5;

      card_left_padding = 10;

      card_right_padding = 10;

      card_bottom_padding = 10;

      print('640');
    }
    // SMALL TABLET:
    if (context.width < 550) {
      invest_btn_width = 85;

      invest_btn_height = 25;

      invest_btn_fontSize = 12;

      invest_btn_letter_spacing = 1.5;

      static_sec_width = 150;

      static_row_width = 200;

      static_row_desc_cont_width = 35;

      static_row_padding = 4;

      static_sec_height = 161;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 12;

      static_row_desc_fontSize = 11;

      card_top_padding = 6;

      card_left_padding = 10;

      card_right_padding = 10;

      card_bottom_padding = 10;

      print('550');
    }

    // PHONE:
    if (context.width < 480) {
      invest_btn_width = 85;

      invest_btn_height = 25;

      invest_btn_fontSize = 12;

      invest_btn_letter_spacing = 1.5;

      static_sec_width = 150;

      static_row_width = 200;

      static_row_desc_cont_width = 35;

      static_row_padding = 4;

      static_sec_height = 161;

      dialog_width = 0.20;

      dialog_height = 0.30;

      static_row_title_fontSize = 12;

      static_row_desc_fontSize = 11;

      card_top_padding = 6;

      card_left_padding = 10;

      card_right_padding = 10;

      card_bottom_padding = 10;
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

  //////////////////////////////////////////
  /// MAIN METHOD :
  //////////////////////////////////////////
  Container MainMethod(context) {

    //////////////////////////////////////
    /// Main Chart : 
    //////////////////////////////////////
    Container mainChart = Container(
      width: static_sec_width,
      height: static_sec_height,
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shadowColor: primary_light,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          padding: EdgeInsets.only(
            top: card_top_padding,
            left: card_left_padding,
            right: card_right_padding,
            bottom: card_bottom_padding,
          ),
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
              // StaticRow(title: 'Team', value: "$team_members"),
              // StaticRow(title: 'Desire', value: "₹ $desire_amount"),
              // StaticRow(title: 'Invest', value: "₹ $invested_amount"),
              StaticRow(title: 'Team', value: "10"),
              StaticRow(title: 'Desire', value: "₹ 50L"),
              StaticRow(title: 'Invest', value: "₹ 80K"),

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

    //////////////////////////////
    /// Phone Static Chart :
    //////////////////////////////
     Container phoneChart = Container(
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.10,
        padding: EdgeInsets.all(2),
        
        
        child: Card(
          elevation: 2,
          shadowColor: my_theme_shadow_color,
          surfaceTintColor: my_theme_shadow_color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
         
         
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              PhoneStaticRow(title: 'Team', value: "10"),
              PhoneStaticRow(title: 'Desire', value: "₹ 50L"),
              
              // if User is admin then show update dialog else pass Null Function : 
              PhoneStaticRow(title: 'Invest', value: "₹ 80K",
              fun: is_admin==true? UpdateInvetAlert :(){}),
            ],
          ),
        ));



    // Return Chart base on screen size : 
    Container chart ;    
    MediaQuery.of(context).size.width<550
    ? chart= phoneChart
    : chart= mainChart ;
    return chart; 
  }

/////////////////////////////////////////////
  /// External Methods :
/////////////////////////////////////////////
  Container SubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
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
                  letterSpacing: invest_btn_letter_spacing,
                  color: Colors.white,
                  fontSize: invest_btn_fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Container StaticRow({title, value}) {
    return Container(
      width: static_row_width,
      padding: EdgeInsets.all(static_row_padding),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
      
          AutoSizeText.rich(
              TextSpan(
                  text: title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(),
                    color: light_color_type2,
                    fontSize: static_row_title_fontSize,
                    fontWeight: FontWeight.w600,
                  )),
              style: Get.textTheme.headline5,
              overflow: TextOverflow.ellipsis),
        
          Tooltip(
            message: value,
          
            child: Container(
              width: static_row_desc_cont_width,
              child: AutoSizeText.rich(
                  TextSpan(
                      text: value,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type2,
                        fontSize: static_row_desc_fontSize,
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

  Container PhoneStaticRow({title, value,fun}) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
       
          AutoSizeText.rich(
              TextSpan(
                  text: title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(),
                    color: light_color_type2,
                    fontSize: static_row_title_fontSize,
                    fontWeight: FontWeight.w600,
                  )),
              style: Get.textTheme.headline5,
              overflow: TextOverflow.ellipsis),
       
       
          Tooltip(
            message: value,
            child: InkWell(
              onTap: () {
                fun();
              },

              child: Container(
                width: static_row_desc_cont_width,
               
                child: AutoSizeText.rich(
                    TextSpan(
                        text: value,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(),
                          color: light_color_type2,
                          fontSize: static_row_desc_fontSize,
                          fontWeight: FontWeight.w600,
                        )),
                    style: Get.textTheme.headline5,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
