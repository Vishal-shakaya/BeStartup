import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserStore extends GetxController {
  static Map<String, dynamic>? user;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  /// It checks if the user is already created in
  /// the database, if not then it creates the user in the
  /// database
  /// Returns:
  ///   Nothing.
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
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

/////////////////////////////////////////////////////
  /// UPDATE USER PLAN AND STARTUP FIELD :
  /// Plan and Startups may more than one  :
  /// It takes a field and a value, and then updates the user's
  /// profile with the value in the field
  /// Args:
  ///   field: The field you want to update in the user's profile.
  ///   val: The value to be added to the array
/////////////////////////////////////////////////////
  UpdateUserPlanAndStartup({field, val}) async {
    var temp_plan = [];
    // Get User from firebase update ints field :
    final id = auth.currentUser?.uid;
    final email = auth.currentUser?.email;
    final user = store.collection('users');
    var old_user;
    var obj_id;
    try {
      await user.where('email', isEqualTo: email).get().then((value) {
        old_user = value.docs.first.data();
        obj_id = value.docs.first.id;
      });

      // Check if param null or empty list then :
      // add new value in list then add that list :
      if (old_user[field] == null || old_user[field] == []) {
        temp_plan.add(val);
        old_user[field] = temp_plan;
      }

      // else add value in pre define list :
      else {
        old_user[field] = old_user[field].add(val);
      }
      
      // Update object to DB :
      user.doc(obj_id).update(old_user);

      return ResponseBack(
          response_type: true, message: '$field Crated to user profile');
    } catch (e) {
      return ResponseBack(
          response_type: false, message: 'Unable to Create $field');
    }
  }

  ////////////////////////////////////
  /// Check if user Already buy plan :
  ////////////////////////////////////
  IsAlreadyPlanBuyed() async {
    // Get User from firebase update ints field :
    final id = auth.currentUser?.uid;
    final email = auth.currentUser?.email;
    final user = store.collection('users');
    var old_user;
    var plan;
    try {
      await user.where('email', isEqualTo: email).get().then((value) {
        old_user = value.docs.first.data();
        plan = old_user['plan'];
      });

      // 1. Check if user purchase plan without startup : Add startup withdout pay :
      if (plan == null || plan == []) {
        return ResponseBack(
            response_type: true,
            data: IsUserPlanBuyedType.newplan,
            message: 'NowPre Plan Found ');
      }

      // 2. Check if user has plan without startup
      if (plan.length >= 1) {
        plan.forEach((el) {
          print(el['startup']);
        });
        return ResponseBack(
            response_type: true,
            data: IsUserPlanBuyedType.preplan,
            message: 'Pre Plan Found ');
      }

      return ResponseBack(
        response_type: false,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
