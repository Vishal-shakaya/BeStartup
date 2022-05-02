import 'dart:convert';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestorConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

  
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

      // fetch catigories for local storage :
      // kye : InvestorUserContact
      
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
