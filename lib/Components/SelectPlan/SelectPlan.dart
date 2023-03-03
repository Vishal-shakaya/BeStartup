import 'dart:convert';

import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/Widgets/CheckoutPaymentDiagWidget.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/Widgets/BigLoadingSpinner.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:be_startup/Helper/MailServer.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = const Uuid();

enum PlanOption { basicPlan, bestPlan, businessPlan }

class SelectPlan extends StatefulWidget {
  const SelectPlan({Key? key}) : super(key: key);

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  static const platform = MethodChannel("razorpay_flutter");
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

  var userStore = Get.put(UserStore(), tag: 'user_store');
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  var businessStore = Get.put(BusinessDetailStore());
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');

  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
  var founderConnector = Get.put(FounderConnector(), tag: 'founder_connector');
  var investorConnector =
      Get.put(InvestorConnector(), tag: 'investor_connector');

  var my_context = Get.context;
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
  var options;
  int? planAmount;
  var mainData = '';

  // Plan Amount :
  var basic_plan_amount = 1000;
  var best_plan_amount = 1950;
  var business_plan_amount = 6000;

  double plan_desc_fontSize = 14;

  double plan_title_fontSize = 16;

  double plan_timePeriod_fontSize = 25;

  double plan_price_fontSize = 30;

  ///////////////////////////////////////
  // CARD AND BUTTON  :
  // 1. WIDTH AND HEIGHT :
  ///////////////////////////////////////

  double card_width = 300;
  double card_height = 440;
  double card_padding = 20;

  double body_cont_height = 580;
  double body_cont_width = 10;

  double con_button_width = 130;
  double con_button_height = 45;
  double con_btn_top_margin = 30;
  double con_btn_fontSize = 20;

  double heading_col_height = 0.15;
  double heading_font_size = 35;

  double heading_text_top_mar = 0;

  double payment_dialog_width = 0.37;
  double payment_dialog_height = 0.65;

  var selectedPlan;
  var userName;
  var phoneNo;
  var tax = 10;
  var total_amount;

  bool? is_new_startup;
  var planType;

//////////////////////////////////////////////
  /// REQUIREMNTS AND HANDERL : [INDEX]
  /// 1. Getexpiredate:
  /// 2. Checkout alert dialog :
  /// 3. Onpress continue function :
  /// 4. Success Payment Alert:
  /// 5. Create Business Alert :
  /// 6. Send voice mail :
  /// 7. Set user plan :
  /// 8. Big Loading spinner :
  /// 9. Create startup :
  /// 10. Send data to firestore :
  ///
  /// RESPONSES :
  /// 11. Success Handler :
  ///   1. Bigloading spinner :
  ///   2. Setuserplan :
  ///   3. SendData to firestore :
  ///   4. SendVoice mail :
  ///   5. SuccessMailAlert :
  ///
  /// 12 EXTERNAL WALLET HANDLER  :
  /// 13 ERROR PAYMENT HANDLER  :
  /// 14 OPEN CHECKOUT :
  /// 15 SELECT PLAN :
  ///
  /// 16 INITILIZE FUN :
  /// 17 DISPOSE   FUN:
//////////////////////////////////////////////

