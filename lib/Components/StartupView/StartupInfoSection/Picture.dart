import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Loader/Shimmer/StartupView/StartupViewAvtarShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card_controller.dart';

class Picture extends StatelessWidget {
  String? logo = temp_logo;
  var founder_profile;
  var founder_name;

  Picture({this.founder_name, this.founder_profile, this.logo, Key? key})
      : super(key: key);

  var detailViewState = Get.put(StartupDetailViewState());
  FlipCardController? _controller;

  var is_admin;
  var founder_id;
  var startup_id;

  double profile_top_pos = 0.19;
  double profile_left_pos = 0.01;

  double edit_icon_top_margin = 0.09;
  double edit_icon_left_margin = 0.05;

  double edit_iconSize = 19;

  double startup_logo_radius = 60;
  double ceo_profile_radius = 45;

  double ceo_name_top_margin = 10;
  double ceo_name_fontSize = 13;



  EditBusinessLogo() {
    var param = jsonEncode({
      'type': 'update',
      'founder_id': founder_id,
      'startup_id': startup_id,
      'is_admin': is_admin
    });

    Get.toNamed(create_business_detail_url, parameters: {'data': param});
  }

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    is_admin = await detailViewState.GetIsUserAdmin();
    founder_id = await detailViewState.GetFounderId();
    startup_id = await detailViewState.GetStartupId();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    profile_top_pos = 0.19;
    profile_left_pos = 0.01;

    edit_icon_top_margin = 0.09;
    edit_icon_left_margin = 0.05;

    edit_iconSize = 19;

    startup_logo_radius = 60;
    ceo_profile_radius = 45;

    ceo_name_top_margin = 10;
    ceo_name_fontSize = 13;

    // DEFAULT :
    if (context.width > 1600) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.09;
      edit_icon_left_margin = 0.05;

      edit_iconSize = 19;

      startup_logo_radius = 60;
      ceo_profile_radius = 45;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('Greator then 1600');
    }

    if (context.width < 1600) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.09;
      edit_icon_left_margin = 0.06;

      edit_iconSize = 19;

      startup_logo_radius = 60;
      ceo_profile_radius = 45;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('1600');
    }

    if (context.width < 1500) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.08;
      edit_icon_left_margin = 0.06;

      edit_iconSize = 19;

      startup_logo_radius = 55;
      ceo_profile_radius = 45;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('1500');
    }

    if (context.width < 1300) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.09;
      edit_icon_left_margin = 0.07;

      edit_iconSize = 17;

      startup_logo_radius = 55;
      ceo_profile_radius = 45;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('1300');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.09;
      edit_icon_left_margin = 0.07;

      edit_iconSize = 17;

      startup_logo_radius = 52;
      ceo_profile_radius = 42;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.08;
      edit_icon_left_margin = 0.09;

      edit_iconSize = 16;

      startup_logo_radius = 48;
      ceo_profile_radius = 40;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      profile_top_pos = 0.19;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.07;
      edit_icon_left_margin = 0.08;

      edit_iconSize = 15;

      startup_logo_radius = 36;
      ceo_profile_radius = 35;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
      print('640');
    }

    if (context.width < 550) {
      profile_top_pos = 0.16;
      profile_left_pos = 0.01;

      edit_icon_top_margin = 0.07;
      edit_icon_left_margin = 0.12;

      edit_iconSize = 14;

      startup_logo_radius = 43;
      ceo_profile_radius = 40;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 13;
    }

    // PHONE:
    if (context.width < 480) {
      profile_top_pos = 0.15;
      profile_left_pos = 0.0;

      edit_icon_top_margin = 0.07;
      edit_icon_left_margin = 0.13;

      edit_iconSize = 13;

      startup_logo_radius = 36;
      ceo_profile_radius = 35;

      ceo_name_top_margin = 10;
      ceo_name_fontSize = 11;
      print('480');
    }

    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return StartupViewAvtarShimmer();
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
  Positioned MainMethod(BuildContext context) {
    return Positioned(
        top: context.height * profile_top_pos,
        left: context.width * profile_left_pos,
        child: Stack(
          children: [
            FlipCard(
              front: StartupLogo(),
              back: CeoDetail(),
            ),
            ////////////////////////////////////////////
            /// If user is admin then show edit button :
            /// else show container :
            ////////////////////////////////////////////
            is_admin == true
                ? Positioned(
                    top: context.height * edit_icon_top_margin,
                    left: context.width * edit_icon_left_margin,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                          onPressed: () {
                            EditBusinessLogo();
                          },
                          icon: Icon(Icons.edit,
                              size: edit_iconSize, 
                              color: edit_btn_color)),
                    ))
                : Container()
          ],
        ));
  }

  Card StartupLogo() {
    return Card(
      elevation: 5,
      shadowColor: light_color_type3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
      child: Container(
        child: CircleAvatar(
            radius: startup_logo_radius,
            backgroundColor: Colors.blueGrey[100],
            foregroundImage: NetworkImage(logo ?? temp_image)),
      ),
    );
  }

  Column CeoDetail() {
    return Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: light_color_type3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
          child: Container(
              child: CircleAvatar(
            radius: ceo_profile_radius,
            backgroundColor: Colors.blueGrey[100],
            foregroundImage:
                NetworkImage(founder_profile ?? temp_image, scale: 1),
          )),
        ),

        // Container Name :
        Container(
            margin: EdgeInsets.only(top: ceo_name_top_margin),
            child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline5, children: [
              TextSpan(
                  text: founder_name.toString().capitalizeFirst,
                  style: TextStyle(
                      color: startup_profile_color, fontSize: ceo_name_fontSize))
            ])))
      ],
    );
  }
}
