// import 'dart:convert';
// import 'package:be_startup/AppState/UserState.dart';
// import 'package:be_startup/Utils/Messages.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// var uuid = Uuid();

// class StartupViewConnector extends GetxController {

//   // 1. Retrive thumbnial using [ id , email , startup name ]
//   // 2. Send it to ui
//   // 3. Store data in local storage:
//   Fetch() async {
//     try {
//       ////////////////////////////////////////////////////
//       // Check if Thumbnail is cached then send it else
//       // fetch form DB:
//       ////////////////////////////////////////////////////
//       final cacheData = await GetCachedData('BusinessThumbnail');
//       if (cacheData != false) {
//         return cacheData['thumbnail'];
//       }

//       // FETCHING DATA FROM FIREBASE:
//       var data;
//       var thumbnail =
//           FirebaseFirestore.instance.collection('BusinessThumbnail');
//       var query = thumbnail
//           .where(
//             'email',
//             isEqualTo: getuserEmail,
//           )
//           .where('user_id', isEqualTo: getUserId)
//           .where('startup_name', isEqualTo: getStartupName)
//           .get();

//       await query.then((value) {
//         data = value.docs.first.data() as Map<String, dynamic>;
//       });

//       // STORE DATA TO DB :
//       await StoreCacheData(fromModel: 'BusinessThumbnail', data: data);

//       return data['thumbnail'];
//     } catch (e) {
//       print(e);
//       return shimmer_image;
//     }
//   }

// }
