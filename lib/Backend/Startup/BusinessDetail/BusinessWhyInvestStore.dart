import 'dart:convert';


import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';

import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessWhyInvestStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
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
          startup_id: await startupState.GetStartupId(),
          why_text: why_text,
        );
        localStore.setString(getBusinessWhyInvesttStoreName, json.encode(resp));
        return ResponseBack(response_type: true);
      } catch (e) {
        return ResponseBack(response_type: false);
      }

      // STORE VALUE IN LOCAL VAR FOR FURTHURE USE :
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

///////////////////////////////////////////////////////
  /// It's a function that sets a variable to a value
  ///
  /// Args:
  ///   data: The data that is to be stored in the cache.
///////////////////////////////////////////////////////
  SetWhytextParam({data}) async {
    why_text = '';
    await RemoveCachedData(key: getBusinessWhyInvesttStoreName);
    why_text = data;
  }


/////////////////////////////////////////////
/// It returns a string that is the value of 
/// the variable why_text
/// 
/// Returns:
///   The value of the variable why_text.
/////////////////////////////////////////////
  GetWhytextParam() async {
    return why_text;
  }




////////////////////////////////////////////////////
/// It checks if the key exists in the local store, 
/// if it does, it returns the value of the key, if it
/// doesn't, it returns the default value
/// 
/// Returns:
///   A Future.
//////////////////////////////////////////////////////  
  GetWhyInvest() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessWhyInvesttStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessWhyInvesttStoreName);
        var json_obj = jsonDecode(data!);
        return json_obj["why_text"];
      } else {
        return why_text;
      }
    } catch (e) {
      return why_text;
    }
  }

  
}
