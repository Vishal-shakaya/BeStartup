import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessWhyInvestStore extends GetxController {
  static var why_text;
  // Set Vision
  SetWhyInvest({visionText}) async {
    final localStore = await SharedPreferences.getInstance();

    try {
      // NULL CHECK :
      if (visionText == null) {
        return ResponseBack(
            response_type: false, message: 'Why section is required');
      }

      why_text = visionText;
      try {
        var resp = await WhyInvestModel(
            user_id: await getUserId,
            email: await getuserEmail,
            startup_name: await getStartupName,
            why_text: why_text,
            );
        localStore.setString('BusinessWhyInvest', json.encode(resp));
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
   GetWhyInvest() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('BusinessWhyInvest');
      if (is_detail) {
        var data = localStore.getString('BusinessWhyInvest');
        var json_obj = jsonDecode(data!);
        return json_obj["why_text"];
      }
    } catch (e) {
      return '';
    }
  }
}
