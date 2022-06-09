import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDetailStore extends GetxController {
  static String? image_url;
  static String? business_name;

/////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET BUSINESS LOGO:
////////////////////////////////////////
  SetBusinessLogo({logo, filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: logo, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // GET BUSINESS LOGO:
  GetBusinessLogo() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('BusinessDetail');
      if (is_detail) {
        var data = localStore.getString('BusinessDetail');
        var json_obj = jsonDecode(data!);
        image_url = json_obj["logo"];
        return json_obj["logo"];
      }
    } catch (e) {
      return '';
    }
  }

////////////////////////////////////////////////////
  // 1. SET BUSINESS NAME :
  // 2. ERROR CHECK :
  // 3. RETURON REPONSE TRUE OF FALSE ACCORDINGLY :
//////////////////////////////////////////////////////
  SetBusinessName(businessName) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      if (businessName == null) {
        return ResponseBack(
            response_type: false, message: 'Startup name required');
      }

      businessName = businessName.toString();
      if (businessName == '' || businessName.length < 1) {
        return ResponseBack(response_type: false, message: 'Enter Valid Name');
      }
      if (image_url == '' || image_url == null) {
        return ResponseBack(
            response_type: false, message: 'Startup Logo required');
      }
      business_name = businessName;

      // STORE DATA LOCALY FOR PERSISTANCE :
      final user_mail = await getuserEmail;
      final userId = await getUserId;
      var resp = await BusinessInfoModel(
          logo: image_url,
          email: user_mail,
          name: businessName,
          user_id: userId.toString());

      try {
        await SetStartupName(businessName);
        localStore.setString('BusinessDetail', json.encode(resp));
        return ResponseBack(response_type: true);
      } catch (e) {
        return ResponseBack(response_type: false, message: e);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  GetBusinessName() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('BusinessDetail');
      if (is_detail) {
        var data = localStore.getString('BusinessDetail');
        var json_obj = jsonDecode(data!);
        return json_obj["name"];
      }
    } catch (e) {
      return '';
    }
  }
}
