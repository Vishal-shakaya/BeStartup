import 'dart:convert';


import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class InvestorCatigoryStore extends GetxController {
    var userState = Get.put(UserState());

  // LOCAL STORAGE:
  static var catigories = [];

  // SET CATIGORY :
  SetCatigory({cat}) async {
    try {
      catigories.add(cat);
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
  GetCatigories() {
    try {
      return catigories;
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }



    // STORE CATIGORY LOCALY :
  PersistCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var resp = await InvestorCatigoryModel(
          user_id: await userState.GetUserId(),
          catigory: catigories);

      localStore.setString('InvestorChooseCatigory', json.encode(resp));
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
