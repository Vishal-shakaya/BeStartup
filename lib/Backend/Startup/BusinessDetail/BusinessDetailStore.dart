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
  static String? amount;

/////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET BUSINESS LOGO:
////////////////////////////////////////
  SetBusinessLogo({logo, filename}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: logo, filename: filename);

      // Update Image in Local Storage :
      bool is_detail = localStore.containsKey('BusinessDetail');
      if (is_detail) {
        var data = localStore.getString('BusinessDetail');
        var json_obj = jsonDecode(data!);
        json_obj["logo"] = image_url;

        localStore.setString('BusinessDetail', json.encode(json_obj));
      }

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

////////////////////////////////////////////////////
  // 1. SET BUSINESS NAME :
  // 2. ERROR CHECK :
  // 3. RETURON REPONSE TRUE OF FALSE ACCORDINGLY :
//////////////////////////////////////////////////////
  SetBusinessDetail({businessName, amount}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      if (businessName == null) {
        return ResponseBack(
            response_type: false, message: 'Startup name required');
      }

      // Validate Name :
      if (businessName == '' || businessName.length < 1) {
        return ResponseBack(response_type: false, message: 'Enter Valid Name');
      }

      // Validate Image :
      if (image_url == '' || image_url == null) {
        return ResponseBack(
            response_type: false, message: 'Startup Logo required');
      }

      business_name = businessName;
      amount = amount;

      // STORE DATA LOCALY FOR PERSISTANCE :
      final user_mail = await getuserEmail;
      final userId = await getUserId;
      var resp = await BusinessInfoModel(
          logo: image_url,
          email: user_mail,
          name: businessName,
          amount: amount,
          user_id: userId.toString());

      try {
        await SedDesireAmount(amount);
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

  GetBusinessDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('BusinessDetail');
      if (is_detail) {
        var data = localStore.getString('BusinessDetail');
        var json_obj = jsonDecode(data!);
        return {
          'name':json_obj["name"], 
          'amount':json_obj["amount"], 
        };
      }
    } catch (e) {
      return  {
          'name':'', 
          'amount':'', 
        };
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
}
