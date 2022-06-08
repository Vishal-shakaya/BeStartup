import 'dart:convert';

import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/Widgets/CheckoutPaymentDiagWidget.dart';
import 'package:be_startup/Helper/MailServer.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid_util.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
enum PlanOption { basicPlan, bestPlan, businessPlan }

class SelectPlan extends StatefulWidget {
  const SelectPlan({Key? key}) : super(key: key);

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  static const platform = MethodChannel("razorpay_flutter");
  var userStore = Get.put(UserStore(), tag: 'user_store');
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
  var mainData = '';
  var basic_plan_amount = 1000;
  var best_plan_amount = 1950;
  var business_plan_amount = 6000;
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
  var selectedPlan;
  var userName;
  var phoneNo;
  var tax = 10;
  var total_amount;

  // SHOW LOADING SPINNER :
  StartLoading() {
    var dialog = SmartDialog.showLoading(
        background: Colors.white,
        maskColorTemp: Color.fromARGB(146, 252, 250, 250),
        widget: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ));
    return dialog;
  }

// End Loading
  EndLoading() async {
    SmartDialog.dismiss();
  }

  // SNAKBAR :
  ErrorSnakbar({title, message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      margin: EdgeInsets.only(top: 10),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.shade50,
      titleText: MySnackbarTitle(title: 'Error ${title}'),
      messageText:
          MySnackbarContent(message: 'Something went wrong : $message'),
      maxWidth: context.width * 0.50,
    );
  }

  // Helpong function for gettin expiration date :
  GetExpiredDate(plan_type) async {
    var expired;

    if (plan_type == 'basic') {
      expired = DateTime.now().add(Duration(days: 60)).toUtc().toString();
      print('Basic plan Selected');
    }
    if (plan_type == 'best') {
      expired = DateTime.now().add(Duration(days: 180)).toUtc().toString();
      print('Best plan Selected');
    }
    if (plan_type == 'business') {
      print('Business plan Selected');
      expired = DateTime.now().add(Duration(days: 360)).toUtc().toString();
    }
    return expired;
  }

  ///////////////////////////////////////////////////////////
  // CHECKOUT DIALOG ALERT : [Billing Form ]
  // Handle Pyament flow with Getting required details
  // for billing purpose  :
  // 1. Execute checkout function :
  // 2. pass all payment required param:
  // 3. Get username , mail , phoneno
  //////////////////////////////////////////////////////
  CheckoutAlertDialog({planVal, checkoutVal}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                width: context.width * 0.37,
                height: context.height * 0.65,
                child: CheckoutPaymentDialogWidget(
                    plan: planVal, checkout: checkoutVal, key: UniqueKey()),
              ));
        });
  }

  ///////////////////////////////////////////
  /// CHECKOUT  HANDLER :
  /// 1. Create Payment obj :
  /// 2 Requirements :
  /// 2.1 openCheckout
///////////////////////////////////////////
  OnpressContinue(context) async {
    var exact_amount = planAmount! / 100;

    var tax_amount = ((exact_amount * tax) / 100);
    total_amount = tax_amount + exact_amount;
    final paid_amount = total_amount * 100;

    selectedPlan = {
      'plan': select_plan_type?.toUpperCase(),
      'phone_no': auth.currentUser?.phoneNumber,
      'mail': auth.currentUser?.email,
      'amount': paid_amount,
      'tax': '${tax}%',
      'total_amount': total_amount,
      'tax_amount': tax_amount,
    };
    final temp_val = selectedPlan;

    // REQUIRED TO SELECT USER TYPE:
    if (select_plan_type == null) {
      CoolAlert.show(
          context: context,
          width: 200,
          title: 'Select option!',
          type: CoolAlertType.info,
          widget: Text(
            'You have to select a Plan to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
            ),
          ));
    } else {
      await CheckoutAlertDialog(planVal: temp_val, checkoutVal: openCheckout);
    }
  }

