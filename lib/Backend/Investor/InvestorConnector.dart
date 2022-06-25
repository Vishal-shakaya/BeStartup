import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestorConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

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



  FetchInvestorDetailandContact() async {
    var data_userContact;
    var data_userDetail;
    var doc_id_userDetail;
    var doc_id_userContact;
    var temp_userDetail;
    var temp_userContact;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final userDetailCach = await GetCachedData('InvestorUserDetail');
      final userContactCach = await GetCachedData('InvestorUserContact');
      if (userDetailCach != false || userContactCach != false) {
        return ResponseBack(
        response_type: true, 
        message: 'Fetch Investor Detail from cached storage',
        data: {
        'userDetail':userDetailCach,
        'userContect':userContactCach});
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('InvestorUserDetail');
      var store1 = FirebaseFirestore.instance.collection('InvestorUserContact');

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


      // CACHE BUSINESS DETAIL :
      await StoreCacheData(fromModel: 'InvestorUserDetail', data: data_userDetail);
      await StoreCacheData(fromModel: 'InvestorUserContact', data: data_userContact);

      return ResponseBack(
        response_type: true, 
        message: 'Fetch Investor Detail from Firebase storage',
        data: {
        'userDetail':data_userDetail,
        'userContect':data_userContact});

    } catch (e) {
      return ResponseBack(response_type: false, message: fetch_data_error_title);
    }
  }




  UpdateInvestorDetail() async {
    var data_userContact;
    var data_userDetail;
    var doc_id_userDetail;
    var doc_id_userContact;
    var temp_userDetail;
    var temp_userContact;
    try {
      // FETCHING DATA FROM CACHE STORAGE :
      final userDetailCach = await GetCachedData('InvestorUserDetail');
      final userContactCach = await GetCachedData('InvestorUserContact');
      if (userDetailCach != false || userContactCach != false) {
        temp_userDetail = userDetailCach;
        temp_userContact = userContactCach;        
      }

      // FETCHING DATA FROM FIREBASE
      var store = FirebaseFirestore.instance.collection('InvestorUserDetail');

      var store1 = FirebaseFirestore.instance.collection('InvestorUserContact');

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

      data_userDetail['name'] = temp_userDetail['name'];
      data_userDetail['position'] = temp_userDetail['position'];
      data_userDetail['name'] = temp_userDetail['picture'];

      data_userContact['email'] = temp_userContact['email'];
      data_userContact['phone_no'] = temp_userContact['phone_no'];
      data_userContact['other_contact'] = temp_userContact['other_contact'];

      // Update Data in DB :
      store.doc(doc_id_userDetail).update(data_userDetail);
      store.doc(doc_id_userContact).update(data_userContact);

      // CACHE BUSINESS DETAIL :
      await StoreCacheData(
          fromModel: 'InvestorUserDetail', data: data_userDetail);
      await StoreCacheData(
          fromModel: 'InvestorUserContact', data: data_userContact);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }




  CreateInvestorCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('InvestorChooseCatigory');

      // fetch catigories for local storage :
      // kye : InvestorChooseCatigory
      bool is_data = localStore.containsKey('InvestorChooseCatigory');
      // Validate key : 
      if(is_data){
        String? temp_data = localStore.getString('InvestorChooseCatigory');
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(response_type: true);
      }

      else{
        return ResponseBack(response_type: false);  
      }
      
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateInvestorDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('InvestorUserDetail');

      // fetch catigories for local storage :
      // kye : InvestorUserDetail
      
      bool is_data = localStore.containsKey('InvestorUserDetail');
      if (is_data) {
        String? temp_data = localStore.getString('InvestorUserDetail');
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


  CreateInvestorContact() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('InvestorUserContact');      
      bool is_data = localStore.containsKey('InvestorUserContact');
      if (is_data) {
        String? temp_data = localStore.getString('InvestorUserContact');
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

}
