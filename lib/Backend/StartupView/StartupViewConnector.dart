import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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
        if (cacheData['email'] == getuserEmail &&
            cacheData['user_id'] == getUserId) {
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
            isEqualTo: getuserEmail,
          )
          .where('user_id', isEqualTo: getUserId)
          .where('startup_name', isEqualTo: getStartupName)
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
            isEqualTo: getuserEmail,
          )
          .where('user_id', isEqualTo: getUserId)
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
            isEqualTo: getuserEmail,
          )
          .where('user_id', isEqualTo: getUserId)
          .where('startup_name', isEqualTo: getStartupName)
          .get();

      await query.then((value) {
        data = value.docs.first.data();
      });

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'BusinessTeamMember', data: data);
      return data['members'];
    } catch (e) {
      print(e);
      return shimmer_image;
    }
  }
}
