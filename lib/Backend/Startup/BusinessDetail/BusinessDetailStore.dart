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
  static String? path;
  static bool is_update = false;

  // Set Update Page Detail :
  SetUpdateDetial({
    required updateImage,
    required updateName,
    required updateAmount}) async {
    image_url = updateImage;
    business_name = updateName;
    amount = updateAmount;
  }

  GetUpdateDetail() async {
    final data = {
      'logo': image_url,
      'name': business_name,
      'desire_amount': amount
    };
    return data; 
  }

  SetUpdateMode({required mode}) async {
    is_update = mode;
  }

  IsUpdate() async {
    return is_update;
  }

  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET BUSINESS LOGO:
  ////////////////////////////////////////
  SetBusinessLogo({logo, filename}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
     
      final resp = await UploadImage(image: logo, filename: filename);
      
      if (resp['response']) {
        image_url = resp['data']['url'];
        path = resp['data']['path'];
      }
      if (!resp['response']) {
        print('Error While Upload Image $resp');
      }


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
  CachedBusinessDetail({
    required businessName,
    required amount,
    required userId,
  }) async {
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

      var resp = await BusinessDetailMode(
        logo: image_url,
        name: businessName,
        desire_amount: amount,
        user_id: userId,
        path:path, 
      );

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
  GetCachedBusinessDetail() async {
    final localStore = await SharedPreferences.getInstance();
    final tempData = {'name': '', 'desire_amount': ''};
    try {
      bool is_detail = localStore.containsKey(getBusinessDetailStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessDetailStoreName);
        var json_obj = jsonDecode(data!);
        var sortData = {
          'name': json_obj["name"],
          'desire_amount': json_obj["desire_amount"],
          'logo': image_url
        };
        return ResponseBack(response_type: true, data: sortData);
      } else {
        return ResponseBack(response_type: false, data: tempData);
      }
    } catch (e) {
      return ResponseBack(response_type: false, data: tempData);
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
        localStore.setString(getBusinessDetailStoreName, json.encode(json_obj));
        return ResponseBack(response_type: true);
      }
    } catch (e) {
      print('Error While update Business Datail Field $e');
      return ResponseBack(response_type: false);
    }
  }

////////////////////////////////////////////////////////
// Update Business Detail:
// First update database online then :
// update localy for mantain local app state :
////////////////////////////////////////////////////////
  UpdateBusinessDetailDatabaseField(
      {required field, required val, required user_id}) async {
    // FETCHING DATA FROM FIREBASE
    var data;
    var doc_id;

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Logo:
      data[field] = val;
      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  /////////////////////////////////////////////////////////////
  /// Update Business  :
  /// It fetches data from firebase, updates it and
  ///  then updates the firebase document
  ///
  /// Args:
  ///   startup_id: This is the id of the business. Defaults to false
  ///
  /// Returns:
  ///   A Future object.
/////////////////////////////////////////////////////////////
  UpdateBusinessDetail(
      {required user_id, required name, required amount}) async {
    final detailStore = Get.put(BusinessDetailStore(), tag: 'business_store');
    var data;
    var doc_id;
    var final_startup_id;

    try {
      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Detials:
      data['logo'] = image_url;
      data['name'] = name;
      data['desire_amount'] = amount;

      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }
}
