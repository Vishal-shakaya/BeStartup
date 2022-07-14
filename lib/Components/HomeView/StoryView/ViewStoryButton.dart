import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStoryButton extends StatelessWidget {
  var startup_id;
  var founder_id;
  ViewStoryButton({
    required this.founder_id,
    required this.startup_id,
    Key? key,
  }) : super(key: key);

  // Startup Detail Link :
  StartupDetailView() async {
    var is_admin = false;
    var user_id = await getUserId;

    if (user_id == founder_id) {
      is_admin = true;
    }
    var param = {
      'founder_id': founder_id,
      'startup_id': startup_id,
      'is_admin': is_admin,
    };
    Get.toNamed(startup_view_url, parameters: {'data':jsonEncode(param)} );
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.height * 0.23,
      left: context.width * 0.38,
      child: Container(
          // width: context.width * 0.48,
          alignment: Alignment.topRight,
          // margin: EdgeInsets.only(top: context.height*0.04),
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primary_light2)),
            child: TextButton.icon(
                onPressed: () async {
                  await StartupDetailView();
                },
                icon: Icon(
                  Icons.remove_red_eye_rounded,
                  size: 15,
                  color: Colors.teal.shade500,
                ),
                label: Text(
                  'view',
                  style: TextStyle(color: Colors.teal.shade500),
                )),
          )),
    );
  }
}
