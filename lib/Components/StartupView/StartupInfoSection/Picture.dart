import 'dart:html';

import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Picture extends StatelessWidget {
  String? logo = temp_logo;
  Picture({this.logo, Key? key}) : super(key: key);

  var is_admin;
  double profile_top_pos = 0.19;
  double profile_left_pos = 0.01;

  EditBusinessLogo() {
    Get.toNamed(create_business_detail_url, parameters: {'type': 'update'});
  }

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    is_admin = await getIsUserAdmin;
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
                    child: CustomShimmer(
                      text: 'profiel',
                      shape: ShimmerAvtar(),
                    )));
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
            Card(
              elevation: 5,
              shadowColor: light_color_type3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(62)),
              child: Container(
                child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blueGrey[100],
                    foregroundImage: NetworkImage(logo!)),
              ),
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

  //////////////////////////////////////
  /// Shimmer Section :
  //////////////////////////////////////
    Card ShimmerAvtar() {
    return Card(
        elevation: 5,
        shadowColor: light_color_type3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(62)),
        child: Container(
          child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueGrey[100],
              foregroundImage: NetworkImage(logo!)),
        ),
      );
  }

}