  // Helpong function for gettin expiration date :
  GetExpiredDate(plan_type) async {
    var expired;

    if (plan_type == 'basic') {
      expired = DateTime.now().add(const Duration(days: 60)).toString();
      print('Basic plan Selected');
    }
    if (plan_type == 'best') {
      expired = DateTime.now().add(const Duration(days: 180)).toString();
      print('Best plan Selected');
    }
    if (plan_type == 'business') {
      print('Business plan Selected');
      expired = DateTime.now().add(const Duration(days: 360)).toString();
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
                width: context.width * payment_dialog_width,
                height: context.height * payment_dialog_height,
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
          Get.toNamed(startup_view_url);
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
    var resp;
    try {
      resp = await SendMailToUser(
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
      return resp;
    } catch (e) {
      return resp;
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
    required buyer_name,
    required phone_no,
    required plan_type,
  }) async {
    final localStore = await SharedPreferences.getInstance();
    // Activate User Plan :
    try {
      final plan = await PlanModel(
          plan_name: plan_type,
          phone_no: phone_no,
          amount: exact_amount,
          order_date: orderd,
          expire_date: expired,
          buyer_mail: auth.currentUser?.email,
          buyer_name: buyer_name,
          startup_id: await startupState.GetStartupId(),
          user_id: await userState.GetUserId());

      final is_planCreate = await localStore.setString(
          getStartupPlansStoreName, json.encode(plan));

      if (is_planCreate) {
        var resp = await startupConnector.CreateBusinessPlans();
        print('Business Plan Created ${resp}');

        // Success Handler Creating plan :
        if (resp['response']) {
          return ResponseBack(
              response_type: true, message: "plan Created ${resp['message']}");
        }

        // Error Handler Createing plan :
        if (!resp['response']) {
          return ResponseBack(
              response_type: false,
              message: "plan not created ${resp['message']}");
        }
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  // SHOW  BIG LOADING SPINNER :
  StartBigLoading() {
    // var dialog = SmartDialog.showLoading(
    //     background: Colors.white,
    //     maskColorTemp: const Color.fromARGB(146, 252, 250, 250),
    //     widget: BigLoadingSpinner());
    // return dialog;
  }

///////////////////////////////////////////////////////////////
  /// CREATE STARTUP :
  /// It creates a startup model and .
  /// pdates the user's plan and startup field in the database
///////////////////////////////////////////////////////////////
  CreateStartup() async {
    var resp = await startupConnector.CreateStartup();
    return resp;
  }

  /////////////////////////////////////////////////////
  // START STORING ALL FOUNDER DETIAL TO FIREBASE :
  /////////////////////////////////////////////////////
  SendDataToFireStore() async {
    var resp = await startupConnector.CreateBusinessCatigory();
    print(resp);

    var resp2 = await startupConnector.CreateBusinessDetail();
    print(resp2);

    var resp4 = await startupConnector.CreateBusinessProduct();
    print(resp4);

    var resp5 = await startupConnector.CreateBusinessThumbnail();
    print(resp5);

    var resp6 = await startupConnector.CreateBusinessVision();
    print(resp6);

    var resp9 = await startupConnector.CreateBusinessTeamMember();
    print(resp9);

    var resp10 = await startupConnector.CreateBusinessWhyInvest();
    print(resp10);

    var resp11 = await startupConnector.CreateBusinessMileStone();
    print(resp11);

    var resp12 = await startupConnector.CreateBusinessPitch();
    print(resp12);

    // var resp11 = await startupConnector.CreateBusinessMileStone();
    // print(resp11);

    return ResponseBack(response_type: true);
  }

  ///////////////////////////////////
  /// PAYMENT SUCCESS HANDLER :
  /// Rqquirements :
  /// 1. SendInvoiceMail,
  /// 2. SetUserPlan,
  /// 3. GetExpiredDate
  ///////////////////////////////////
  PaymentSuccess(PaymentSuccessResponse response) async {
    StartBigLoading();

    final orderd = DateTime.now().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);

    var exact_amount = selectedPlan['amount'] / 100;
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    try {
      final is_data_send = await SendDataToFireStore();

      ////////////////////////////////////////////////////////
      /// The above code is doing the following things:
      /// 1. It is sending the payment data to the server.
      /// 2. It is sending the payment data to the firebase.
      /// 3. It is sending the payment data to the mail.
      ////////////////////////////////////////////////////////
      if (is_data_send['response']) {
        print('Data store in firebase  Resp $is_data_send');
        var resp = await SetUserPlan(
            exact_amount: exact_amount,
            orderd: orderd,
            expired: expired,
            buyer_name: userName,
            phone_no: phoneNo,
            plan_type: plan_type);

        print('Create User Response $resp');


        if (resp['response']) {
          final is_mail_send = await SendInvoiceMail(
              paymentId: response.paymentId,
              exact_amount: exact_amount,
              orderd: orderd,
              expired: expired,
              payer_name: userName,
              phone_no: phoneNo);

          print('Mail Send Response $is_mail_send');
        }

        CloseCustomPageLoadingSpinner();
        Get.toNamed(home_page_url);
      }

      // If data not uploaded completely then
      // redirect user to home view :
      if (!is_data_send['response']) {
        CloseCustomPageLoadingSpinner();
        Get.toNamed(home_page_url);
      }
      
    }
    
    // If Error accure then Reset all action of creating 
    // startup and Payment Return Operation Start : 
     catch (e) {
      print('Error accure while Creating Startup $e');
    }


  }

////////////////////////////////////////
  /// HANDEL EXTERNAL WALLET :
////////////////////////////////////////
  PayemtnFromExternalWallet(ExternalWalletResponse response) async {
    StartBigLoading();

    final orderd = DateTime.now().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);

    var exact_amount = selectedPlan['amount'] / 100;
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    final is_data_send = await SendDataToFireStore();

    ////////////////////////////////////////////////////////
    /// The above code is doing the following things:
    /// 1. It is sending the payment data to the server.
    /// 2. It is sending the payment data to the firebase.
    /// 3. It is sending the payment data to the mail.
    ////////////////////////////////////////////////////////
    if (is_data_send['response']) {
      var resp = await SetUserPlan(
          exact_amount: exact_amount,
          orderd: orderd,
          expired: expired,
          buyer_name: userName,
          phone_no: phoneNo,
          plan_type: plan_type);
      print('Data store in firebase  Resp $is_data_send');

      if (resp) {
        final is_mail_send = await SendInvoiceMail(
            paymentId: uuid.v4().toString(),
            exact_amount: exact_amount,
            orderd: orderd,
            expired: expired,
            payer_name: userName,
            phone_no: phoneNo);
        print('Mail Send resp $is_mail_send');
      }

      CloseCustomPageLoadingSpinner();
      Get.toNamed(home_page_url);
    }

    // If data not uploaded completely then
    // redirect user to home view :
    if (!is_data_send['response']) {
      CloseCustomPageLoadingSpinner();
      Get.toNamed(home_page_url);
    }
  }

  /////////////////////////////////////////
  /// ERROR HANDLER :
  /// 1. Show Error Snakbar with message:
  /////////////////////////////////////////
  PaymentError(PaymentFailureResponse response) async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
        type: MySnackbarType.info,
        title: snack_info_msg,
        message: response.message));
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
    options = {
      'key': 'rzp_test_XBqgVUXDkrs93M',
      'amount': amount,
      'name': 'BeStartup',
      'description': plan_type,
      'retry': {'enabled': false, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': phone, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print('Custom Error ${e}');
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

  @override
  Widget build(BuildContext context) {
    payment_dialog_width = 0.37;
    payment_dialog_height = 0.65;
    // DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      payment_dialog_width = 0.40;
      payment_dialog_height = 0.65;

      print('1200');
    }

    if (context.width < 1000) {
      payment_dialog_width = 0.43;
      payment_dialog_height = 0.65;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      payment_dialog_width = 0.55;
      payment_dialog_height = 0.65;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      payment_dialog_width = 0.64;
      payment_dialog_height = 0.65;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      payment_dialog_width = 0.90;
      payment_dialog_height = 0.80;
      print('480');
    }

    Widget planRowView = Row(
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
    );

    Widget planColumnView = Column(
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
    );

    plan_desc_fontSize = 14;
    plan_title_fontSize = 16;
    plan_timePeriod_fontSize = 25;
    plan_price_fontSize = 30;

    card_width = 300;
    card_height = 440;
    card_padding = 20;

    body_cont_height = 580;
    body_cont_width = 10;

    con_button_width = 130;
    con_button_height = 45;
    con_btn_top_margin = 30;

    heading_col_height = 0.15;
    heading_font_size = 35;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      plan_desc_fontSize = 14;
      plan_title_fontSize = 16;
      plan_timePeriod_fontSize = 25;
      plan_price_fontSize = 30;

      card_width = 300;
      card_height = 440;
      card_padding = 20;

      body_cont_height = 580;
      body_cont_width = 10;

      con_button_width = 130;
      con_button_height = 45;
      con_btn_top_margin = 30;

      heading_col_height = 0.15;
      heading_font_size = 35;

      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      plan_title_fontSize = 14;
      plan_timePeriod_fontSize = 22;
      plan_desc_fontSize = 13;
      plan_price_fontSize = 25;

      card_width = 280;
      card_height = 430;
      card_padding = 20;

      body_cont_height = 570;
      body_cont_width = 10;

      con_button_width = 130;
      con_button_height = 45;
      con_btn_top_margin = 30;

      heading_col_height = 0.15;
      heading_font_size = 35;
      print('1000');
    }

    if (context.width < 1100) {
      plan_title_fontSize = 14;
      plan_timePeriod_fontSize = 22;
      plan_desc_fontSize = 13;
      plan_price_fontSize = 25;

      card_width = 260;
      card_height = 430;
      card_padding = 20;

      body_cont_height = 560;
      body_cont_width = 10;

      con_button_width = 130;
      con_button_height = 45;
      con_btn_top_margin = 30;

      heading_col_height = 0.15;
      heading_font_size = 35;
      print('1100');
    }

    // TABLET :
    if (context.width < 800) {
      plan_title_fontSize = 15;
      plan_timePeriod_fontSize = 23;
      plan_desc_fontSize = 14;
      plan_price_fontSize = 28;

      card_width = 290;
      card_height = 430;
      card_padding = 20;

      body_cont_height = 460;
      body_cont_width = 10;

      con_button_width = 100;
      con_button_height = 38;
      con_btn_top_margin = 30;
      con_btn_fontSize = 15;

      heading_col_height = 0.15;
      heading_font_size = 35;
      planRowView = planColumnView;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      plan_title_fontSize = 14;
      plan_timePeriod_fontSize = 22;
      plan_desc_fontSize = 13;
      plan_price_fontSize = 24;

      card_width = 290;
      card_height = 430;
      card_padding = 20;

      body_cont_height = 410;
      body_cont_width = 10;

      con_button_width = 100;
      con_button_height = 38;
      con_btn_top_margin = 30;
      con_btn_fontSize = 15;

      heading_col_height = 0.15;
      heading_font_size = 35;
      print('480');
    }

    return Container(
        color: my_theme_background_color,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Heading Section :
            PageHeading(context),

            /// PLANS SECTION :
            planRowView,

            // CONTINUE  BUTTON :
            ContinueButton(context)
          ]),
        ));
  }

