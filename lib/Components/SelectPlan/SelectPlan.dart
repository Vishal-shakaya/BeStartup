import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum PlanOption { basicPlan, bestPlan, businessPlan }

class SelectPlan extends StatefulWidget {
  const SelectPlan({Key? key}) : super(key: key);

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  static const platform = MethodChannel("razorpay_flutter");
  FirebaseAuth auth = FirebaseAuth.instance;

  Color? unselect_color =
      Get.isDarkMode ? dartk_color_type4 : shimmer_highlight_color;

  Color? select_color = Get.isDarkMode ? tealAccent : primary_light;

  Color? basicPlan =
      Get.isDarkMode ? dartk_color_type4 : shimmer_highlight_color;

  Color? bestPlan =
      Get.isDarkMode ? dartk_color_type4 : shimmer_highlight_color;

  Color? businessPlan =
      Get.isDarkMode ? dartk_color_type4 : shimmer_highlight_color;

  Color? card_hover_color =
      Get.isDarkMode ? tealAccent.withOpacity(0.3) : Colors.blueGrey.shade50;

  String? select_plan_type = null;
  var _razorpay = Razorpay();

  int? planAmount;

  ///////////////////////////////////////
  // CARD AND BUTTON  :
  // 1. WIDTH AND HEIGHT :
  ///////////////////////////////////////

  double card_width = 300;
  double card_height = 430;
  double card_padding = 20;

  double body_cont_height = 570;
  double body_cont_width = 10;

  double con_button_width = 130;
  double con_button_height = 45;
  double con_btn_top_margin = 30;

  double heading_col_height = 0.15;
  double heading_font_size = 35;
  double heading_text_top_mar = 0;

  double plan_text_font_size = 17;
  ///////////////////////////////////////////
  /// HANDLER :
  /// 1.CHECK SELECT USER TYPE :
  /// 2. REDIRECT TO SLIDE PAGE :
///////////////////////////////////////////
  OnpressContinue(context) {
    var selectedPlan = {
      'plan': select_plan_type?.toUpperCase(),
      'phone_no': auth.currentUser?.phoneNumber,
      'mail': auth.currentUser?.email,
      'amount': planAmount
    };

    // REQUIRED TO SELECT USER TYPE:
    if (select_plan_type == null) {
      CoolAlert.show(
          context: context,
          width: 200,
          title: 'Select option!',
          type: CoolAlertType.info,
          widget: Text(
            'You have to select a Plan to continue',
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
                fontWeight: FontWeight.bold),
          ));
    } else {
      openCheckout(
          plan_type: selectedPlan['plan'],
          phone: selectedPlan['phone_no'],
          amount: selectedPlan['amount'],
          email: selectedPlan['mail']);
    }
  }

  PaymentSuccess(response) async {
    final resp = await response; 
    print('SUCCESS RESPONSE $resp');
  }

  PaymentError(response) async {
    print('SUCCESS ERROR $response');
  }

  PayemtnFromExternalWallet(response) async {
    print('SUCCESS EXTERNAL WALLET $response');
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, PaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, PaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, PayemtnFromExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout({amount, phone, email, plan_type}) async {
    var options = {
      'key': 'rzp_test_XBqgVUXDkrs93M',
      'amount': amount,
      'name': 'BeStartup',
      'description': 'plan_type',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': phone, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  SelectedPlan(option) {
    setState(() {
      // 1. SELECT FOUNDER LOGIC:
      // 2. UNSELECT INVESTOR :
      if (PlanOption.basicPlan == option) {
        basicPlan = select_color;
        bestPlan = unselect_color;
        businessPlan = unselect_color;
        select_plan_type = 'basic';
        planAmount = 100000;
        // 1. SELECT INVESTOR LOGIC:
        // 2. UNSELECT FOUNDER
      } else if (PlanOption.bestPlan == option) {
        bestPlan = select_color;
        basicPlan = unselect_color;
        businessPlan = unselect_color;
        select_plan_type = 'best';
        planAmount = 175000;
      }

      // 1. SELECT INVESTOR LOGIC:
      // 2. UNSELECT FOUNDER
      else if (PlanOption.businessPlan == option) {
        businessPlan = select_color;
        bestPlan = unselect_color;
        basicPlan = unselect_color;
        select_plan_type = 'business';
        planAmount = 600000;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////
    // BREAKPOINTS :
    // 1. TAB SIZE :
    // WIDTH : 800 ,650 , 600
    // HEIGHT: 850,700
    ///////////////////////////////////////
    if (context.width < 800) {
      card_width = 250;
      card_height = 300;
      body_cont_height = 500;
    }
    if (context.width > 800) {
      card_width = 300;
      card_height = 430;
      body_cont_height = 570;
    }

    if (context.width < 650) {
      card_width = 220;
      card_height = 250;
      body_cont_height = 450;
    }

    if (context.height < 850) {
      card_width = 220;
      card_height = 300;
      body_cont_height = 450;
    }
    if (context.height < 700) {
      card_width = 220;
      card_height = 250;
      body_cont_height = 400;
    }

    if (context.width < 600) {
      card_width = 210;
      card_height = 250;
      body_cont_height = 400;
      card_padding = 10;
    }
    if (context.height < 700 && context.width < 600) {
      card_width = 170;
      card_height = 200;
      body_cont_height = 300;
      card_padding = 10;
    }

    if (context.height < 550 && context.width < 600) {
      card_width = 150;
      card_height = 150;
      body_cont_height = 250;
      card_padding = 5;
    }

    // PHONE :
    if (context.width < 450) {
      heading_col_height = 0.3;
      heading_font_size = 30;
      plan_text_font_size = 20;
      con_btn_top_margin = 40;
      card_width = 150;
      card_height = 220;
      body_cont_height = 300;
      card_padding = 9;
      heading_text_top_mar = 30;
    }

    return Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ///////////////////////////////
        // Heading Section :
        ///////////////////////////////
        Container(
          height: context.height * heading_col_height,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(top: heading_text_top_mar),
              child: RichText(
                  text: TextSpan(style: Get.textTheme.headline3, children: [
                TextSpan(
                    text: select_plan_heading,
                    style: TextStyle(fontSize: heading_font_size))
              ])),
            )
          ]),
        ),

        ////////////////////////////////
        /// PLANS SECTION :
        ////////////////////////////////
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlanType(
                amount: '₹ 1000/-',
                period: '3 Month',
                type: 'Basic Plan',
                selected_plan: PlanOption.basicPlan,
                active_color: basicPlan,
                color_pallet: Colors.blue),
            PlanType(
                amount: '₹ 1750/-',
                period: '1 Year',
                type: 'Best Plan',
                selected_plan: PlanOption.bestPlan,
                active_color: bestPlan,
                color_pallet: Colors.orange),
            PlanType(
                amount: '₹ 6000/-',
                period: 'Lifetime',
                type: 'Business Plan',
                selected_plan: PlanOption.businessPlan,
                active_color: businessPlan,
                color_pallet: primary_light2),
          ],
        ),

        // CONTINUE  BUTTON :
        ContinueButton(context)
      ]),
    ));
  }

