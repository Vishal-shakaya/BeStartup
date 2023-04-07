import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FounderStore extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

  static Map<String, dynamic>? founder;
  static var image_url;
  static var picture = '';
  static var name = '';
  static var phone_no = '';
  static var primary_mail = '';
  static var other_contact = '';
  static var path = '';

  static Map<String, dynamic> founder_obj = {
    'picture': picture,
    'name': name,
    // 'position': position,
    'phone_no': phone_no,
    'primary_mail': primary_mail,
    'other_contact': other_contact,
  };

  SetImageUrl({
    required url,
  }) async {
    image_url = url;
  }

  SetImagePath({required image_path}) {
    path = image_path;
  }

  GetImagePath() {
    return path;
  }

  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET PRODUCT IMAGE:
  ////////////////////////////////////////
  UploadFounderImage({image, filename}) async {
    try {
      final resp = await UploadImage(image: image, filename: filename);

      if (resp['response']) {
        image_url = resp['data']['url'];
        path = resp['data']['path'];
      }

      if (!resp['response']) {
        print('Error While Upload Image $resp');
      }

      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // CRATE FOUNDER :
  CachedCreateFounder({
    required user_id,
    required name,
    required email,
    required phone_no,
    required primary_mail,
    required other_contact,
  }) async {
    var localStore = await SharedPreferences.getInstance();

    try {
      try {
        var resp = await FounderModel(
            user_id: user_id,
            name: name,
            email: email,
            primary_mail: primary_mail,
            phone_no: phone_no,
            other_contact: other_contact,
            path: path,
            picture: image_url);

        localStore.setString(
            getBusinessFounderDetailStoreName, json.encode(resp));
        ;

        return ResponseBack(response_type: true, message: create_error_title);
      } catch (e) {
        ResponseBack(response_type: false, message: e);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  ///////////////////////////////////////////////////////////
  /// It checks if the key exists in the shared preferences,
  /// if it does, it returns the value of the key,
  /// if it doesn't, it returns the default value
  /// Returns:
  ///   A Future<ResponseBack>
  ///////////////////////////////////////////////////////////
  GetCachedFounderDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail =
          localStore.containsKey(getBusinessFounderDetailStoreName);
      if (is_detail) {
        var detail = localStore.getString(getBusinessFounderDetailStoreName);

        var detail_obj = jsonDecode(detail!);

        Map<String, dynamic> temp_founder = {
          'picture': detail_obj['picture'],
          'name': detail_obj['name'],
          // 'position': detail_obj['position'],
          'phone_no': detail_obj['phone_no'],
          'primary_mail': detail_obj['primary_mail'],
          'other_contact': detail_obj['other_contact'],
        };
        return ResponseBack(response_type: true, data: temp_founder);
      } else {
        return ResponseBack(response_type: true, data: founder_obj);
      }
    } catch (e) {
      return founder_obj;
    }
  }

//////////////////////////////////////////////////////////
  ///  Database Handler
//////////////////////////////////////////////////////////

// Create Founder Detail :
  CreateFounderDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessFounderDetailStoreName);

      // fetch catigories for local storage :
      // kye : FounderUserDetail
      bool is_data = localStore.containsKey(getBusinessFounderDetailStoreName);

      // Validate key :
      if (is_data) {
        String? temp_data =
            localStore.getString(getBusinessFounderDetailStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(response_type: true);
      } else {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

/////////////////////////////////////////////
  /// GET FOUNDER DETAIL :
/////////////////////////////////////////////
  FetchFounderDetailandContact({required user_id}) async {
    var data_userDetail;
    var doc_id_userDetail;

    try {
      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance
          .collection(getBusinessFounderDetailStoreName);

      // Get User Detial Document :
      var query = store.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      return ResponseBack(
          response_type: true,
          message: 'Fetch Founder Detail from Firebase storage',
          data: data_userDetail);
    } catch (e) {
      return ResponseBack(
          response_type: false,
          message: fetch_data_error_title,
          data: shimmer_image);
    }
  }

////////////////////////////////////////////////////
  /// UPDATIN USER DETAIL AND CONTACT BOTH:
  /// I'm fetching data from firebase and storing it in a
  /// variable, then I'm fetching data from cache
  /// storage and storing it in a variable, then
  /// I'm updating the data in firebase with the data from
  /// cache storage
////////////////////////////////////////////////////
  UpdateFounderDetail({required user_id, required data}) async {
    var data_userDetail;
    var doc_id_userDetail;
    var final_user_id;
    var picture = '';
    var name = '';
    var position = '';
    var phone_no = '';
    var primary_mail = '';
    var other_contact = '';

    try {
      picture = image_url;
      name = data['name'];
      phone_no = data['phone_no'];
      primary_mail = data['primary_mail'];
      other_contact = data['other_contact'];

      // FETCHING DATA FROM FIREBASE
      var detailStore = FirebaseFirestore.instance
          .collection(getBusinessFounderDetailStoreName);

      // Get User Detial Document :
      var query = detailStore.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      data_userDetail['name'] = name;
      data_userDetail['picture'] = picture;
      data_userDetail['primary_mail'] = primary_mail;
      data_userDetail['phone_no'] = phone_no;
      data_userDetail['other_contact'] = other_contact;
      data_userDetail['path'] = path;

      detailStore.doc(doc_id_userDetail).update(data_userDetail);

      return ResponseBack(response_type: true);
    } catch (e) {
      print('Error While Updating Founder Detail $e');
      return ResponseBack(
          response_type: false,
          message: update_error_title,
          data: shimmer_image);
    }
  }
}
