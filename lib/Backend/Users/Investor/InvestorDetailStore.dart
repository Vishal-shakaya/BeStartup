import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';

import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvestorDetailStore extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  final userStore = Get.put(UserStore());
  static Map<String, dynamic>? investor;
  static var path;
  static String? image_url;

  Map<String, dynamic> clean_resp = {
    'picture': '',
    'name': '',
    'phone_no': '',
    'primary_mail': '',
    'other_contact': '',
  };

  SetImageUrl({
    required url,
  }) async {
    image_url = url;
  }

  SetImagePath({required image_path}) {
    path = image_path;
  }

  GetImagePath() async {
    return path; 
  }

  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET PRODUCT IMAGE:
  ////////////////////////////////////////
  UploadProfileImage({image, filename}) async {
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

  // CRATE investor :
  CreateInvestor({
    required id,
    required mail,
    required primaryMail,
    required name,
    required phoneNo,
    required otherContact,
  }) async {
    try {
      final myStore = store.collection(getInvestorUserDetail);
      var investor_detail = await InvestorModel(
          user_id: id,
          email: mail,
          name: name,
          phone_no: phoneNo,
          primary_mail: primaryMail,
          other_contact: otherContact,
          path: path,
          picture: image_url);

      await myStore.add(investor_detail);
      var createUserResp = await userStore.CreateUser(usertype: 'investor');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: create_error_title);
    }
  }

  UpdateInvestorDetail({
    required user_id,
    required name,
    required email,
    required phone_no,
    required other_contact,
  }) async {
    var data_userDetail;
    var doc_id_userDetail;
    try {
      var store = FirebaseFirestore.instance.collection(getInvestorUserDetail);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      data_userDetail['name'] = name;
      data_userDetail['picture'] = image_url;
      data_userDetail['path'] = path;

      data_userDetail['email'] = email;
      data_userDetail['phone_no'] = phone_no;
      data_userDetail['other_contact'] = other_contact;

      // Update Data in DB :
      store.doc(doc_id_userDetail).update(data_userDetail);

      return ResponseBack(response_type: true);
    } catch (e) {
      print('Error While Update Investor $e');
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

  FetchInvestorDetailandContact({required user_id}) async {
    var data_userDetail;
    var doc_id_userDetail;
    var temp_userDetail;

    try {
      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getInvestorUserDetail);
      // Get User Detial Document :
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      return ResponseBack(
          response_type: true,
          message: 'Fetch Investor Detail from Firebase storage',
          data: data_userDetail);
    } catch (e) {
      return ResponseBack(
          response_type: false, message: fetch_data_error_title);
    }
  }

  GetInvestorDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('InvestorUserDetail');
      if (is_detail) {
        var detail = localStore.getString('InvestorUserDetail');

        var detail_obj = jsonDecode(detail!);

        Map<String, dynamic> temp_founder = {
          'picture': detail_obj['picture'],
          'name': detail_obj['name'],
          // 'position': detail_obj['position'],
          'phone_no': detail_obj['phone_no'],
          'primary_mail': detail_obj['primary_mail'],
          'other_contact': detail_obj['other_contact'],
        };
        return temp_founder;
      } else {
        return clean_resp;
      }
    } catch (e) {
      return clean_resp;
    }
  }

  CreateInvestorCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getInvestorUserChooseCatigory);

      // fetch catigories for local storage :
      // kye : InvestorChooseCatigory
      bool is_data = localStore.containsKey(getInvestorUserChooseCatigory);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getInvestorUserChooseCatigory);
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

  CreateInvestorDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getInvestorUserDetail);
      // kye : InvestorUserDetail

      bool is_data = localStore.containsKey(getInvestorUserDetail);
      if (is_data) {
        String? temp_data = localStore.getString(getInvestorUserDetail);
        var data = json.decode(temp_data!);

        print('Fetch Investor Detail ${data}');
        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(response_type: true);
      } else {
        return ResponseBack(
          response_type: false,
        );
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
