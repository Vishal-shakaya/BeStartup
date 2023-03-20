import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/StartupState.dart';
// import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/TeamPage/MemberBlock.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var startupConnect = Get.put(StartupViewConnector());
  var startupviewConnector = Get.put(StartupViewConnector());
  var detailViewState = Get.put(StartupDetailViewState());
  var founderStore = Get.put(FounderStore());

  double page_width = 0.80;

  double spacer = 0.02;

  double heading_fontSize = 32;

  double founder_sec_elevation = 1;

  double founder_border_radius = 10;

  double founder_cont_width = 0.20;

  double founder_cont_height = 0.34;

  double founder_cont_hori_padd = 10;

  double founder_cont_ver_padd = 20;

  double founder_cont_top_margin = 10;

  double founder_sec_padding = 12;

  double founder_spacing = 15;

  double founder_box_width = 200;

  double founder_pod_bottom_margin = 10;

  double founder_pod_fontSize = 15;

  double profile_radius = 70;

  double member_header_top_height = 0.10;

  double member_header_bottom_height = 0.05;

  double member_cont_width = 0.50;

  double member_cont_height = 0.70;

  double member__cont_hor_padd = 10;

  double member_cont_ver_padd = 20;

  double memnber_cont_top_margin = 10;

  double member_fonSize = 13;

  double member_contact_iconSize = 16;

  double member_email_fontSize = 11;

  double member_contact_padd = 5.0;

  double edit_btn_width = 0.48;

  double edit_btn_top_margin = 0.04;

  double edit_btn_cont_width = 80;

  double edit_btn_height = 30;

  double edit_btn_IconSize = 15;

  double edit_btn_fontSize = 15;

  var team_member = [];
  var user_id;
  var is_admin;
  var founder_profile;
  var primary_mail;
  var founder_name;

  // REDIRECT TO CREATE MEMEBER PAGE :
  EditMember() {
    var param = jsonEncode({
      'type': 'update',
      'user_id': user_id,
      'is_admin': is_admin,
    });

    Get.toNamed(create_business_team, parameters: {'data': param});
  }

  BackButtonRoute() {
    var param = jsonEncode({
      'user_id': user_id,
      'is_admin': is_admin,
    });

    print('startup view');
    Get.toNamed(startup_view_url, parameters: {'data': param});
  }

  //////////////////////////////////////////
  // GET REQUIREMTNS :
  //////////////////////////////////////////
  GetLocalStorageData() async {
    try {
      final param = Get.parameters;
      final paramData = jsonDecode(param['data']!);
      print('team page param $paramData');
      user_id = paramData['user_id'];
      is_admin = paramData['is_admin'];

      final data =
          await startupviewConnector.FetchBusinessTeamMember(user_id: user_id);
      team_member = data['data']['members'];

      final founder_resp =
          await founderStore.FetchFounderDetailandContact(user_id: user_id);

      if (founder_resp['response']) {
        founder_profile = founder_resp['data']['picture'] ?? shimmer_image;
        founder_name = founder_resp['data']['name'] ?? '';
        primary_mail = founder_resp['data']['primary_mail'] ??
            founder_resp['data']['email'];
      }
      if (!founder_resp['response']) {
        founder_profile = temp_image;
        founder_name = '';
        primary_mail = '';
      }

      return team_member;
    } catch (e) {
      return team_member;
    }
  }

  @override
  Widget build(BuildContext context) {
    page_width = 0.80;

    spacer = 0.02;

    heading_fontSize = 32;

    founder_sec_elevation = 1;

    founder_border_radius = 10;

    founder_cont_width = 0.20;

    founder_cont_height = 0.34;

    founder_cont_hori_padd = 10;

    founder_cont_ver_padd = 20;

    founder_cont_top_margin = 10;

    founder_sec_padding = 12;

    founder_spacing = 15;

    founder_box_width = 200;

    founder_pod_bottom_margin = 10;

    founder_pod_fontSize = 15;

    profile_radius = 70;

    member_header_top_height = 0.10;

    member_header_bottom_height = 0.05;

    member_cont_width = 0.55;

    member_cont_height = 0.70;

    member__cont_hor_padd = 10;

    member_cont_ver_padd = 20;

    memnber_cont_top_margin = 10;

    member_fonSize = 13;

    member_contact_iconSize = 16;

    member_email_fontSize = 11;

    member_contact_padd = 5.0;

    edit_btn_width = 0.48;

    edit_btn_top_margin = 0.04;

    edit_btn_cont_width = 80;

    edit_btn_height = 30;

    edit_btn_IconSize = 15;

    edit_btn_fontSize = 15;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print(' 1700');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      page_width = 0.80;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.25;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 70;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 0.60;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.48;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 80;

      edit_btn_height = 30;

      edit_btn_IconSize = 15;

      edit_btn_fontSize = 15;

      print('1500');
    }

    if (context.width < 1200) {
      page_width = 0.80;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.30;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 70;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 0.68;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.65;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 80;

      edit_btn_height = 30;

      edit_btn_IconSize = 15;

      edit_btn_fontSize = 15;
      print('1200');
    }

    if (context.width < 1100) {
      page_width = 0.80;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.35;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 70;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 0.80;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.70;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 80;

      edit_btn_height = 30;

      edit_btn_IconSize = 15;

      edit_btn_fontSize = 15;
      print('1100');
    }

    if (context.width < 900) {
      page_width = 0.80;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.45;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 70;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 0.90;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.70;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 75;

      edit_btn_height = 28;

      edit_btn_IconSize = 14;

      edit_btn_fontSize = 14;
      print('900');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      page_width = 0.80;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.50;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 65;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 0.99;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.88;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 70;

      edit_btn_height = 30;

      edit_btn_IconSize = 13;

      edit_btn_fontSize = 13;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      page_width = 0.90;

      spacer = 0.02;

      heading_fontSize = 32;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.55;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 15;

      profile_radius = 65;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 1;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.88;

      edit_btn_top_margin = 0.04;

      edit_btn_cont_width = 70;

      edit_btn_height = 30;

      edit_btn_IconSize = 13;

      edit_btn_fontSize = 13;
      print('640');
    }

    if (context.width < 600) {
      page_width = 0.90;

      spacer = 0.02;

      heading_fontSize = 28;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.65;

      founder_cont_height = 0.34;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 14;

      profile_radius = 60;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 1;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.88;

      edit_btn_top_margin = 0;

      edit_btn_cont_width = 70;

      edit_btn_height = 30;

      edit_btn_IconSize = 13;

      edit_btn_fontSize = 13;
      print('600');
    }

    // PHONE:
    if (context.width < 480) {
      page_width = 0.90;

      spacer = 0.02;

      heading_fontSize = 25;

      founder_sec_elevation = 1;

      founder_border_radius = 10;

      founder_cont_width = 0.68;

      founder_cont_height = 0.37;

      founder_cont_hori_padd = 10;

      founder_cont_ver_padd = 20;

      founder_cont_top_margin = 10;

      founder_sec_padding = 12;

      founder_spacing = 15;

      founder_box_width = 200;

      founder_pod_bottom_margin = 10;

      founder_pod_fontSize = 14;

      profile_radius = 60;

      member_header_top_height = 0.10;

      member_header_bottom_height = 0.05;

      member_cont_width = 1;

      member_cont_height = 0.70;

      member__cont_hor_padd = 10;

      member_cont_ver_padd = 20;

      memnber_cont_top_margin = 10;

      member_fonSize = 13;

      member_contact_iconSize = 16;

      member_email_fontSize = 11;

      member_contact_padd = 5.0;

      edit_btn_width = 0.88;

      edit_btn_top_margin = 0;

      edit_btn_cont_width = 65;

      edit_btn_height = 25;

      edit_btn_IconSize = 12;

      edit_btn_fontSize = 12;
      print('480');
    }

    //////////////////////////////////////////
    // SET REQUIREMTNS :
    //////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: snapshot.data == null
                  ? Text('Loading Members', style: Get.textTheme.headline2)
                  : MainMethod(context: context, data: snapshot.data),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context: context, data: snapshot.data);
          }
          return MainMethod(context: context, data: snapshot.data);
        });
  }

  Container MainMethod({context, data}) {
    return Container(
        width: MediaQuery.of(context).size.width * page_width,
        child: Container(
            child: Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  // Spacer :
                  SizedBox(height: MediaQuery.of(context).size.height * spacer),

                  // Heading :
                  StartupHeaderText(
                    title: 'Founder',
                    font_size: heading_fontSize,
                  ),

                  // Spacer :
                  SizedBox(height: MediaQuery.of(context).size.height * spacer),

                  Column(
                    children: [
                      ////////////////////////////////////////////
                      /// FOUNDER AND TEAM DTEAIL SECTION :
                      ////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            elevation: founder_sec_elevation,
                            shadowColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(founder_border_radius),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width *
                                  founder_cont_width,
                              height: MediaQuery.of(context).size.height *
                                  founder_cont_height,
                              padding: EdgeInsets.symmetric(
                                  horizontal: founder_cont_hori_padd,
                                  vertical: founder_cont_ver_padd),
                              decoration: BoxDecoration(
                                // border: Border.all(color: border_color),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.topCenter,
                              margin:
                                  EdgeInsets.only(top: founder_cont_top_margin),
                              child: Container(
                                padding: EdgeInsets.all(founder_sec_padding),

                                //////////////////////////////////
                                /// FOUNDER SECTION:
                                //////////////////////////////////
                                child: Column(
                                  children: [
                                    ProfileImage(),

                                    // SPACING:
                                    SizedBox(height: founder_spacing),

                                    // POSITION:
                                    SizedBox(
                                      width: founder_box_width,
                                      child: Column(
                                        children: [
                                          MemPosition(),
                                          MemName(),
                                          MemContact(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      /////////////////////////////////////////
                      /// TEAM MEMBER SECTION :
                      /////////////////////////////////////////
                      // SPACING :
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              member_header_top_height),

                      StartupHeaderText(
                        title: 'Members',
                        font_size: heading_fontSize,
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              member_header_bottom_height),

                      // EDIT TEAM MEMBER :
                      // REDIRECT TO CREATE TEAME PAGE :
                      EditButton(context, EditMember),

                      Card(
                        elevation: 1,
                        shadowColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              member_cont_width,
                          height: MediaQuery.of(context).size.height *
                              member_cont_height,
                          padding: EdgeInsets.symmetric(
                              horizontal: member__cont_hor_padd,
                              vertical: member_cont_ver_padd),
                          decoration: BoxDecoration(
                            // border: Border.all(color: border_color),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: memnber_cont_top_margin),
                          child: team_member.length <= 0
                              ? Container()
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return MemberBlock(member: data[index]);
                                  },
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

              Positioned(
                bottom: 10,
                right: 20,
                child: InkWell(
                  onTap: () {
                    BackButtonRoute();
                  },
                  child: Card(
                    color: Colors.blueGrey.shade500,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          ],
        )));
  }

  Container EditButton(BuildContext context, Function fun) {
    return Container(
        width: context.width * edit_btn_width,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * edit_btn_top_margin),
        child: Container(
          width: edit_btn_cont_width,
          height: edit_btn_height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                fun();
              },
              icon: Icon(
                Icons.edit,
                size: edit_btn_IconSize,
              ),
              label: Text(
                'Edit',
                style: TextStyle(fontSize: edit_btn_fontSize),
              )),
        ));
  }

  Container MemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(member_contact_padd),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade300,
            size: member_contact_iconSize,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              // text: widget.member!['member_mail'],
              text: '$primary_mail',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blue,
                  fontSize: member_email_fontSize))
        ])),
      ],
    ));
  }

  Container MemName() {
    return Container(
        alignment: Alignment.center,
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: '$founder_name',
              style: TextStyle(
                  color: Colors.blueGrey.shade700, fontSize: member_fonSize))
        ])));
  }

  Container MemPosition() {
    return Container(
        margin: EdgeInsets.only(bottom: founder_pod_bottom_margin),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              // text: widget.member!['position'],
              text: 'CEO',
              style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: founder_pod_fontSize))
        ])));
  }

  Container ProfileImage() {
    return Container(
        child: CircleAvatar(
      radius: profile_radius,
      backgroundColor: Colors.blueGrey[100],
      foregroundImage: NetworkImage(founder_profile),
    ));
  }
}
