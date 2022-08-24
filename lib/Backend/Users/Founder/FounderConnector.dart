import 'dart:convert';
import 'dart:developer';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = Uuid();

class FounderConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  ////////////////////////////////////////
  // CUSTOM CACHING  SYSTEM :
  // GET DATA FROM LOCAL STORGE
  ////////////////////////////////////////
  GetCachedData({fromModel, user_id}) async {
    final localStore = await SharedPreferences.getInstance();
    var is_localy_store = localStore.containsKey(fromModel);

    if (is_localy_store) {
      var data = localStore.getString(fromModel);

      // Validata data :
      if (data != null || data != '') {
        var final_data = json.decode(data!);
        Map<String, dynamic> cacheData = final_data as Map<String, dynamic>;
        if (cacheData['user_id'] == user_id) {
          return final_data;
        } else {
          return false;
        }
      } else {
        return false;
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

////////////////////////////////////
  // Create Founder Detail :
////////////////////////////////////
  CreateFounderDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessFounderDetailStoreName);

      // fetch catigories for local storage :
      // kye : FounderUserDetail
      bool is_data = localStore.containsKey(getBusinessFounderDetailStoreName);

      // Validate key :
      if (is_data) {
        String? temp_data =
            localStore.getString(getBusinessFounderDetailStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(response_type: true);
      } else {
        return ResponseBack(response_type: false);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

//////////////////////////////////////
  // Create Founder Contact :
//////////////////////////////////////
  CreateFounderContact() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessFounderContactStoreName);

      // fetch catigories for local storage :
      // kye : FounderUserContact

      bool is_data = localStore.containsKey(getBusinessFounderContactStoreName);
      if (is_data) {
        String? temp_data =
            localStore.getString(getBusinessFounderContactStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(response_type: true);
      } else {
        return ResponseBack(
          response_type: false,
        );
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

/////////////////////////////////////////////
  /// GET FOUNDER DETAIL :
/////////////////////////////////////////////
  FetchFounderDetailandContact({user_id = false}) async {
    var data_userContact;
    var data_userDetail;
    var doc_id_userDetail;
    var doc_id_userContact;
    var temp_userDetail;
    var temp_userContact;
    var final_user_id;

    if (user_id != '' || user_id != false) {
      final_user_id = user_id;
    } else {
      final_user_id = '';
    }

    try {
      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance
          .collection(getBusinessFounderDetailStoreName);
      var store1 = FirebaseFirestore.instance
          .collection(getBusinessFounderContactStoreName);

      // Get User Detial Document :
      var query = store.where('user_id', isEqualTo: final_user_id).get();
      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      // Get User  Conctact Document:
      var query1 = store1.where('user_id', isEqualTo: final_user_id).get();
      await query1.then((value) {
        data_userContact = value.docs.first.data();
        doc_id_userContact = value.docs.first.id;
      });

      return ResponseBack(
          response_type: true,
          message: 'Fetch Founder Detail from Firebase storage',
          data: {
            'userDetail': data_userDetail,
            'userContect': data_userContact
          });
    } catch (e) {
      return ResponseBack(
          response_type: false,
          message: fetch_data_error_title,
          data: shimmer_image);
    }
  }

////////////////////////////////////////////////////
  /// UPDATIN USER DETAIL AND CONTACT BOTH:
  /// I'm fetching data from firebase and storing it in a
  /// variable, then I'm fetching data from cache
  /// storage and storing it in a variable, then
  /// I'm updating the data in firebase with the data from
  /// cache storage
////////////////////////////////////////////////////
  UpdateFounderDetail({user_id = false}) async {
    var founderStore = Get.put(BusinessFounderStore());
  
    var data_userContact;
    var data_userDetail;

    var doc_id_userDetail;
    var doc_id_userContact;
    
    var final_user_id;
    var data;

    var picture = '';
    var name = '';
    var position = '';
    var phone_no = '';
    var primary_mail = '';
    var other_contact = '';

    if (user_id != '' || user_id != false) {
      final_user_id = user_id;
    } else {
      final_user_id = '';
    }

    try {
      data = await founderStore.GetFounderParam();
      picture = await founderStore.GetFounderPicture();

      name = data['name'];
      // position = data['position'];
      phone_no = data['phone_no'];
      primary_mail = data['primary_mail'];
      other_contact = data['other_contact'];

      // print(name);
      // print(position);
      // print(phone_no);
      // print(primary_mail);
      // print(other_contact);
      // print(picture);

      // FETCHING DATA FROM FIREBASE
      var detailStore = FirebaseFirestore.instance
          .collection(getBusinessFounderDetailStoreName);

      var contactStore = FirebaseFirestore.instance
          .collection(getBusinessFounderContactStoreName);

      // Get User Detial Document :
      var query = detailStore.where('user_id', isEqualTo: final_user_id).get();
      await query.then((value) {
        data_userDetail = value.docs.first.data();
        doc_id_userDetail = value.docs.first.id;
      });

      // Get User  Conctact Document:
      var query1 = contactStore.where('user_id', isEqualTo: final_user_id).get();
      await query1.then((value) {
        data_userContact = value.docs.first.data();
        doc_id_userContact = value.docs.first.id;
      });

      // print('user detail id ${doc_id_userDetail}');
      // print('user Contact id ${doc_id_userContact}');

      // print('user Detail Before ${data_userDetail}');
      // print('user Contact Befor ${data_userContact}');

      // Update Detail fields;
      data_userDetail['name'] = name;
      // data_userDetail['position'] = position;
      data_userDetail['picture'] = picture;

      // Update Contact field:
      data_userContact['primary_mail'] = primary_mail;
      data_userContact['phone_no'] = phone_no;
      data_userContact['other_contact'] = other_contact;

      // print('user Detail Before ${data_userDetail}');
      // print('user Dontact Befor ${data_userContact}');

      // Update Data in DB :
      contactStore.doc(doc_id_userContact).update(data_userContact);
      detailStore.doc(doc_id_userDetail).update(data_userDetail);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(
          response_type: false,
          message: update_error_title,
          data: shimmer_image);
    }
  }
}
