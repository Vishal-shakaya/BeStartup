import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';

import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThumbnailStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  final authUser = FirebaseAuth.instance.currentUser; 
  static String? image_url;
  static String? path;


  SetThumbnail({thumbnail, filename}) async {
    final localStore = await SharedPreferences.getInstance();
    try {

      final resp = await UploadImage(image: thumbnail, filename: filename);
      
      if (resp['response']) {
        image_url = resp['data']['url'];
        path = resp['data']['path'];
      }
      if (!resp['response']) {
        print('Error While Upload Image $resp');
      }

      try {
        var resp = await ThumbnailModel(
          thumbnail: image_url,
          path:path, 
          user_id: authUser?.uid);
        localStore.setString(getBusinessThumbnailStoreName, json.encode(resp));

        return ResponseBack(response_type: true, data: image_url);
      } catch (e) {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }


  ////////////////////////////////////////////////
// UPDATE THUMBNAIL :
// 1. Get Thum from local storage:
// 2. Get startup instance to update :
// 3. Create new instance  with updated thnbnail :
// 4. Update Firestore and localStorage :
////////////////////////////////////////////////
  UpdateThumbnail({required user_id}) async {
    var doc_id;
    try {
      // FETCHING DOCUMENT FROM FIREBASE:
      // temp_data = await thumbStore.GetThumbnailParam();

      var data;
      var thumbnail =FirebaseFirestore.instance.collection(getBusinessThumbnailStoreName);
      var query =
          thumbnail.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Thumbnail :
      data['thumbnail'] = image_url;

      //  Update Database :
      thumbnail.doc(doc_id).update(data);

      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
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
        return image_url;
      } else {
        return image_url;
      }
    } catch (e) {
      return shimmer_image;
    }
  }
}
