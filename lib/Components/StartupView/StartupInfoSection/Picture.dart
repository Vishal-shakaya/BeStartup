import 'dart:html';

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

  var is_admin;
  double profile_top_pos = 0.19;
  double profile_left_pos = 0.01;

  FlipCardController? _controller;

  EditBusinessLogo() {
    Get.toNamed(create_business_detail_url, parameters: {'type': 'update'});
  }

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
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
                          icon: Icon(Icons.edit,
                              size: 19, color: light_color_type3)),
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
            foregroundImage: NetworkImage(logo?? temp_image)),
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
            foregroundImage: NetworkImage(founder_profile??temp_image, scale: 1),
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
