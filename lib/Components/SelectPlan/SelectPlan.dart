import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/Widgets/CheckoutPaymentDiagWidget.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/Widgets/BigLoadingSpinner.dart';
import 'package:be_startup/Models/StartupModels.dart';
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
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
  var founderConnector = Get.put(FounderConnector(), tag: 'founder_connector');
  var investorConnector =
      Get.put(InvestorConnector(), tag: 'investor_connector');
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');

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
      );

      var resp =
          await userStore.UpdateUserPlanAndStartup(field: 'plan', val: plan);
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
    } catch (e) {
      print(e);
      // CloseCustomPageLoadingSpinner();
      return ResponseBack(response_type: false, message: e);
    }
  }

  // SHOW  BIG LOADING SPINNER :
  StartBigLoading() {
    var dialog = SmartDialog.showLoading(
        background: Colors.white,
        maskColorTemp: Color.fromARGB(146, 252, 250, 250),
        widget: BigLoadingSpinner());
    return dialog;
  }

///////////////////////////////////////////////////////////////
// CREATE STARTUP :
  /// It creates a startup model and .
  /// pdates the user's plan and startup field in the database
///////////////////////////////////////////////////////////////
  CreateStartup() async {
    var startup = await StartupModel(
        user_id: await getUserId,
        email: await getuserEmail,
        startup_name: await getStartupName,
        desire_amount: await getDesireAmount);

    final resp = await userStore.UpdateUserPlanAndStartup(
        field: 'startups', val: startup);
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

    var resp7 = await founderConnector.CreateFounderContact();
    print(resp7);

    var resp8 = await founderConnector.CreateFounderDetail();
    print(resp8);

    var resp9 = await startupConnector.CreateBusinessTeamMember();
    print(resp9);

    var resp10 = await investorConnector.CreateInvestorContact();
    print(resp10);

    var resp11 = await investorConnector.CreateInvestorDetail();
    print(resp11);

    var resp12 = await CreateStartup();
    print(resp12);
    
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

    final orderd = DateTime.now().toUtc().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);
    var exact_amount = selectedPlan['amount'] / 100;
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    // Set UserPlan to its Profile DB :
    var resp = await SetUserPlan(
        exact_amount: exact_amount,
        orderd: orderd,
        expired: expired,
        buyer_name: userName,
        phone_no: phoneNo,
        plan_type: plan_type);

    //1. Successfuly plan created :
    print('User Plan Response $resp');

    if (resp['response']) {
      final is_data_send = await SendDataToFireStore();
      print('Data store in firebase  Resp $is_data_send');

      // 2. Success Data store in firestore :
      if (is_data_send['response']) {
        // 3. Send Bill to Founder Mail address :
        final is_mail_send = await SendInvoiceMail(
            paymentId: response.paymentId,
            exact_amount: exact_amount,
            orderd: orderd,
            expired: expired,
            payer_name: userName,
            phone_no: phoneNo);

        print('Mail Send resp $is_mail_send');
        // 4. Success Mail send :
        if (is_mail_send['response']) {
          await SuccessMailSendAlert();
        }
      }
      print('SUCCESS RESPONSE ${response.paymentId}');
      Get.toNamed(startup_view_url);
    }

    // Error Handler :
    if (!resp['response']) {
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.info,
          title: resp['message'],
          message: common_error_msg));
    }
  }

////////////////////////////////////////
  /// HANDEL EXTERNAL WALLET :
////////////////////////////////////////
  PayemtnFromExternalWallet(ExternalWalletResponse response) async {
    StartBigLoading();

    final orderd = DateTime.now().toUtc().toString();
    final plan_type = selectedPlan['plan'].toString().toLowerCase();
    final expired = await GetExpiredDate(plan_type);
    var exact_amount = selectedPlan['amount'] / 100;
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    // Set UserPlan to its Profile DB :
    var resp = await SetUserPlan(
        exact_amount: exact_amount,
        orderd: orderd,
        expired: expired,
        buyer_name: userName,
        phone_no: phoneNo,
        plan_type: plan_type);

    //1. Successfuly plan created :
    if (resp['response']) {
      final is_data_send = await SendDataToFireStore();

      // 2. Success Data store in firestore :
      if (is_data_send['response']) {
        // 3. Send Bill to Founder Mail address :
        final is_mail_send = await SendInvoiceMail(
            paymentId: response.walletName,
            exact_amount: exact_amount,
            orderd: orderd,
            expired: expired,
            payer_name: userName,
            phone_no: phoneNo);

        print('Is mail send :  ${is_mail_send}');

        //3. Success Mail send :
        if (is_mail_send['response']) {
          await SuccessMailSendAlert();
        }
      }
      print('SUCCESS RESPONSE ${response..walletName}');
      CloseCustomPageLoadingSpinner();
      Get.toNamed(startup_view_url);
    }

    // Error Handler :
    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.info,
          title: resp['message'],
          message: common_error_msg));
    }

    CloseCustomPageLoadingSpinner();
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
