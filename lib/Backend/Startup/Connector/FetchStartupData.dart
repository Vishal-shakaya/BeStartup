import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StartupViewConnector extends GetxController {
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

  // 1. Retrive thumbnial using [ id , email , startup name ]
  // 2. Send it to ui
  // 3. Store data in local storage:
  FetchThumbnail() async {
    try {
      ////////////////////////////////////////////////////
      // Check if Thumbnail is cached then send it else
      // fetch form DB:
      ////////////////////////////////////////////////////
      final cacheData = await GetCachedData('BusinessThumbnail');
      if (cacheData != false) {
        return cacheData['thumbnail'];
      }

      // FETCHING DATA FROM FIREBASE:
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
      });

      // STORE DATA TO DB :
      await StoreCacheData(fromModel: 'BusinessThumbnail', data: data);

      return data['thumbnail'];
    } catch (e) {
      print(e);
      return shimmer_image;
    }
  }

  // 1. Retrive thumbnial using [ id , email , startup name ]
  // 2. Send it to ui
  // 3. Store data in local storage:
  FetchBusinessDetail() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessDetail');
      if (cacheData != false) {
        return cacheData['logo'];
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
      });

      // CACHE BUSINESS DETAIL :
      StoreCacheData(fromModel: 'BusinessDetail', data: data);
      return data['logo'];
    } catch (e) {
      print(e);
      return shimmer_image;
    }
  }


  FetchBusinessTeamMember() async {
    var data;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessTeamMember');
      if (cacheData != false) {
        return cacheData['members'];
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
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessTeamMember', data: data);
      return data['members'];
    } catch (e) {
      print(e);
      return [];
    }
  }



  FetchBusinessVision() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessVision');
      if (cacheData != false) {
        return cacheData['vision'];
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
      });

      // CACHE BUSINESS DETAIL :
      StoreCacheData(fromModel: 'BusinessVision', data: data);
      return data['vision'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  FetchBusinessMilestone() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessMilestones');
      if (cacheData != false) {
        return cacheData['milestone'];
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
      });

      // CACHE BUSINESS DETAIL :
      StoreCacheData(fromModel: 'BusinessMilestones', data: data);
      return data['milestone'];
    } catch (e) {
      print(e);
      return false;
    }
  }



  FetchProducts() async {
    var data;
    var product_list = [];
    var only_product = [];
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessProducts');
      if (cacheData != false && cacheData != null) {
        print('***************** Product Local Storage ******************');

        product_list = cacheData['products'];
        product_list.forEach((element) {
          if (element['type'] == 'product') {
            only_product.add(element);
          }
        });
        return only_product;
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
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessProducts', data: data);

      // FILETER PRODUCT
      product_list = data['products'];
      product_list.forEach((element) {
        if (element['type'] == 'product') {
          only_product.add(element);
        }
      });

      return only_product;
    } catch (e) {
      print(e);
      return false;
    }
  }

  FetchServices() async {
    var data;
    var service_list = [];
    var only_services = [];
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessProducts');
      if (cacheData != false && cacheData != null) {
        print('********** Fetch Services **************');

        service_list = cacheData['products'];
        service_list.forEach((element) {
          if (element['type'] == 'service') {
            only_services.add(element);
          }
        });
        return only_services;
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
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessProducts', data: data);

      // FILETER PRODUCT
      service_list = data['products'];
      service_list.forEach((element) {
        if (element['type'] == 'service') {
          print(element);
          only_services.add(element);
        }
      });

      return only_services;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
