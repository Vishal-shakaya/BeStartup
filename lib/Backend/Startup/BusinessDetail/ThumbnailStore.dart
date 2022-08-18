import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThumbnailStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  static String? image_url;

  SetThumbnail({thumbnail, filename}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: thumbnail, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      try {
        var resp = await ThumbnailModel(
          thumbnail: image_url,
          startup_id:await startupState.GetStartupId(),
        );

        localStore.setString(getBusinessThumbnailStoreName, json.encode(resp));
        return ResponseBack(response_type: true, data: image_url);
      } catch (e) {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  ///////////////////////////////////////////
  /// It sets the image_url to an empty string,
  /// then removes the cached data, then sets the image_url to
  /// the data passed in
  ///
  /// Args:
  ///   data: The image url
  /////////////////////////////////////////////
  SetThumbnailParam({data}) async {
    image_url = '';
    await RemoveCachedData(key: getBusinessThumbnailStoreName);
    image_url = data;
  }

  //////////////////////////////////////////////////
  /// It returns the image_url variable
  ///
  /// Returns:
  ///   The image_url variable is being returned.
  //////////////////////////////////////////////////
  GetThumbnailParam() async {
    return image_url;
  }

  //////////////////////////////////////////////////////////
  /// It checks if the key exists in the shared preferences,
  /// if it does, it returns the value of the key,
  /// if it doesn't, it returns the default value
  ///
  /// Returns:
  ///   A Future.
  //////////////////////////////////////////////////////////
  GetThumbnail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessThumbnailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessThumbnailStoreName);
        var json_obj = jsonDecode(data!);
        image_url = json_obj["thumbnail"];
        return image_url ;
      } else {
        return image_url;
      }
    } catch (e) {
      return shimmer_image;
    }
  }
}
