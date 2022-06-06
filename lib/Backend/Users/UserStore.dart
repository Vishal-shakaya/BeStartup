import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserStore extends GetxController {
  static Map<String, dynamic>? user;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  CreateUser() async {
    final id = auth.currentUser?.uid;
    final email = auth.currentUser?.email;
    final temp_user = await UserModel(email: email, id: id);
    final user = store.collection('users');
    var is_user_found;
    try {
      // Check if user already exist :
      // if not then create use in DB :
      final query = user.where('email', isEqualTo: email).get();
      await query.then((value) {
        is_user_found = value.docs.length;
      });

      // if length is 0 then user not created before :
      if (is_user_found == 0) {
        Future<DocumentReference<Map<String, dynamic>>> ref =
            user.add(temp_user);
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // Check if user complete Creating profile :
  IsUserActivate() async {}

  UpdateUser({field, val}) async {
    // Get User from firebase update ints field :
    final id = auth.currentUser?.uid;
    final email = auth.currentUser?.email;
    final user = store.collection('users');
    var old_user;
    var obj_id;
    try {
      // Update Perticular Object using query : 
      // get user object using mail address and update: 
      await user.where('email', isEqualTo: email).get().then((value) {
        old_user = value.docs.first.data();
        obj_id = value.docs.first.id;
      });

      // Set Update Params : 
      old_user['plan'] = val;

      // Update object to DB : 
      user.doc(obj_id).update(old_user);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  CreatePlan({data}) async {
    var plan = PlanModel();
  }
}
