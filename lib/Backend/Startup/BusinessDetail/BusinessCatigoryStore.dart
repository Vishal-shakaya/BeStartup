import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';

import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessCatigoryStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

  static List<String> catigories = [];
  static List<String> temp_catigories = [];

  // SET CATIGORY :
  SetCatigory({cat}) async {
    try {
      catigories.add(cat);
      return await ResponseBack(response_type: true);
    } catch (e) {
      return await ResponseBack(response_type: false);
    }
  }

  // Store catigory for temprory for update catigory purpose:
  SetTempCatigory({cat}) async {
    try {
      temp_catigories.add(cat);
      return await ResponseBack(response_type: true);
    } catch (e) {
      return await ResponseBack(response_type: false);
    }
  }

  // REMOVE CATIGORY AND RETURN RESPONSE
  // IF SUCCESS OR FAIL :
  RemoveCatigory({cat}) async {
    try {
      catigories.remove(cat);
      return await ResponseBack(response_type: true);
    } catch (e) {
      return await ResponseBack(response_type: false);
    }
  }

  // GET LIST TO CATIGORY:
  // Return Vision:
  GetCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessCatigoryStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessCatigoryStoreName);
        var json_obj = jsonDecode(data!);
        return json_obj["catigories"].toList();
      } else {
        return catigories;
      }
    } catch (e) {
      return catigories;
    }
  }

  // STORE CATIGORY LOCALY :
  PersistCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    var main_cat = catigories + temp_catigories;
    final startup_id = await startupState.GetStartupId();
    // print('vision startup id ${startup_id}');
    try {
      // var resp =
      //     await CatigoryModel(startup_id: startup_id, catigory: catigories);

      // localStore.setString(getBusinessCatigoryStoreName, json.encode(resp));
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
