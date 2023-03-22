import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';

import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class BusinessPitchStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  static var pitch;

////////////////////////////////////////////////////////////
/// It takes a string as an argument, and then it
/// stores it in a local variable, and then it stores it
/// in a local storage
///
/// Args:
///   visionText: The text that the user e
///   nters in the text field.
///
/// Returns:
///   ResponseBack is a class that has a
///   response_type and message.
///////////////////////////////////////////////////////
  SetPitch({ 
    required pitchText , 
    required user_id,
    required pitchPath,  }) async {
    final localStore = await SharedPreferences.getInstance();
    
    try {
      // NULL CHECK :
      if (pitchText == null) {
        return ResponseBack(
            response_type: false, message: 'pitch url is required');
      }

      pitch = pitchText;
      
      try {
        var resp = await PitchModel(
          user_id: user_id,
          pitch: pitch,
          path: pitchPath
        );

        localStore.setString(getBusinessPitchtStoreName, json.encode(resp));
        return ResponseBack(response_type: true);
      }
      
       catch (e) {
        return ResponseBack(response_type: false, message: create_error_title);
      }

      // STORE VALUE IN LOCAL VAR FOR FURTHURE USE :
    } catch (e) {
      return ResponseBack(response_type: false, message: create_error_title);
    }
  }

//////////////////////////////////////////////////////////
  // Set Vision to Static variable :
  ///
  /// The function is called from a dropdown menu, and it
  /// sets the value of the variable "vision" to the
  /// value of the dropdown menu
  ///
  /// Args:
  ///   data: The data to be stored in the cache.
//////////////////////////////////////////////////////////
  SetPitchParam({data}) async {
    pitch = '';
    await RemoveCachedData(key: getBusinessPitchtStoreName);
    pitch = data;
  }

//////////////////////////////////////////////
  /// It returns a Future of type pitch
  ///
  /// Returns:
  ///   The pitch object.
//////////////////////////////////////////////
  GetPitchParam() async {
    return pitch;
  }

///////////////////////////////////////////////
  /// It checks if the key exists in the local storage,
  ///  if it does, it gets the value of the key and
  /// returns it
  /// Returns:
  ///   A Future&lt;String&gt;
/////////////////////////////////////////////////
  GetPitch() async {
    final localStore = await SharedPreferences.getInstance();
   
    try {
      bool is_detail = localStore.containsKey(getBusinessPitchtStoreName);
      
      if (is_detail) {
        var data = localStore.getString(getBusinessPitchtStoreName);
        var json_obj = jsonDecode(data!);
        pitch = json_obj["pitch"];
        return pitch;
      
      }
      
       else {
        return pitch;
      }
    } catch (e) {
      return pitch;
    }
  }
}
