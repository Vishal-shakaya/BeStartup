import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessCatigoryStore extends GetxController {
  // LOCAL STORAGE:

  static List<String> catigories = [];

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
  // Return Vision:
  GetCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('BusinessCatigory');
      if (is_detail) {
        var data = localStore.getString('BusinessCatigory');
        var json_obj = jsonDecode(data!);
        print('data $json_obj');
        return json_obj["catigory"];
      }
    } catch (e) {
      return [''];
    }
  }

  // STORE CATIGORY LOCALY :
  PersistCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var resp = await CatigoryModel(
          user_id: getUserId,
          email: getuserEmail,
          startup_name: getStartupName,
          catigory: catigories);

      localStore.setString('BusinessCatigory', json.encode(resp));
      return ResponseBack(response_type: true);
    } catch (e) {
      print(e);
      return ResponseBack(response_type: false);
    }
  }
}
