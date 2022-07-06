import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessVisionStore extends GetxController {
  static var vision;
  // Set Vision
  SetVision({visionText}) async {
    final localStore = await SharedPreferences.getInstance();

    try {
      // NULL CHECK :
      if (visionText == null) {
        return ResponseBack(
            response_type: false, message: 'vision is required');
      }

      vision = visionText;
      try {
        var resp = await VisionModel(
            startup_id: await getStartupId,
            vision: vision,
            );
        localStore.setString(getBusinessVisiontStoreName, json.encode(resp));
        return ResponseBack(response_type: true);
      } 
      catch (e) {
        return ResponseBack(response_type: false ,message: create_error_title);
      }

      // STORE VALUE IN LOCAL VAR FOR FURTHURE USE :
    } catch (e) {
      return ResponseBack(response_type: false ,message: create_error_title);
    }
  }

  // Return Vision:
   GetVision() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessVisiontStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessVisiontStoreName);
        var json_obj = jsonDecode(data!);
        return json_obj["vision"];
      }
    } catch (e) {
      return '';
    }
  }
}
