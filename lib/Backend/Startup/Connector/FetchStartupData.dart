import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
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
        print('Cached $fromModel Successfully');
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'Fetch Thumbnail from Cached Store');
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
      await  StoreCacheData(fromModel: 'BusinessThumbnail', data: data);

      return ResponseBack(
          response_type: true,
          data: data,
          message: 'Thumbnail Fetch from Firebase');
    } catch (e) {
      return ResponseBack(
          response_type: false, data: shimmer_image, message: e);
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
        return ResponseBack(
            response_type: true,
            data: cacheData,
            message: 'Business Detail Fetch from Cached Storage');
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
      await StoreCacheData(fromModel: 'BusinessDetail', data: data);
      print('Business Detail Store to Cached Storage');

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


  ///////////////////////////////////
  /// FETCH STARTUP VISION : 
  ///////////////////////////////////
  FetchBusinessVision() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessVision');
      if (cacheData != false) {
        return ResponseBack(
          response_type: true,
          data: cacheData,
          message: 'Vision Fetch from Cached Store'  );
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
      await StoreCacheData(fromModel: 'BusinessVision', data: data);
        return ResponseBack(
          response_type: true,
          data: data,
          message: 'Vision Fetch from Firestore DB'  );
    } catch (e) {
        return ResponseBack(
          response_type: false,
          message: e  );
    }
  }

  ///////////////////////////////////
  /// FETCH STARTUP VISION : 
  ///////////////////////////////////
  FetchBusinessWhy() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessWhyInvest');
      if (cacheData != false) {
        return ResponseBack(
          response_type: true,
          data: cacheData,
          message: 'BusinessWhyInvest Fetch from Cached Store'  );
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
      });

      // CACHE BUSINESS DETAIL :
      await  StoreCacheData(fromModel: 'BusinessWhyInvest', data: data);
        return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessWhyInvest Fetch from Firestore DB'  );
    } catch (e) {
        return ResponseBack(
          response_type: false,
          message: e  );
    }
  }
  ///////////////////////////////////
  /// FETCH STARTUP VISION : 
  ///////////////////////////////////
  FetchBusinessCatigory() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessCatigory');
      if (cacheData != false) {
        return ResponseBack(
          response_type: true,
          data: cacheData,
          message: 'BusinessCatigory Fetch from Cached Store'  );
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('BusinessCatigory');
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
      await  StoreCacheData(fromModel: 'BusinessCatigory', data: data);
        return ResponseBack(
          response_type: true,
          data: data,
          message: 'BusinessCatigory Fetch from Firestore DB'  );
    } catch (e) {
        return ResponseBack(
          response_type: false,
          message: e  );
    }
  }



  FetchBusinessMilestone() async {
    var data;

    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessMilestones');
      if (cacheData != false) {
        return ResponseBack(
        response_type: true,
        data: cacheData,
        message: 'BusinessMilestones Fetch from Cached DB');

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
      await StoreCacheData(fromModel: 'BusinessMilestones', data: data);
      return ResponseBack(
        response_type: true,
        data: data,
        message: 'BusinessMilestones Fetch from Firestore DB'  );

    } catch (e) {
      return ResponseBack(
        response_type: false,
        data: [],
        message: e );

    }
  }

  //////////////////////////////////
  /// Fetch Product : 
  //////////////////////////////////
  FetchProducts() async {
    var data;
    var product_list = [];
    var only_product = [];
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final cacheData = await GetCachedData('BusinessProducts');
      if (cacheData != false && cacheData != null) {
        // filter product : 
        product_list = cacheData['products'];
        product_list.forEach((element) {
          if (element['type'] == 'product') {
            only_product.add(element);
          }
        });
        return ResponseBack(
          response_type: true,
          data:only_product,
          message: 'BusinessProducts Fetch from Cached DB'  );
      }

      // FETCHING PRODUCT AND SERVICE FROM FIREBASE DB:
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

      return ResponseBack(
        response_type: true, 
        data:only_product, 
        message: 'BusinessProducts Fetch from Firebase  DB');

    } catch (e) {
      return ResponseBack(
        response_type: false, 
        data:[], 
        message: e);
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
        service_list = cacheData['products'];
        service_list.forEach((element) {
          if (element['type'] == 'service') {
            only_services.add(element);
          }
        });
        return ResponseBack(
        response_type: true, 
        data:only_services, 
        message: 'BusinessProducts Fetch Services from Cached  DB');

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

        return ResponseBack(
        response_type: true, 
        data:only_services, 
        message: 'BusinessProducts Fetch Services from Firstore  DB');
    } catch (e) {
        return ResponseBack(
        response_type: false, 
        data:[], 
        message: e);
    }
  }
}