//////////////////////////////////////
  /// COMPONENT SECTION :
////////////////////////////////////

  Container PageHeading(BuildContext context) {
    return Container(
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
    );
  }

  //////////////////////////////////////////
  /// Continue Button:
  //////////////////////////////////////////
  Container ContinueButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          OnpressContinue(context);
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Text(
              'continue',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: con_btn_fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////
  /// Plan Detail Widget :
  //////////////////////////////////
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
                borderRadius: const BorderRadius.all(Radius.circular(22)),
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
                                margin:
                                    const EdgeInsets.only(bottom: 5, top: 10),
                                padding: const EdgeInsets.all(5),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: type,
                                          style: TextStyle(
                                              color: active_color,
                                              fontSize: plan_title_fontSize))
                                    ]))),

                            // Time Period Container:
                            Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: period,
                                          style: TextStyle(
                                              color: color_pallet,
                                              fontSize:
                                                  plan_timePeriod_fontSize))
                                    ]))),

                            Container(
                                margin: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                padding: const EdgeInsets.all(8),
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

                            // Bottm Prize :
                            Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                padding: const EdgeInsets.all(8),
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline4,
                                        children: [
                                      TextSpan(
                                          text: amount,
                                          style: TextStyle(
                                              color: color_pallet,
                                              fontSize: plan_price_fontSize))
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
      padding: const EdgeInsets.all(5),
      child: RichText(
          text: TextSpan(style: Get.textTheme.headline5, children: [
        TextSpan(
            text: title,
            style: TextStyle(
                color: input_text_color, fontSize: plan_desc_fontSize))
      ])),
    );
  }
}
