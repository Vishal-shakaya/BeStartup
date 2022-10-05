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
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDetailStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

  static String? image_url;
  static String? business_name;
  static String? amount;

  ////////////////////////////////////////////
  /// Param Setter :
  ////////////////////////////////////////////
  SetBusinessLogoParam({data}) async {
    image_url = '';
    await RemoveCachedData(key: getBusinessDetailStoreName);
    image_url = data;
  }

  SetBusinessNameParam({data}) async {
    business_name = '';
    await RemoveCachedData(key: getBusinessDetailStoreName);
    business_name = data;
  }

  SetBusinessAmountParam({data}) async {
    amount = '';
    await RemoveCachedData(key: getBusinessDetailStoreName);
    amount = data;
  }

  //////////////////////////////////////////
  /// Param Getter :
  //////////////////////////////////////////
  GetBusinessNameParam() async {
    return business_name;
  }

  GetBusinessLogoParam() async {
    return image_url;
  }

  GetBusinessAmountParam() async {
    return amount;
  }

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

      ///////////////////////////////////////////////
      // Create Startup
      ///////////////////////////////////////////////
      final startup_resp = await StartupModel(
          user_id: await userState.GetUserId(),
          email: await userState.GetDefaultMail(),
          startup_name: business_name,
          timestamp: DateTime.now().toString());


      ///////////////////////////////////////////
      // Success Response :
      // Set Set Startup Id :
      // Store localy startup :
      ///////////////////////////////////////////
      if (startup_resp != false) {
        await startupState.SetStartupId(id: startup_resp['id']);
        localStore.setString(getStartupStoreName, json.encode(startup_resp));
      }

      if (startup_resp == false) {
        return ResponseBack(
            response_type: false, message: 'Startup not created try again ');
      }

      // Create Business Info and Cached :
      final user_mail = await userState.GetDefaultMail();
      final userId = await userState.GetUserId();
      final founder_name = await userState.GetProfileName();

      final startup_searching_index =
          await CreateSearchIndexParam(businessName);

      final founder_searching_index =
          await CreateSearchIndexParam(founder_name);

      var resp = await BusinessInfoModel(
          logo: image_url,
          founder_name: founder_name,
          name: businessName,
          founder_id: userId,
          desire_amount: amount,
          startup_search_index: startup_searching_index,
          founder_search_index: founder_searching_index,
          startup_id: await startupState.GetStartupId());

      // Set App state amount and startup name :
      await startupState.SetDesireAmount(amount: amount);
      await startupState.SetStartupName(name: businessName);

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

///////////////////////////////////////////////////////////
  /// If the key exists in the local store, return
  /// the value of the key. If the key doesn't exist, return
  /// the default value
  ///
  /// Returns:
  ///   A map with two keys, name and desire_amount.
///////////////////////////////////////////////////////////
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
          'name': business_name ?? '',
          'desire_amount': amount ?? '',
        };
      }
    } catch (e) {
      return {
        'name': '',
        'desire_amount': '',
      };
    }
  }

////////////////////////////////////////////
// GET BUSINESS LOGO:
////////////////////////////////////////////
  GetBusinessLogo() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        image_url = json_obj["logo"];
        return image_url;
      } else {
        return image_url;
      }
    } catch (e) {
      return shimmer_image;
    }
  }

////////////////////////////////////////////////
  /// Update Perticular Business Detail field
  ///  required param val and update field name :
////////////////////////////////////////////////

  UpdateBusinessDetailCacheField({required field, required val}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);

      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        json_obj[field] = val;

        localStore.setString(getBusinessDetailStoreName, json.encode(json_obj));
        return ResponseBack(response_type: true);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

////////////////////////////////////////////////////////
// Update Business Detail:
// First update database online then :
// update localy for mantain local app state :
////////////////////////////////////////////////////////
  UpdateBusinessDetailDatabaseField(
      {required field, required val, required startup_id}) async {
    // FETCHING DATA FROM FIREBASE
    var data;
    var doc_id;

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store.where('startup_id', isEqualTo: startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Logo:
      data[field] = val;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessDetailStoreName, data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
