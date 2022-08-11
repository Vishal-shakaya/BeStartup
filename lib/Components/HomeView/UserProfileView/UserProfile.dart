import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Keys/CacheStoreKeys/CacheStoreKeys.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewUserProfile extends StatelessWidget {
  HomeViewUserProfile({Key? key}) : super(key: key);

  var user_image = temp_avtar_image;
  var user_position = '_____________';
  String? user_email = '_____________';
  var user_phoneno = '____________';
  var username = '_____________';
  var usertype; 

  ////////////////////////////////////
  /// Open Mail Box: to send mail:
  ////////////////////////////////////
  Future<void> SendMail() async {
    final founder_mail = await getStartupFounderEmail ?? '';

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    // Create url :
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '$founder_mail',
      query: encodeQueryParameters(<String, String>{
        'subject': '$startupInterestSubject',
        'body': '$startupInterestBody'
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    var user = FirebaseAuth.instance.currentUser;
     usertype = await getMycachedData(key: getUserTypeKey);
    final user_id = user?.uid;
    user_email = user?.email;

    //////////////////////////////////////////
    // If User Type Investor :
    //////////////////////////////////////////
    if (usertype == 'investor') {
      final investorConnector = Get.put(InvestorConnector());
      final investor_resp =
          await investorConnector.FetchInvestorDetailandContact(
              user_id: user_id);

      if (investor_resp['response']) {
        user_phoneno = investor_resp['data']['userContect']['phone_no'];
        username = investor_resp['data']['userDetail']['name'];
        profile_image = investor_resp['data']['userDetail']['picture'];
      }
    }

    //////////////////////////////////////////
    /// If User Type Founder then :
    //////////////////////////////////////////
    if (usertype == 'founder') {
      final founderConnector = Get.put(FounderConnector());
      final founder_resp = await founderConnector.FetchFounderDetailandContact(
          user_id: user?.uid);

      if (founder_resp['response']) {
        user_phoneno = founder_resp['data']['userContect']['phone_no'];
        user_position = founder_resp['data']['userDetail']['position'];
        username = founder_resp['data']['userDetail']['name'];
        profile_image = founder_resp['data']['userDetail']['picture'];
      }
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
                    child: MainMethod()));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod();
          }
          return MainMethod();
        });
  }

///////////////////////////////////////
  /// MainMethod:
///////////////////////////////////////
  Column MainMethod() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileImage(),
        // POSITION:
        SizedBox(
          width: 200,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              MemName(),

              SizedBox(
                height: 5,
              ),
              // CONTACT EMAIL ADDRESS :
             usertype=='founder'? MemPosition():

              MemContact(
                  func: SendMail,
                  text: user_email.toString().capitalizeFirst,
                  icon: Icons.mail_outline_outlined),

              MemContact(
                text: user_phoneno,
                icon: Icons.call,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Card ProfileImage() {
    return Card(
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(user_image),
      )),
    );
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: username,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16))
    ])));
  }

  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: user_position,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12))
    ])));
  }

  InkWell MemContact({text, icon, func}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        await func();
      },
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: Colors.orange.shade800,
              size: 16,
            ),
          ),
          AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.blueGrey.shade700,
                    fontSize: 11))
          ])),
        ],
      )),
    );
  }
}
