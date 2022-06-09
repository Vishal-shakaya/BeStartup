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



  UpdateUserPlanAndStartup({field, val}) async {
    var temp_plan = [];
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

      print('Updating : ${old_user[field]}');

      // Set Update Params :
      if (old_user[field] == null || old_user[field] == []) {
        temp_plan.add(val);
        old_user[field] = temp_plan;

        print('******** NEW $field ADDED ********');
      } else {
        old_user[field] = old_user[field].add(val);
        print('******** PREDEFINE NEW $field ADDED ********');
      }

      // Update object to DB :
      user.doc(obj_id).update(old_user);
      print('*** UpDate object DB *****');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false  ,message: e);
    }
  }




  IsAlreadyPlanBuyed() async {
    // Get User from firebase update ints field :
    final id = auth.currentUser?.uid;
    final email = auth.currentUser?.email;
    final user = store.collection('users');
    var old_user;
    var plan = [];
    try {
      // Update Perticular Object using query :
      // get user object using mail address and update:
      await user.where('email', isEqualTo: email).get().then((value) {
        old_user = value.docs.first.data();
        plan = old_user['plan'];
      });

      // User Plan Check Before continue :
      // 1. Check if user purchase plan without startup : Add startup withdout pay :
      if (plan.isEmpty) {
        print('newplan found'); // test
        return IsUserPlanBuyedType.newplan;
      } else {
        // 2. Check if user has plan with startup , pay first Then Add new startup
        print('preplan  found'); //test
        return IsUserPlanBuyedType.preplan;
      }
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
