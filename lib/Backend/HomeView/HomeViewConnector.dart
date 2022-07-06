import 'dart:convert';
import 'package:be_startup/AppState/UserState.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class HomeViewConnector extends GetxController {

  // FetchStartups() async {
  //   var data;
  //   try {
  //     // FETCHING DATA FROM FIREBASE
  //     var store =
  //         FirebaseFirestore.instance.collection('startups');
  //     var query =
  //         store.where('startup_id', isEqualTo: await getStartupId).get();

  //     await query.then((value) {
  //       data = value.docs.first.data() as Map<String, dynamic>;
  //     });

  //     // CACHE BUSINESS DETAIL :
  //     await StoreCacheData(fromModel: getBusinessDetailStoreName, data: data);

  //     return ResponseBack(
  //         response_type: true,
  //         data: data,
  //         message: 'Business Detail Fetch from Database');
  //   } catch (e) {
  //     return ResponseBack(
  //       response_type: false,
  //       data: shimmer_image,
  //     );
  //   }
  // }
}
