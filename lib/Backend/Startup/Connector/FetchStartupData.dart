import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = Uuid();

class StartupViewConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
//////////////////////////////////////
  // 2. Send it to ui
  // 3. Store data in local storage:
//////////////////////////////////////
  FetchBusinessDetail({startup_id = false}) async {
    var data;
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'Business Detail Fetch from Cached Storage');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessDetailStoreName, data: data);

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Business Detail Fetch from Database');
    } catch (e) {
      return ResponseBack(
        response_type: false,
        data: shimmer_image,
      );
    }
  }



/////////////////////////////////////////
/// FETCH THUMBNAIL :
/////////////////////////////////////////
  FetchThumbnail({startup_id = false}) async {
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }

    try {
      // Check if Thumbnail is cached then send it else
      // fetch form DB:
      final cacheData = await GetCachedData(
          fromModel: getBusinessThumbnailStoreName,
          startup_id: final_startup_id);
      if (cacheData != false) {
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'Fetch Thumbnail from Cached Store');
      }

      // FETCHING DATA FROM FIREBASE:
      var data;
      var thumbnail =
          FirebaseFirestore.instance.collection(getBusinessThumbnailStoreName);
      var query =
          thumbnail.where('startup_id', isEqualTo: final_startup_id).get();
      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // STORE DATA TO DB :
      await StoreCacheData(
          fromModel: getBusinessThumbnailStoreName, data: data);

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Thumbnail Fetch from Firebase');
    } catch (e) {
      return ResponseBack(
          response_type: false, data: shimmer_image, message: e);
    }
  }



  ///////////////////////////////////
  /// FETCH STARTUP VISION :
  ///////////////////////////////////
  FetchBusinessVision({startup_id = false}) async {
    var data;
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'Vision Fetch from Cached Store');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessVisiontStoreName);
      final name = await getStartupName;
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessVisiontStoreName, data: data);
      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Vision Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


///////////////////////////////////////////
  /// FETCH STARTUP VISION :
////////////////////////////////////////////
  FetchBusinessWhy({startup_id = false}) async {
    var data;
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'BusinessWhyInvest Fetch from Cached Store');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessWhyInvesttStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(
          fromModel: getBusinessWhyInvesttStoreName, data: data);
      return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessWhyInvest Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  ///////////////////////////////////
  /// FETCH STARTUP VISION :
  ///////////////////////////////////
  FetchBusinessCatigory({startup_id = false}) async {
    var data;
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'BusinessCatigory Fetch from Cached Store');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessCatigoryStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessCatigoryStoreName, data: data);
      return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessCatigory Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  ////////////////////////////////////
  /// FETCH MILESTONE :
  ////////////////////////////////////
  FetchBusinessMilestone({startup_id = false}) async {
    var data;
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'BusinessMilestones Fetch from Cached DB');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessMilestoneStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(
          fromModel: getBusinessMilestoneStoreName, data: data);
      return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessMilestones Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, data: [], message: e);
    }
  }

  //////////////////////////////////
  /// Fetch Product :
  //////////////////////////////////
  FetchProducts({startup_id = false}) async {
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = await getStartupId;
    }

    var data;
    var product_list = [];
    var only_product = [];
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData(
          fromModel: getBusinessProductStoreName, startup_id: final_startup_id);

      if (cacheData != false) {
        // filter product :
        product_list = cacheData['products'];
        product_list.forEach((element) {
          if (element['type'] == 'product') {
            only_product.add(element);
          }
        });
        return ResponseBack(
            response_type: true,
            data: only_product,
            message: 'BusinessProducts Fetch from Cached DB');
      }

      // FETCHING PRODUCT AND SERVICE FROM FIREBASE DB:
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();
      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessProductStoreName, data: data);

      // FILETER PRODUCT
      product_list = data['products'];
      product_list.forEach((element) {
        if (element['type'] == 'product') {
          only_product.add(element);
        }
      });

      return ResponseBack(
          response_type: true,
          data: only_product,
          message: 'BusinessProducts Fetch from Firebase  DB');
    } catch (e) {
      return ResponseBack(response_type: false, data: [], message: e);
    }
  }

///////////////////////////////////////////////////
  /// It fetches data from firestore
  /// and stores it in cache storage
