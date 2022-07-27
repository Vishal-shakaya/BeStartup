import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StartupUpdater extends GetxController {
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
////////////////////////////////////////////////
// UPDATE THUMBNAIL :
// 1. Get Thum from local storage:
// 2. Get startup instance to update :
// 3. Create new instance  with updated thnbnail :
// 4. Update Firestore and localStorage :
////////////////////////////////////////////////
  UpdateThumbnail({startup_id = false}) async {
    var temp_data;
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }

    try {
      /// Fetch thumbnail from localStorage :
      final cacheData = await GetCachedData(
      fromModel: getBusinessThumbnailStoreName,
      startup_id: final_startup_id);
      if (cacheData != false) {
        temp_data = cacheData['thumbnail'];
      }

      // FETCHING DOCUMENT FROM FIREBASE:
      var data;
      var thumbnail =
          FirebaseFirestore.instance.collection(getBusinessThumbnailStoreName);
      var query = thumbnail
          .where('user_id', isEqualTo: final_startup_id)
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
      await StoreCacheData(fromModel: getBusinessThumbnailStoreName, data: data);

      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }



//////////////////////////////////////////////
  /// Update Business  :
  /// 1 logo and Name :
  /// Update Firestore :
  /// Then Cached Data :
//////////////////////////////////////////////
  UpdateBusinessDetail({startup_id = false}) async {
    var data;
    var name;
    var logo;
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
      if (startup_id != '' || startup_id != false) {
        final_startup_id = startup_id;
      } else {
        final_startup_id = await getStartupId;
      }
    
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessDetailStoreName, startup_id: final_startup_id);
      if (cacheData != false) {
        logo = cacheData['logo'];
        name = cacheData['name'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
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
      await StoreCacheData(fromModel: getBusinessDetailStoreName, data: data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }



/////////////////////////////////////////
/// Update Vision :
/// It fetches data from cache storage, fetches data 
/// from firebase, updates the data in firebase and
/// then updates the cache storage
/// Returns:
///   ResponseBack(response_type: false, message: e);
/////////////////////////////////////////
  UpdatehBusinessVision({startup_id = false}) async {
    var data;
    var vision;
    var doc_id;

    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
        final_startup_id = startup_id;
      } else {
        final_startup_id = await getStartupId;
      }

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessVisiontStoreName, startup_id: final_startup_id);

      if (cacheData != false) {
        vision = cacheData['vision'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessVisiontStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

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



/////////////////////////////////////////
  /// Update Why :
/////////////////////////////////////////
  UpdatehBusinessWhy({startup_id = false}) async {
    var data;
    var why_text;
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
      } else {
        final_startup_id = await getStartupId;
      }

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessWhyInvesttStoreName,
          startup_id: final_startup_id);

      if (cacheData != false) {
        why_text = cacheData['why_text'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessWhyInvesttStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      data['why_text'] = why_text;
      store.doc(doc_id).update(data);

      // Cached data
      await StoreCacheData(fromModel: getBusinessWhyInvesttStoreName, data: data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }




  ///////////////////////////////////////
  /// Milestone Update :
  ///////////////////////////////////////
  UpdateBusinessMilestone({startup_id = false}) async {
    var data;
    var temp_miles;
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
      } else {
        final_startup_id = await getStartupId;
      }

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
      fromModel: getBusinessMilestoneStoreName,
      startup_id: final_startup_id);
      if (cacheData != false) {
        temp_miles = cacheData['milestone'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessMilestoneStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Data in FireStore :
      data['milestone'] = temp_miles;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      StoreCacheData(fromModel: getBusinessMilestoneStoreName, data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }




  ///////////////////////////////////////////
  /// UPDATE PRODUCTS :
  ///////////////////////////////////////////
  UpdateProducts({startup_id = false}) async {
    var data;
    var product_list = [];
    var only_product = [];
    var temp_products = [];
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }


    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessProductStoreName, startup_id: final_startup_id);

      if (cacheData != false && cacheData != null) {
        temp_products = cacheData['products'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Product :
      data['products'] = temp_products;

      // Uppdate product in firestore :
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessProductStoreName, data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }




  FetchServices({startup_id = false}) async {
    var data;
    var product_list = [];
    var only_product = [];
    var temp_service = [];
    var doc_id;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }


    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessProductStoreName, startup_id: final_startup_id);
      if (cacheData != false && cacheData != null) {
        temp_service = cacheData['service'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        doc_id = value.docs.first.id;
      });

      // Update Product :
      data['products'] = temp_service;

      // Uppdate product in firestore :
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessProductStoreName, data: data);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }


  //////////////////////////////////
  /// UPDATE TEAM MEMEBER :
  //////////////////////////////////
  UpdateBusinessTeamMember({startup_id = false}) async {
    var data;
    var doc_id;
    var temp_mem;
    var final_startup_id;
        // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }


    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessTeamMemberStoreName,
          startup_id: final_startup_id);

      if (cacheData != false) {
        temp_mem = cacheData['members'];
      }

      // UPDATE DATA TO FIREBASE
      var store = FirebaseFirestore.instance.collection(getBusinessTeamMemberStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

      await query.then((value) {
        data = value.docs.first.data();
        doc_id = value.docs.first.id;
      });

      data['members'] = temp_mem;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessTeamMemberStoreName, data: data);
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
      final_startup_id = await getStartupId;
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
      var store = FirebaseFirestore.instance.collection(getBusinessCatigoryStoreName);
      var query = store
          .where('user_id', isEqualTo: final_startup_id)
          .get();

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
