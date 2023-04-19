import 'dart:convert';

import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Helper/MailServer.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

VerifyStartupDetial() async {
  try {
    final localStore = await SharedPreferences.getInstance();
    bool is_catigory = localStore.containsKey(getBusinessCatigoryStoreName);
    bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
    bool is_product = localStore.containsKey(getBusinessProductStoreName);
    bool is_thumbnail = localStore.containsKey(getBusinessThumbnailStoreName);
    bool is_vision = localStore.containsKey(getBusinessVisiontStoreName);
    bool is_team = localStore.containsKey(getBusinessTeamMemberStoreName);
    bool is_why = localStore.containsKey(getBusinessWhyInvesttStoreName);
    bool is_mile = localStore.containsKey(getBusinessMilestoneStoreName);
    bool is_pitch = localStore.containsKey(getBusinessPitchtStoreName);
    bool is_founder = localStore.containsKey(getBusinessFounderDetailStoreName);

    if (is_catigory) {
      print('Found [Catigory]');
    }
    if (!is_catigory) {
      print('Not Found [Catigory]');
    }

    if (is_detail) {
      print('Found [Detail]');
    }
    if (!is_detail) {
      print('Not Found [Detail]');
    }

    if (is_product) {
      print('Found [Product]');
    }
    if (!is_product) {
      print('Not Found [Product]');
    }

    if (is_thumbnail) {
      print('Found [Thumbnail]');
    }
    if (!is_thumbnail) {
      print('Not Found [Thumbnail]');
    }

    if (is_vision) {
      print('Found [Vision]');
    }
    if (!is_vision) {
      print('Not Found [Vision]');
    }

    if (is_team) {
      print('Found [Team]');
    }
    if (!is_team) {
      print('Not Found [Team]');
    }

    if (is_why) {
      print('Found [Why]');
    }
    if (!is_why) {
      print('Not Found [Why]');
    }

    if (is_mile) {
      print('Found [Mile]');
    }
    if (!is_mile) {
      print('Not Found [Mile]');
    }

    if (is_pitch) {
      print('Found [Pitch]');
    }
    if (!is_pitch) {
      print('Not Found [Pitch]');
    }

    if (is_founder) {
      print('Found [Founder]');
    }
    if (!is_founder) {
      print('Not Found [Founder]');
    }

    if (is_pitch == true &&
        is_mile == true &&
        is_team == true &&
        is_why == true &&
        is_detail == true &&
        is_product == true &&
        is_thumbnail == true &&
        is_vision == true &&
        is_catigory == true) {
      return ResponseBack(response_type: true);
    } else {
      return ResponseBack(response_type: false);
    }
  } catch (e) {
    return ResponseBack(response_type: false);
  }
}

//////////////////////////////////////////////////
/// 1 Add Founder and startup name Serach Index :
//////////////////////////////////////////////////
ConfigureBusinessDetailModel() async {
  try {
    final businessDetailStore = BusinessDetailStore();
    final founderStore = FounderStore();

    final response = await businessDetailStore.GetCachedBusinessDetail();
    final founderResp = await founderStore.GetCachedFounderDetail();

    var businessName = '';
    var founderName = '';

    if (response['response']) {
      final data = response['data'];
      businessName = data['name'];
    }
    if (founderResp['response']) {
      final data = founderResp['data'];
      founderName = data['name'];
    }

    final startup_searching_index = await CreateSearchIndexParam(businessName);
    final founder_searching_index = await CreateSearchIndexParam(founderName);
    print('business Name $businessName');
    print('business index name ${startup_searching_index}');

    print('founder name $founderName');
    print('founder index $founder_searching_index');

    await businessDetailStore.UpdateBusinessDetailCacheField(
        field: 'startup_searching_index', val: startup_searching_index);
    await businessDetailStore.UpdateBusinessDetailCacheField(
        field: 'founder_searching_index', val: founder_searching_index);

    return ResponseBack(response_type: true);
  } catch (e) {
    return ResponseBack(response_type: false);
  }
}

// Helping function for getting expiration date :
GetExpiredDate(plan_type) async {
  var expired;

  if (plan_type == 'Basic') {
    expired =
        EmailFormatedDate(date: DateTime.now().add(const Duration(days: 60)));
    print('Basic plan Selected');
  }
  if (plan_type == 'Best') {
    expired =
        EmailFormatedDate(date: DateTime.now().add(const Duration(days: 180)));
    print('Best plan Selected');
  }
  if (plan_type == 'Business') {
    print('Business plan Selected');
    expired =
        EmailFormatedDate(date: DateTime.now().add(const Duration(days: 360)));
  }

  return expired;
}

///////////////////////////////////////////
/// 1. Update user Profile with plan :
/// 2. if user plan activate thne show Alert :
/// for plan is already activated :
/// 3. else activate plan :
///////////////////////////////////////////
CreateBusinessPlan({
  required plan_price,
  required orderd,
  required buyer_name,
  required phone_no,
  required plan_type,
}) async {
  final localStore = await SharedPreferences.getInstance();
  final authUser = FirebaseAuth.instance.currentUser;

  // Activate User Plan :
  try {
    final plan = await PlanModel(
        plan_name: plan_type ?? '',
        phone_no: phone_no ?? '',
        amount: plan_price ?? '',
        order_date: orderd ?? '',
        expire_date: await GetExpiredDate(plan_type),
        buyer_mail: authUser?.email,
        buyer_name: buyer_name,
        user_id: authUser?.uid);

    final is_planCreate =
        await localStore.setString(getStartupPlansStoreName, json.encode(plan));
    return ResponseBack(response_type: true);
  } catch (e) {
    return ResponseBack(response_type: false, message: e);
  }
}

///////////////////////////////////////////////////////////////
/// CREATE STARTUP :
/// It creates a startup model and .
/// pdates the user's plan and startup field in the database
///////////////////////////////////////////////////////////////
UploadStartupData() async {
  final startupConnector = Get.put(StartupConnector());
  final founderStore = Get.put(FounderStore());
  final userStore = Get.put(UserStore());

  var foundResp = founderStore.CreateFounderDetail();
  print(foundResp);

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

  var creaetPlanResp = await startupConnector.CreateBusinessPlans();
  print(creaetPlanResp);

  var createUserResp = await userStore.CreateUser(usertype: 'founder');
  print(createUserResp);

  return ResponseBack(response_type: true);
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
    required mail,
    required phone_no}) async {
  var resp;
  try {
    resp = await SendMailToUser(
        transaction_id: '12',
        phone_no: phone_no == null ? '' : phone_no,
        amount: exact_amount.toString(),
        receiver_mail_address: mail,
        subject: ' Bestartup Payment Statement ',
        order_date: orderd,
        expire_date: expired,
        payer_name: payer_name);

    return ResponseBack(response_type: true, data: resp);
  } catch (e) {
    return ResponseBack(response_type: false);
  }
}
