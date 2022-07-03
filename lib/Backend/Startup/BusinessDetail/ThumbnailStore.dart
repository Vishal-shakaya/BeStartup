import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThumbnailStore extends GetxController {
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
            user_id: await getUserId,
            email: await getuserEmail,
            startup_name: await getStartupName);

        localStore.setString(getBusinessThumbnailStoreName, json.encode(resp));
        return ResponseBack(response_type: true, data: image_url);
      } catch (e) {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetThumbnail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessThumbnailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessThumbnailStoreName);
        var json_obj = jsonDecode(data!);
        return json_obj["thumbnail"];
      }
    } catch (e) {
      return '';
    }
  }

  
}
