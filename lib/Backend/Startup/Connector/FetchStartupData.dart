import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
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
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    try {
      // FETCHING DATA FROM FIREBASE:
      var data;
      var thumbnail =
          FirebaseFirestore.instance.collection(getBusinessThumbnailStoreName);

      var query =
          thumbnail.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessVisiontStoreName);

      final name = await startupState.GetStartupName();
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Vision Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  ///////////////////////////////////
  /// FETCH STARTUP Pitch :
  ///////////////////////////////////
  FetchBusinessPitch({startup_id = false}) async {
    var data;
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessPitchtStoreName);

      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Pitch Fetch from Firestore DB');
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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessWhyInvesttStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessCatigoryStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessMilestoneStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    var data;
    var product_list = [];
    var only_product = [];
    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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


////////////////////////////////////////////
/// Fetch All Product and services for
///  Update View : 
////////////////////////////////////////////
  FetchProductsAndServices({startup_id = false}) async {
    var final_startup_id;

    // Filter Startup Id :
    if (startup_id != '' || startup_id != false) {
      final_startup_id = startup_id;
    } else {
      final_startup_id = '';
    }

    var data;
    var product_list = [];
    var only_product = [];
    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });


      return ResponseBack(
          response_type: true,
          data: data['products'],
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
      final_startup_id = '';
    }

    try {
      var store =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
      });

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
      final_startup_id = '';
    }

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      // final cacheData = await GetCachedData(
      //     fromModel: getBusinessTeamMemberStoreName,
      //     startup_id: final_startup_id);
      // if (cacheData != false) {
      //   return ResponseBack(
      //       response_type: true,
      //       data: cacheData,
      //       message: 'BusinessTeamMember  Fetch from Cache DB');
      // }

      // FETCHING DATA FROM FIREBASE
      var store =
          FirebaseFirestore.instance.collection(getBusinessTeamMemberStoreName);
      var query = store.where('startup_id', isEqualTo: final_startup_id).get();

      await query.then((value) {
        data = value.docs.first.data();
      });

      // CACHE BUSINESS DETAIL :
      // await StoreCacheData(
      //     fromModel: getBusinessTeamMemberStoreName, data: data);

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessTeamMember Fetch from Firestore DB');
    } catch (e) {
      return ResponseBack(response_type: false, data: data, message: e);
    }
  }

/////////////////////////////////////////////////////////////
  /// I'm trying to add a new startup_id to the
  /// startup_ids array in the document
  /// Args:
  ///   startup_id: The id of the startup you want to like
  ///   user_id: The user id of the user who liked the startup
///////////////////////////////////////////////////////////////
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

        if (save_post_len > 0) {
          startup_list = value.docs.first.data()['startup_ids'];

          data = value.docs.first.data();

          doc_id = value.docs.first.id;
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

        return ResponseBack(
            response_type: true, message: 'First Startup Add to List ');
      }

      if (save_post_len > 0) {
        startup_list.add(startup_id);

        data['startup_ids'] = startup_list;

        await myStore.doc(doc_id).update(data);

        return ResponseBack(response_type: true, message: 'Startup Saved');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

//////////////////////////////////////////////////////////////
  /// It checks if the user has saved any startup before,
  /// if yes, it removes the startup_id from the list
  /// of saved startups and updates the document
  ///
  /// Args:
  ///   startup_id: The id of the startup you want to like
  ///   user_id: The user's ID
  ///
  /// Returns:
  ///   A Future<ResponseBack>
//////////////////////////////////////////////////////////////
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

        if (save_post_len > 0) {
          startup_list = value.docs.first.data()['startup_ids'];

          data = value.docs.first.data();

          doc_id = value.docs.first.id;
        }
      });

      // Validate :
      if (save_post_len <= 0) {
        return ResponseBack(response_type: false);
      }

      if (save_post_len > 0) {
        startup_list.remove(startup_id);

        data['startup_ids'] = startup_list;

        await myStore.doc(doc_id).update(data);

        return ResponseBack(response_type: true, message: 'Startup UnSaved');
      }
    } catch (e) {
      ResponseBack(response_type: false, message: e);
    }
  }

////////////////////////////////////////////////////////
  /// It checks if a startup is liked by a user or not
  /// Args:
  ///   startup_id: The id of the startup that the user wants to like.
  ///   user_id: The user id of the user who liked the post
////////////////////////////////////////////////////////
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

        if (save_post_len > 0) {
          startup_list = value.docs.first.data()['startup_ids'];
        }
      });

      // Check if post already Saved :
      if (startup_list.contains(startup_id)) {
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
