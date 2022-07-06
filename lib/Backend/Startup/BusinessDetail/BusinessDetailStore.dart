import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
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
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        json_obj["logo"] = image_url;

        localStore.setString(getBusinessDetailStoreName, json.encode(json_obj));
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

      ///////////////////////////////////
      // Create Startup
      ///////////////////////////////////
      final startup_resp = await StartupModel(
          user_id: await getUserId,
          email: await getuserEmail,
          startup_name: business_name,
          timestamp: DateTime.now().toUtc().toString());

      // Success Response :
      if (startup_resp != false) {
        await SetStartupId(startup_resp['id']);
      }
      if(startup_resp==false){
        return ResponseBack(
          response_type: false, 
          message: 'Startup not created try again ');
      }



      // Create Business Info and Cached :
      final user_mail = await getuserEmail;
      final userId = await getUserId;
      var resp = await BusinessInfoModel(
          logo: image_url,
          name: businessName,
          desire_amount: amount,
          startup_id: await getStartupId);

      // Set App state amount and startup name :
      await SedDesireAmount(amount);
      await SetStartupName(businessName);
      try {
        localStore.setString(getBusinessDetailStoreName, json.encode(resp));
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
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        return {
          'name': json_obj["name"],
          'desire_amount': json_obj["desire_amount"],
        };
      } else {
        return {
          'name': '',
          'desire_amount': '',
        };
      }
    } catch (e) {
      return {
        'name': '',
        'desire_amount': '',
      };
    }
  }

  // GET BUSINESS LOGO:
  GetBusinessLogo() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        image_url = json_obj["logo"];
        return json_obj["logo"];
      }
    } catch (e) {
      return '';
    }
  }
}
