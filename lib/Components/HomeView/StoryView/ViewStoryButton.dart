import 'dart:convert';

import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewStoryButton extends StatelessWidget {
  var user_id;

  ViewStoryButton({
    required this.user_id,
    Key? key,
  }) : super(key: key);

  double veiw_btn_top_pos = 0.23;
  double view_btn_left_pos = 0.38;

  double view_btn_width = 90;
  double view_btn_height = 30;
  double view_btn_icon_size = 15;

  double rounded_btn_width = 25;
  double rounded_btn_height = 25;


/////////////////////////////////////////////////////////////
// Startup Detail Link :
/// It takes the user_id and is_admin from the userState 
/// and passes it to the startup_view_url
/////////////////////////////////////////////////////////////
  StartupDetailView() async {
    var userState = Get.put(UserState());
    var is_admin = await userState.GetIsUserAdmin();

    var param = {
      'founder_id': user_id,
      'is_admin': is_admin,
    };
    Get.toNamed(startup_view_url, parameters: {'data': jsonEncode(param)});
  }



  @override
  Widget build(BuildContext context) {
    Widget viewButton = ViewButtonWithText();
    Widget roundedViewButton = RoundedViewButton();

    rounded_btn_width = 25;
    rounded_btn_height = 25;

    veiw_btn_top_pos = 0.23;
    view_btn_left_pos = 0.38;

    view_btn_width = 90;
    view_btn_height = 30;
    view_btn_icon_size = 15;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      veiw_btn_top_pos = 0.23;
      view_btn_left_pos = 0.38;

      view_btn_width = 90;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      view_btn_left_pos = 0.46;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 90;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('1500');
    }

    if (context.width < 1400) {
      view_btn_left_pos = 0.51;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 85;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('1400');
    }

    if (context.width < 1200) {
      view_btn_left_pos = 0.55;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 85;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('1200');
    }

    if (context.width < 1000) {
      view_btn_left_pos = 0.62;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 81;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      view_btn_left_pos = 0.75;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 81;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      rounded_btn_width = 30;
      rounded_btn_height = 30;

      view_btn_left_pos = 0.83;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 75;
      view_btn_height = 30;
      view_btn_icon_size = 15;
      viewButton = roundedViewButton;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      rounded_btn_width = 25;
      rounded_btn_height = 25;

      view_btn_left_pos = 0.80;
      veiw_btn_top_pos = 0.23;

      view_btn_width = 75;
      view_btn_height = 30;
      view_btn_icon_size = 15;

      viewButton = roundedViewButton;
      print('480');
    }

    return Positioned(
        top: context.height * veiw_btn_top_pos,
        left: context.width * view_btn_left_pos,
        child: viewButton);
  }

///////////////////////////////////////////////
  /// External Method :
///////////////////////////////////////////////
  Tooltip RoundedViewButton() {
    return Tooltip(
      message: 'view detail',
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: primary_light2)),
        alignment: Alignment.topRight,
        child: IconButton(
            padding: EdgeInsets.all(2),
            onPressed: () {
              StartupDetailView();
            },
            icon: Icon(
              Icons.remove_red_eye_rounded,
              size: view_btn_icon_size,
              color: view_btn_text_color,
            )),
      ),
    );
  }

  Container ViewButtonWithText() {
    return Container(
        // width: context.width * 0.48,
        alignment: Alignment.topRight,
        // margin: EdgeInsets.only(top: context.height*0.04),
        child: Container(
          width: view_btn_width,
          height: view_btn_height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: primary_light2)),
          child: TextButton.icon(
              onPressed: () {
                StartupDetailView();
              },
              icon: Icon(
                Icons.remove_red_eye_rounded,
                size: view_btn_icon_size,
                color: view_btn_text_color,
              ),
              label: Text(
                'view',
                style: TextStyle(color: view_btn_text_color),
              )),
        ));
  }
}
