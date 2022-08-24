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

  EditBusinessLogo() {
    var param = jsonEncode({
      'type': 'update',
      'founder_id':founder_id,
      'startup_id':startup_id,
      'is_admin':is_admin  
    });

    Get.toNamed(
     create_business_detail_url,
     parameters: {'data': param});
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
                    top: context.height * 0.09,
                    left: context.width * 0.05,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                          onPressed: () {
                            EditBusinessLogo();
                          },
                          icon: const Icon(Icons.edit,
                              size: 19, color: Colors.black)),
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
            radius: 60,
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
            radius: 45,
            backgroundColor: Colors.blueGrey[100],
            foregroundImage:
                NetworkImage(founder_profile ?? temp_image, scale: 1),
          )),
        ),

        // Container Name :
        Container(
            margin: EdgeInsets.only(top: 10),
            child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline5, children: [
              TextSpan(
                  text: founder_name.toString().capitalizeFirst,
                  style: TextStyle(color: Colors.black, fontSize: 13))
            ])))
      ],
    );
  }
}
