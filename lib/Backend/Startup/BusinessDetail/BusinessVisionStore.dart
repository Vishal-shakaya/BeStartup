import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Models/StartupModels.dart';
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
            user_id: getUserId,
            email: getuserEmail,
            vision: vision,
            startup_name: getStartupName);
        localStore.setString('BusinessVision', json.encode(resp));
        return ResponseBack(response_type: true);
      } 
      catch (e) {
        return ResponseBack(response_type: false);
      }

      // STORE VALUE IN LOCAL VAR FOR FURTHURE USE :
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // Return Vision:
  GetVision() async {
    try {
      return vision;
    } catch (e) {
      return ResponseBack(
        response_type: false,
      );
    }
  }
}
