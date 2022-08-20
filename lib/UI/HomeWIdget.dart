import 'package:be_startup/Handlers/UserRegistration/Login.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/UI/HomeView/HomeView.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHomeWidget extends StatelessWidget {
  MainHomeWidget({Key? key}) : super(key: key);

  final userState = Get.put(UserState());
  final userStore = Get.put(UserStore());
  final founderConnector = Get.put(FounderConnector());
  final investorConnector = Get.put(InvestorConnector());

  var user_name;
  var user_profile;
  var primary_mail;
  var registor_mail;
  var default_mail;
  var phoneNo;
  var otherContact;
  var user_id;

  var spinner = Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    padding: EdgeInsets.all(8),
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: dartk_color_type3,
      strokeWidth: 5,
    ),
  );

  GetLocalStorageData() async {
    final resp = await userStore.FetchUserDetail();
    user_id = resp['data']['id'];

    await userState.SetUserId(id: user_id);
    // 1 CHECK  :
    // If user user type is investor or founder
    // if both are false then show user type page :
    if (resp['data']['is_investor'] == false &&
        resp['data']['is_founder'] == false) {
      Get.toNamed(user_type_slide_url);
    }

    // 2 CHECK  :
    // If user user type is investor or founder
    // if any one is true then send Home View
    if (resp['data']['is_investor'] == true ||
        resp['data']['is_founder'] == true) {
      ////////////////////////////////////////
      // INVESTOR HANDLER :
      ////////////////////////////////////////
      if (resp['data']['is_investor'] == true) {
        final invest_resp =
            await investorConnector.FetchInvestorDetailandContact(
                user_id: user_id);

        // Investor Success Handler :
        if (invest_resp['response']) {
          print(' [ SETUP INVESTOR DETAIL ] ');

          user_profile = invest_resp['data']['userDetail']['picture'];
          user_name = invest_resp['data']['userDetail']['name'];
          registor_mail = invest_resp['data']['userDetail']['email'];

          primary_mail = invest_resp['data']['userContect']['primary_mail'];
          phoneNo = invest_resp['data']['userContect']['phone_no'];
          otherContact = invest_resp['data']['userContect']['other_contact'];

          primary_mail = await CheckAndGetPrimaryMail(
              primary_mail: primary_mail, default_mail: registor_mail);

          await userState.SetProfileImage(image: user_profile);
          await userState.SetProfileName(name: user_name);
          await userState.SetDefaultUserMail(mail: registor_mail);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetPhoneNo(number: phoneNo);
          await userState.SetOtherContact(contact: otherContact);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetUserType(type: UserType.investor);
        }
        // Founder Error Handler :
        if (!invest_resp['response']) {
          print(' ****** Fetch Investor Profile Error  [ HomeView ]******** ');
          print(invest_resp);
        }
      }

      ////////////////////////////////////////////
      /// FOUNDER HANDLER :
      ////////////////////////////////////////////
      if (resp['data']['is_founder'] == true) {
        final found_resp = await founderConnector.FetchFounderDetailandContact(
            user_id: user_id);

        // Founder Success Handler :
        if (found_resp['response']) {
          print('[ SETUP FOUNDER DETAIL ] ');

          user_profile = found_resp['data']['userDetail']['picture'];
          user_name = found_resp['data']['userDetail']['name'];
          registor_mail = found_resp['data']['userDetail']['email'];

          primary_mail = found_resp['data']['userContect']['primary_mail'];
          phoneNo = found_resp['data']['userContect']['phone_no'];
          otherContact = found_resp['data']['userContect']['other_contact'];

          primary_mail = await CheckAndGetPrimaryMail(
              primary_mail: primary_mail, default_mail: registor_mail);

          await userState.SetProfileImage(image: user_profile);
          await userState.SetProfileName(name: user_name);
          await userState.SetDefaultUserMail(mail: registor_mail);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetPhoneNo(number: phoneNo);
          await userState.SetOtherContact(contact: otherContact);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetUserType(type: UserType.founder);
        }

        // Founder Error Handler :
        if (!found_resp['response']) {
          print('****** Fetch Founder Profile Error  [ HomeView ]******** ');
          print(found_resp);
        }
      }
    }

    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return spinner;
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // SHOW ERROR :
              ErrorPage();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return spinner;
            }

            if (snapshot.hasData) {
              // Check Login user complete profile setup or not :
              // if Complete then redirect to
              // Configure App local state :
              // SetAppLocalState();
              return HomeView();
            }
            return LoginHandler();
          }),
    );
  }
}