/////////////////////////////////////////////////////
  FetchServices({startup_id = false}) async {
    var final_startup_id;
    var data;
    var service_list = [];
    var only_services = [];

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

      if (cacheData != false) {
        service_list = cacheData['products'];
        service_list.forEach((element) {
          if (element['type'] == 'service') {
            only_services.add(element);
          }
        });
        return ResponseBack(
            response_type: true,
            data: only_services,
            message: 'BusinessProducts Fetch Services from Cached  DB');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: getBusinessProductStoreName, data: data);

      // FILETER PRODUCT
      service_list = data['products'];
      service_list.forEach((element) {
        if (element['type'] == 'service') {
          only_services.add(element);
        }
      });

      return ResponseBack(
          response_type: true,
          data: only_services,
          message: 'BusinessProducts Fetch Services from Firstore  DB');
    } catch (e) {
      return ResponseBack(response_type: false, data: [], message: e);
    }
  }

  ///////////////////////////////////
  // Fetch Team Member :
  ///////////////////////////////////
  FetchBusinessTeamMember({startup_id = false}) async {
    var final_startup_id;
    var data;

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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'BusinessTeamMember  Fetch from Cache DB');
      }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessTeamMemberStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data();
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(
          fromModel: getBusinessTeamMemberStoreName, data: data);
      return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessTeamMember Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, data: data, message: e);
    }
  }



     LikeStartup({startup_id, user_id}) async {
    final localStore = await SharedPreferences.getInstance();
    var doc_id;
    var data;
    var save_post_len;
    var startup_list = [];
    try {
      final myStore = store.collection(getLikeStartupStoreName);
      // Check if saveStartup model exist or not :
      // doc size 0 then no created :
      var query = myStore.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        save_post_len = value.size;
        // print('size $save_post_len');
        if (save_post_len > 0) {
          // print(' 1. Save Post Process Start');
          startup_list = value.docs.first.data()['startup_ids'];
          // print(' 2. Get startup list $startup_list');
          data = value.docs.first.data();
          // print(' 3. Data $data');
          doc_id = value.docs.first.id;
          // print(' 4. Document ID  $doc_id');
        }
      });

      // Check if post already Saved :
      if (startup_list.contains(startup_id)) {
        return ResponseBack(
            response_type: false, message: 'Startup Already Liked', code: 101);
      }

      // Add new Save Story Doc :
      if (save_post_len <= 0) {
        startup_list.add(startup_id);
        var save_startup = await LikeStartupsModel(
          user_id: user_id,
          startup_ids: startup_list,
        );
        await myStore.add(save_startup);
        // print('5. Add First Startup $startup_list ');
        return ResponseBack(
            response_type: true, message: 'First Startup Add to List ');
      }

      if (save_post_len > 0) {
        // print("5. Update Startup List with new list ");
        startup_list.add(startup_id);
        data['startup_ids'] = startup_list;
        await myStore.doc(doc_id).update(data);
        // print('6. Update Startup List');
        return ResponseBack(response_type: true, message: 'Startup Saved');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }



  UnLikeStartup({startup_id, user_id}) async {
    final localStore = await SharedPreferences.getInstance();
    var doc_id;
    var data;
    var save_post_len;
    var startup_list = [];
    try {
      final myStore = store.collection(getLikeStartupStoreName);
      var query = myStore.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        save_post_len = value.size;
        // print('size $save_post_len');
        if (save_post_len > 0) {
          // print(' 1. UnSave Post Process Start');
          startup_list = value.docs.first.data()['startup_ids'];
          // print(' 2. Get startup list $startup_list');
          data = value.docs.first.data();
          // print(' 3. Data $data');
          doc_id = value.docs.first.id;
          // print(' 4. Document ID  $doc_id');
        }
      });

      // Validate :
      if (save_post_len <= 0) {
        return ResponseBack(response_type: false);
      }

      if (save_post_len > 0) {
        // print("5. Update Startup List with new list ");
        startup_list.remove(startup_id);
        data['startup_ids'] = startup_list;
        await myStore.doc(doc_id).update(data);
        // print('6. Unsave Update Startup List');
        return ResponseBack(response_type: true, message: 'Startup UnSaved');
      }
    } catch (e) {
      ResponseBack(response_type: false, message: e);
    }
  }



  IsStartupLiked({startup_id, user_id}) async {
    var save_post_len;
    var startup_list = [];

    try {
      final myStore = store.collection(getLikeStartupStoreName);
      // Check if saveStartup model exist or not :
      // doc size 0 then no created :
      var query = myStore.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        save_post_len = value.size;
        // print('size $save_post_len');
        if (save_post_len > 0) {
          // print(' Check if startup save or not');
          startup_list = value.docs.first.data()['startup_ids'];
        }
      });

      // Check if post already Saved :
      if (startup_list.contains(startup_id)) {
        // print('Startup Already Saved');
        return ResponseBack(
            response_type: true, message: 'Startup Already Liked', code: 101);
      } else {
        return ResponseBack(response_type: true, code: 111);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
