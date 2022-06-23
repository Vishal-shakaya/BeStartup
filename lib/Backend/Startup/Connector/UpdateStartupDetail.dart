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
      
      return ResponseBack(response_type: true, );
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

//////////////////////////////////////////////
  /// Update Business  :
  /// 1 logo and Name :
  /// Update Firestore :
  /// Then Cached Data :
//////////////////////////////////////////////
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

/////////////////////////////////////////
  /// Update Vision :
  ///
/////////////////////////////////////////
  UpdatehBusinessVision() async {
    var data;
    var why_text;
    var doc_id;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessVision');
      if (cacheData != false) {
        why_text = cacheData['why_text'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessVision');
      var query = store
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

      data['why_text'] = why_text;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessVision', data: data);

    } catch (e) {
      return ResponseBack(response_type: false,message: e);
    }
  }

/////////////////////////////////////////
  /// Update Why :
/////////////////////////////////////////
  UpdatehBusinessWhy() async {
    var data;
    var vision;
    var doc_id;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessWhyInvest');
      if (cacheData != false) {
        vision = cacheData['vision'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessWhyInvest');
      var query = store
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

      data['vision'] = vision;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessWhyInvest', data: data);
      return data['vision'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///////////////////////////////////////
  /// Milestone Update :
  ///////////////////////////////////////
  UpdateBusinessMilestone() async {
    var data;
    var temp_miles;
    var doc_id;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessMilestones');
      if (cacheData != false) {
        temp_miles = cacheData['milestone'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessMilestones');
      var query = store
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

      // Update Data in FireStore :
      data['milestone'] = temp_miles;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      StoreCacheData(fromModel: 'BusinessMilestones', data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  ///////////////////////////////////////////
  /// UPDATE PRODUCTS :
  ///////////////////////////////////////////
  UpdateProducts() async {
    var data;
    var product_list = [];
    var only_product = [];
    var temp_products = [];

    var doc_id;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessProducts');
      if (cacheData != false && cacheData != null) {
        temp_products = cacheData['products'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessProducts');
      var query = store
          .where('user_id', isEqualTo: await getUserId)
          // .where('startup_name', isEqualTo: await getStartupName)
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
      await StoreCacheData(fromModel: 'BusinessProducts', data: data);
    } catch (e) {
      print(e);
      return false;
    }
  }

  FetchServices() async {
    var data;
    var product_list = [];
    var only_product = [];
    var temp_service = [];

    var doc_id;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessProducts');
      if (cacheData != false && cacheData != null) {
        temp_service = cacheData['service'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessProducts');
      var query = store
          // .where(
          //   'email',
          //   isEqualTo: await getuserEmail,
          // )
          .where('user_id', isEqualTo: await getUserId)
          // .where('startup_name', isEqualTo: await getStartupName)
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
      await StoreCacheData(fromModel: 'BusinessProducts', data: data);

      return ResponseBack(response_type: true);
    } catch (e) {
      print(e);
      return ResponseBack(response_type: false);
    }
  }

  UpdateBusinessTeamMember() async {
    var data;
    var doc_id;
    var temp_mem;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessTeamMember');
      if (cacheData != false) {
        temp_mem = cacheData['members'];
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessTeamMember');
      var query = store
          .where(
            'email',
            isEqualTo: await getuserEmail,
          )
          .where('user_id', isEqualTo: await getUserId)
          .where('startup_name', isEqualTo: await getStartupName)
          .get();

      await query.then((value) {
        data = value.docs.first.data();
        doc_id = value.docs.first.id;
      });

      data['members'] = temp_mem;
      store.doc(doc_id).update(data);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessTeamMember', data: data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

////////////////////////////////////////////////////
/// UPDATIN USER DETAIL AND CONTACT BOTH:
////////////////////////////////////////////////////
  UpdateUserDetailandContact() async {
    var data_userContact;
    var data_userDetail;
    var doc_id_userDetail;
    var doc_id_userContact;
    var temp_userDetail;
    var temp_userContact;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final userDetailCach = await GetCachedData('UserDetail');
      final userContactCach = await GetCachedData('UserContact');
      if (userDetailCach != false || userContactCach != false) {
        temp_userContact = userContactCach;
        temp_userDetail = userContactCach;
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('UserDetail');

      var store1 = FirebaseFirestore.instance.collection('UserContact');

      // Get User Detial Document :
      var query = store
          .where(
            'email',
            isEqualTo: await getuserEmail,
          )
          .where('user_id', isEqualTo: await getUserId)
          .where('startup_name', isEqualTo: await getStartupName)
          .get();

      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      // Get User  Conctact Document:
      var query1 = store1
          .where(
            'email',
            isEqualTo: await getuserEmail,
          )
          .where('user_id', isEqualTo: await getUserId)
          .where('startup_name', isEqualTo: await getStartupName)
          .get();

      await query.then((value) {
        data_userContact = value.docs.first.data();
        doc_id_userContact = value.docs.first.id;
      });

      data_userDetail = temp_userDetail;
      data_userContact = temp_userContact;

      // Update Data in DB : 
      store.doc(doc_id_userDetail).update(data_userDetail);
      store.doc(doc_id_userContact).update(data_userContact);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'UserDetail', data: data_userDetail);
      await StoreCacheData(fromModel: 'UserContact', data: data_userContact);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
