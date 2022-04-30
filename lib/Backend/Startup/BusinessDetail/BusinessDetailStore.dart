import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDetailStore extends GetxController {
  static String? image_url;
  static String? business_name;
  FirebaseFirestore store = FirebaseFirestore.instance;
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
  GetBusinessLogo() {
    return image_url;
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
      var resp = await BusinessInfoModel(
          logo: image_url,
          email: getuserEmail,
          name: businessName,
          user_id: getUserId);

      try {
        localStore.setString('BusinessDetail', json.encode(resp));
        return ResponseBack(response_type: true);
      } catch (e) {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetBusinessName() {
    return business_name;
  }
}
