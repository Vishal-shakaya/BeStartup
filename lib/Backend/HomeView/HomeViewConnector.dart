import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class HomeViewConnector extends GetxController {
  FetchStartups() async {
    var startup_data;
    var startup_ids = [];
    var founder_ids = [];
    var startup_len;
    var startup_names = [];

    // FETCHING DATA FROM FIREBASE
    try {
      var startup = await FirebaseFirestore.instance
          .collection(getStartupStoreName)
          .get()
          .then((value) {
        startup_len = value.size;
        for (var doc in value.docs) {
          startup_ids.add(doc.data()['id']);
          founder_ids.add(doc.data()['user_id']);
          startup_names.add(doc.data()['startup_name']);
        }
      });
      startup_data = {
        'startup_ids': startup_ids,
        'founder_id': founder_ids,
        'startup_len': startup_len,
        'startup_name':startup_names 
      };

      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
