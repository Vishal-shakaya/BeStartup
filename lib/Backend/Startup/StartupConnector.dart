import 'dart:convert';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

  CreateBusinessCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessCatigory');

      // fetch catigories for local storage :
      // kye : BusinessCatigory
      String? temp_data = localStore.getString('BusinessCatigory');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  CreateBusinessDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessDetail');

      // fetch catigories for local storage :
      // kye : BusinessDetail
      String? temp_data = localStore.getString('BusinessDetail');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateBusinessMileStone() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessMilestones');

      // fetch catigories for local storage :
      // kye : BusinessMilestones
      String? temp_data = localStore.getString('BusinessMilestones');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  CreateBusinessProduct() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessProducts');

      // fetch catigories for local storage :
      // kye : BusinessProducts
      String? temp_data = localStore.getString('BusinessProducts');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  CreateBusinessVision() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessVision');

      // fetch catigories for local storage :
      // kye : BusinessVision
      String? temp_data = localStore.getString('BusinessVision');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateBusinessThumbnail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessThumbnail');

      // fetch catigories for local storage :
      // kye : BusinessThumbnail
      String? temp_data = localStore.getString('BusinessThumbnail');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateUserDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('UserDetail');

      // fetch catigories for local storage :
      // kye : UserDetail
      String? temp_data = localStore.getString('UserDetail');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateUserContact() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('UserContact');

      // fetch catigories for local storage :
      // kye : UserContact
      String? temp_data = localStore.getString('UserContact');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  CreateBusinessTeamMember() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessTeamMember');

      // fetch catigories for local storage :
      // kye : BusinessTeamMember
      String? temp_data = localStore.getString('BusinessTeamMember');
      var data = json.decode(temp_data!);
   
      // Store Data in Firebase :   
      await myStore.add(data);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }




}
