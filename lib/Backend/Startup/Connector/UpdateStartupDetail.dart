import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StartupUpdater extends GetxController {
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');

  ////////////////////////////////////////
  // CUSTOM CACHING  SYSTEM :
  // GET DATA FROM LOCAL STORGE
  ////////////////////////////////////////
  GetCachedData(fromModel) async {
    final localStore = await SharedPreferences.getInstance();
    var is_localy_store = localStore.containsKey(fromModel);

    if (is_localy_store) {
      var data = localStore.getString(fromModel);

      // Validata data :
      if (data != null || data != '') {
        var final_data = json.decode(data!);
        Map<String, dynamic> cacheData = final_data as Map<String, dynamic>;
        if (cacheData['email'] == await getuserEmail &&
            cacheData['user_id'] == await getUserId) {
          return final_data;
        }
      }
    } else {
      return false;
    }
  }

  //////////////////////////////////////////
  // Cached Update Data :
  //////////////////////////////////////////
  StoreCacheData({fromModel, data}) async {
    try {
      final localStore = await SharedPreferences.getInstance();
      if (data != null || data != '') {
        localStore.setString(fromModel, json.encode(data));
        print('Cached Data Successfully');
        return true;
      }
    } catch (e) {
      return false;
    }
  }

////////////////////////////////////////////////
// UPDATE THUMBNAIL :
// 1. Get Thum from local storage:
// 2. Get startup instance to update :
// 3. Create new instance  with updated thnbnail :
// 4. Update Firestore and localStorage :
////////////////////////////////////////////////
  UpdateThumbnail() async {
    var temp_data;
    var doc_id;
    try {
      /// Fetch thumbnail from localStorage :
      final cacheData = await GetCachedData('BusinessThumbnail');
      if (cacheData != false) {
        temp_data = cacheData['thumbnail'];
      }

      // FETCHING DOCUMENT FROM FIREBASE:
      var data;
      var thumbnail =
          FirebaseFirestore.instance.collection('BusinessThumbnail');
      var query = thumbnail
          .where(
            'email',
            isEqualTo: await getuserEmail,
          )
          .where('user_id', isEqualTo: await getUserId)
          .where('startup_name', isEqualTo: await getStartupName)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Thumbnail :
      data['thumbnail'] = temp_data;

      //  Update Database :
      thumbnail.doc(doc_id).update(data);

      // Cached Image for loacal use :
      await StoreCacheData(fromModel: 'BusinessThumbnail', data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      print(e);
      return ResponseBack(response_type: false);
    }
  }

  UpdateBusinessDetail() async {
    var data;
    var name;
    var logo; 
    var doc_id;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessDetail');
      if (cacheData != false) {
        logo = cacheData['logo'];
        name = cacheData['name'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessDetail');
      var query = store
          .where(
            'email',
            isEqualTo: await getuserEmail,
          )
          .where('user_id', isEqualTo: await getUserId)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Logo:
      data['logo'] = logo;
      data['name'] = name;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessDetail', data: data);

      return ResponseBack(response_type: true);
    } catch (e) {
      print(e);
      return ResponseBack(response_type: false);
    }
  }
}
