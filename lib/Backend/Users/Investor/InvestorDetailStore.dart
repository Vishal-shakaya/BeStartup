import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvestorDetailStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  FirebaseFirestore store = FirebaseFirestore.instance;
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
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: create_error_title);
    }
  }

  GetInvestorDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('InvestorUserDetail');
      bool is_contanct = localStore.containsKey('InvestorUserContact');
      if (is_detail && is_contanct) {
        var detail = localStore.getString('InvestorUserDetail');
        var contact = localStore.getString('InvestorUserContact');

        var detail_obj = jsonDecode(detail!);
        var contact_obj = jsonDecode(contact!);

        Map<String, dynamic> temp_founder = {
          'picture': detail_obj['picture'],
          'name': detail_obj['name'],
          // 'position': detail_obj['position'],
          'phone_no': contact_obj['phone_no'],
          'primary_mail': contact_obj['primary_mail'],
          'other_contact': contact_obj['other_contact'],
        };
        return temp_founder;
      } else {
        return clean_resp;
      }
    } catch (e) {
      return clean_resp;
    }
  }
}
