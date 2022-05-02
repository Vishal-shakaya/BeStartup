import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStore extends GetxController {
  
  static Map<String, dynamic>? user;
  FirebaseFirestore store = FirebaseFirestore.instance;

  CreateUser({email}) async {
    var temp_user = await UserModel(email: email);
    final user = store.collection('users');
    try {
      Future<DocumentReference<Map<String, dynamic>>> ref = user.add(temp_user);
      // print();
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  UpdateUser({field, val}) {
    // Get User from firebase update ints field :
  }

  CreatePlan({data}) async {
    var plan = PlanModel();
  }
}
