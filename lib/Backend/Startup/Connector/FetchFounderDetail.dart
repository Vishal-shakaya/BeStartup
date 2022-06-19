import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = Uuid();

class UserConnector extends GetxController {
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

  FetchUserDetailandContact() async {
    print('********* START FETCHING USER DATA DETAIL AND CONTACT *********');
    
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
        Map<String, dynamic> temp_founder = {
          'picture': userDetailCach['picture'],
          'name': userDetailCach['name'],
          'position': userDetailCach['position'],
          'phone_no': userContactCach['phone_no'],
          'primary_mail': userContactCach['primary_mail'],
          'other_contact': userContactCach['other_contact'],
        };
        print('***** Fetch Local User Detail $temp_founder');
        return temp_founder;
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
          // .where('startup_name', isEqualTo: await getStartupName)
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
          // .where('startup_name', isEqualTo: await getStartupName)
          .get();

      await query.then((value) {
        data_userContact = value.docs.first.data();
        doc_id_userContact = value.docs.first.id;
      });

      Map<String, dynamic> temp_founder = {
        'picture': data_userDetail['picture'],
        'name': data_userDetail['name'],
        'position': data_userDetail['position'],
        'phone_no': data_userContact['phone_no'],
        'primary_mail': data_userContact['primary_mail'],
        'other_contact': data_userContact['other_contact'],
      };

      
      print('***** Fetch Firebase User Detail $temp_founder');
      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'UserDetail', data: data_userDetail);
      await StoreCacheData(fromModel: 'UserContact', data: data_userContact);

      return temp_founder;
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