// Alert for Success Payment :
  SuccessMailSendAlert() async {
    CoolAlert.show(
        onConfirmBtnTap: () {
          Get.toNamed(
            create_business_detail_url,
          );
        },
        context: context,
        width: 200,
        title: 'Successful',
        type: CoolAlertType.success,
        widget: Text(
          'Billing Detail send to mail address',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
          ),
        ));
  }

  CreateNewBusinessAlert(context) async {
    CoolAlert.show(
        onCancelBtnTap: () {
          Get.toNamed(home_page_url);
        },
        context: context,
        width: 200,
        title: 'Create New Startup',
        type: CoolAlertType.info,
        widget: Text(
          'Create another startup as you created before',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
          ),
        ));
  }

  ///////////////////////////////////////////////////
  /// 1. Send Bill To Buyer [ Founder ]:
  /// 2. Bill has expiration date  Important:
  /// 3. Payment Id for handle issue :
  /// 4. Use email js library to send mail :
  ////////////////////////////////////////////////
  SendInvoiceMail(
      {required paymentId,
      required exact_amount,
      required orderd,
      required expired,
      required payer_name,
      phone_no}) async {
    try {
      await SendMailToUser(
        transaction_id: paymentId,
        plan_type: selectedPlan['plan'],
        phone_no: phone_no == null ? '' : phone_no,
        amount: exact_amount.toString(),
        receiver_mail_address: selectedPlan['mail'],
        subject: ' Bestartup Payment Statement ',
        order_date: orderd,
        expire_date: expired,
        payer_name: payer_name == null ? selectedPlan['mail'] : payer_name,
      );

      EndLoading();
    } catch (e) {
      EndLoading();
    }
  }

  ///////////////////////////////////////////
  /// 1. Update user Profile with plan :
  /// 2. if user plan activate thne show Alert :
  /// for plan is already activated :
  /// 3. else activate plan :
  ///////////////////////////////////////////
  SetUserPlan({
    required exact_amount,
    required orderd,
    required expired,
  }) async {
    // Activate User Plan :
    try {
      final plan = await PlanModel(
        plan_name: selectedPlan['plan'],
        phone_no: selectedPlan['phone_no'],
        amount: exact_amount,
        order_date: orderd,
        expire_date: expired,
        buyer_mail: selectedPlan['mail'],
      );

      await userStore.UpdateUser(field: 'plan', val: plan);
    } catch (e) {
      EndLoading();
    }
  }

  ///////////////////////////////////
  /// PAYMENT SUCCESS HANDLER :
  /// Rqquirements :
  /// 1. SendInvoiceMail,
  /// 2. SetUserPlan,
  /// 3. GetExpiredDate
  ///////////////////////////////////
  PaymentSuccess(PaymentSuccessResponse response) async {
    StartLoading();
    final orderd = DateTime.now().toUtc().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);
    var exact_amount = selectedPlan['amount'] / 100;

    // 1. Check if user already purcahase any plan
    // then show alert about the plan :

    // 2.  Send Bill to Founder Mail address :
    await SendInvoiceMail(
        paymentId: response.paymentId,
        exact_amount: exact_amount,
        orderd: orderd,
        expired: expired,
        payer_name: userName,
        phone_no: phoneNo);

    // 3.  Set UserPlan to its Profile DB :
    await SetUserPlan(
        exact_amount: exact_amount, orderd: orderd, expired: expired);
    await SuccessMailSendAlert();

    await Future.delayed(Duration(seconds: 8));
    Get.toNamed(create_business_detail_url);

    print('SUCCESS RESPONSE ${response.paymentId}');
  }

  /////////////////////////////////////////
  /// ERROR HANDLER :
  /// 1. Show Error Snakbar with message:
  /////////////////////////////////////////

  PaymentError(PaymentFailureResponse response) async {
    print('SUCCESS ERROR ${response.message}');
    ErrorSnakbar(title: response.code, message: response.message);
  }

  ////////////////////////////////////////
  /// HANDEL EXTERNAL WALLET :
  ////////////////////////////////////////
  PayemtnFromExternalWallet(ExternalWalletResponse response) async {
    StartLoading();
    final orderd = DateTime.now().toUtc().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);
    var exact_amount = selectedPlan['amount'] / 100;

    // 1. Check if user already purcahase any plan
    // then show alert about the plan :

    // 2.  Send Bill to Founder Mail address :
    await SendInvoiceMail(
        paymentId: uuid.v4(),
        exact_amount: exact_amount,
        orderd: orderd,
        expired: expired,
        payer_name: userName,
        phone_no: phoneNo);

    // 3.  Set UserPlan to its Profile DB :
    await SetUserPlan(
        exact_amount: exact_amount, orderd: orderd, expired: expired);
    await SuccessMailSendAlert();

    await Future.delayed(Duration(seconds: 8));
    Get.toNamed(create_business_detail_url);
    print('SUCCESS RESPONSE ${response.walletName}');
  }

  bool? is_new_startup;
  var planType;

  @override
  void initState() {
    super.initState();
    // Default Selected Plan :
    SelectedPlan(PlanOption.bestPlan);

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

  ///////////////////////////////////////////////////////
  /// MAIN FUNCTION :
  /// 1. Maintain Payment flow with
  /// razorpay :
  /// 2. Required: amount , plan , phone , email ,
  //////////////////////////////////////////////////////
  void openCheckout({amount, phone, email, plan_type, user_name}) async {
    userName = user_name;
    phoneNo = phone;
    var options = {
      'key': 'rzp_test_XBqgVUXDkrs93M',
      'amount': amount,
      'name': 'BeStartup',
      'description': plan_type,
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

  /////////////////////////////////////////////////////////
  /// UI PLAN HADLER :
  /// 1. Set plan state activate :
  /// 2. set plan type to var :
  /// 3. set amont *100 to normalize for razorpay standards
  ///////////////////////////////////////////////////////////
  SelectedPlan(option) {
    setState(() {
      // 1. SELECT FOUNDER LOGIC:
      // 2. UNSELECT INVESTOR :
      if (PlanOption.basicPlan == option) {
        basicPlan = select_color;
        bestPlan = unselect_color;
        businessPlan = unselect_color;
        select_plan_type = 'basic';
        planAmount = basic_plan_amount * 100;
        // 1. SELECT INVESTOR LOGIC:
        // 2. UNSELECT FOUNDER
      } else if (PlanOption.bestPlan == option) {
        bestPlan = select_color;
        basicPlan = unselect_color;
        businessPlan = unselect_color;
        select_plan_type = 'best';
        planAmount = best_plan_amount * 100;
      }

      // 1. SELECT INVESTOR LOGIC:
      // 2. UNSELECT FOUNDER
      else if (PlanOption.businessPlan == option) {
        businessPlan = select_color;
        bestPlan = unselect_color;
        basicPlan = unselect_color;
        select_plan_type = 'business';
        planAmount = business_plan_amount * 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

CreateStartupDialogAlert({task, updateMail})  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
          width: context.width * 0.20,
          height: context.height * 0.20,
          child:Container(),
        ));
      });
   }


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

// INITILIZE DEFAULT STATE :
// GET IMAGE IF HAS IS LOCAL STORAGE :

    ChecUserPlanStatus() async {
      try {
        // User Plan Check Before continue :
        // 1. Check if user purchase plan without startup : Add startup withdout pay :
        // 2. Check if user has plan with startup , pay first Then Add new startup :
        // var resp = await userStore.IsAlreadyPlanBuyed();
        return '';
      } catch (e) {
        return '';
      }
    }


    return FutureBuilder(
        future: ChecUserPlanStatus(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Plans ',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(
    BuildContext context,
  ) {
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
                amount: '₹ 1950/-',
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
