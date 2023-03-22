import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessMileStoneStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessWhyInvestStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinesssPitchStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/ThumbnailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StartupUpdater extends GetxController {
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');

/////////////////////////////////////////
  /// Update Vision :
  /// It fetches data from cache storage, fetches data
  /// from firebase, updates the data in firebase and
  /// then updates the cache storage
  /// Returns:
  ///   ResponseBack(response_type: false, message: e);
/////////////////////////////////////////
  UpdatehBusinessVision({required user_id, required vision}) async {
    var visionStore = Get.put(BusinessVisionStore(), tag: 'vision_store');
    var data;
    var doc_id;
    var final_startup_id;
    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessVisiontStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['vision'] = vision;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessVisiontStoreName, data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

  /// It takes a startup_id as a parameter, and if it's not empty, it will use that startup_id to query
  /// the database. If it is empty, it will use an empty string
  ///
  /// Args:
  ///   startup_id: The id of the startup. Defaults to false
  ///
  /// Returns:
  ///   A Future<ResponseBack>
  UpdatehBusinessPitch(
      {required user_id,
      required pitch,
      required path,
      required previousPath}) async {
    var data;
    var pitch;
    var doc_id;

    if (path == '' || path == null) {
      path = previousPath;
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessPitchtStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['pitch'] = pitch;
      data['path'] = path;
      store.doc(doc_id).update(data);

      final deleteResp = await DeleteFileFromStorage(previousPath);
      print(deleteResp);
      
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

/////////////////////////////////////////
  /// Update Why :
/////////////////////////////////////////
  UpdatehBusinessWhy({required user_id, required why_text}) async {
    var whyInvestStore =
        Get.put(BusinessWhyInvestStore(), tag: 'whyinvest_store');

    var data;
    var doc_id;
    var final_startup_id;

    try {
      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessWhyInvesttStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['why_text'] = why_text;
      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

  ///////////////////////////////////////
  /// Milestone Update :
  ///////////////////////////////////////
  UpdateBusinessMilestone({required user_id, required mile}) async {
    var data;
    var doc_id;
    try {
      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessMilestoneStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Data in FireStore :
      data['milestone'] = mile;
      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

  ///////////////////////////////////////////
  /// UPDATE PRODUCTS :
  ///////////////////////////////////////////
  UpdateProducts({required user_id, required products}) async {
    var data;
    var doc_id;
    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['products'] = products;
      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

  // FetchServices({startup_id = false}) async {
  //   var data;
  //   var product_list = [];
  //   var only_product = [];
  //   var temp_service = [];
  //   var doc_id;
  //   var final_startup_id;

  //   // Filter Startup Id :
  //   if (startup_id != '' || startup_id != false) {
  //     final_startup_id = startup_id;
  //   } else {
  //     final_startup_id = '';
  //   }

  //   try {
  //     // FETCHING DATA FROM CACHE STORAGE :
  //     final cacheData = await GetCachedData(
  //         fromModel: getBusinessProductStoreName, startup_id: final_startup_id);
  //     if (cacheData != false && cacheData != null) {
  //       temp_service = cacheData['service'];
  //     }

  //     // FETCHING DATA FROM FIREBASE
  //     var store =
  //         FirebaseFirestore.instance.collection(getBusinessProductStoreName);
  //     var query = store.where('startup_id', isEqualTo: final_startup_id).get();

  //     await query.then((value) {
  //       data = value.docs.first.data() as Map<String, dynamic>;
  //       doc_id = value.docs.first.id;
  //     });

  //     // Update Product :
  //     data['products'] = temp_service;

  //     // Uppdate product in firestore :
  //     store.doc(doc_id).update(data);

  //     // CACHE BUSINESS DETAIL :
  //     await StoreCacheData(fromModel: getBusinessProductStoreName, data: data);

  //     return ResponseBack(response_type: true);
  //   } catch (e) {
  //     return ResponseBack(response_type: false, message: update_error_title);
  //   }
  // }

  //////////////////////////////////
  /// UPDATE TEAM MEMEBER :
  //////////////////////////////////
  UpdateBusinessTeamMember({required user_id}) async {
    var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
    var data;
    var doc_id;
    var temp_mem;

    try {
      temp_mem = await memeberStore.GetTeamMembers();
      print(temp_mem);
      var store =
          FirebaseFirestore.instance.collection(getBusinessTeamMemberStoreName);
      var query = store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        data = value.docs.first.data();
        doc_id = value.docs.first.id;
      });

      data['members'] = temp_mem;
      store.doc(doc_id).update(data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

////////////////////////////////////////////////////////////////
  /// It fetches data from cache storage,
  /// updates it and then stores it back to cache storage
  /// Returns:
  ///  A ResponseBack object.
////////////////////////////////////////////////////////////////
  UpdateBusinessCatigory({startup_id = false}) async {
    var data;
    var doc_id;
    var temp_catigory;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = '';
    }

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessCatigoryStoreName,
          startup_id: final_startup_id);

      if (cacheData != false) {
        temp_catigory = cacheData['catigories'];
      }

      // UPDATE DATA TO FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessCatigoryStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['catigories'] = temp_catigory;
      store.doc(doc_id).update(data);
      // CACHE BUSINESS CATIGORIES :
      await StoreCacheData(fromModel: getBusinessCatigoryStoreName, data: data);
      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }
}