//////////////////////////////////////
  /// COMPONENT SECTION :
////////////////////////////////////
  Container ContinueButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () {
          OnpressContinue(context);
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Text(
              'continue',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Container PlanType(
      {type, amount, period, color_pallet, active_color, selected_plan}) {
    return Container(
        height: body_cont_height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //////////////////////////////////
            // BASIC PLAN
            //////////////////////////////////
            Container(
              width: card_width,
              height: card_height,
              padding: EdgeInsets.all(card_padding),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(22)),
                onTap: () {
                  SelectedPlan(selected_plan);
                },
                hoverColor: card_hover_color,
                child: Card(
                  elevation: 10,
                  shadowColor: primary_light,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 2,
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // BOTTOM TEXT :
                            Container(
                                margin: EdgeInsets.only(bottom: 5, top: 10),
                                padding: EdgeInsets.all(5),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: type,
                                          style: TextStyle(
                                              color: active_color,
                                              fontSize: 15))
                                    ]))),

                            // Prize Container:
                            Container(
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                padding: EdgeInsets.all(8),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: period,
                                          style: TextStyle(
                                              color: color_pallet,
                                              fontSize: 24))
                                    ]))),

                            Container(
                                margin: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DetailLabel(title: '. Business Protfolio'),
                                    DetailLabel(title: '. Free Sharable Link'),
                                    DetailLabel(title: '. Dynamic App'),
                                    DetailLabel(title: '. Free Modification'),
                                    DetailLabel(title: '. Admin Pannel'),
                                    DetailLabel(
                                        title:
                                            '. Available Android / Ios / Web'),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 10, top: 10),
                                padding: EdgeInsets.all(8),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: amount,
                                          style: TextStyle(
                                              color: color_pallet,
                                              fontSize: 30))
                                    ]))),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ));
  }

  Container DetailLabel({title}) {
    return Container(
      padding: EdgeInsets.all(5),
      child: RichText(
          text: TextSpan(style: Get.textTheme.headline5, children: [
        TextSpan(
            text: title, style: TextStyle(color: Colors.blueGrey, fontSize: 14))
      ])),
    );
  }
}
