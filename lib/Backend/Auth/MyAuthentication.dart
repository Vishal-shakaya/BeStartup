// Import the firebase_core and cloud_firestore plugin
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAuthentication extends GetxController {
  static String image_url = '';

  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //////////////////////////////////
  // SIGNUP USING EMAIL , PASSWOD :
  //////////////////////////////////
  SignupUser({email, password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = auth.currentUser;
      // Verify user email :
      await user?.sendEmailVerification();

      return ResponseBack(response_type: true);

      // Error Exception :
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ResponseBack(response_type: false, data: e.code);
      } else if (e.code == 'email-already-in-use') {
        return ResponseBack(response_type: false, data: e.code);
      }
    } catch (e) {
      return ResponseBack(response_type: false, data: e);
    }
  }

////////////////////////////////////////////
  // LOGIN USER WITH EMAIL AND PASSWORD :
////////////////////////////////////////////
  LoginUser({email, password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return ResponseBack(
        response_type: true,
      );

      // Error Exception:
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ResponseBack(response_type: false, data: e.code);
      } else if (e.code == 'wrong-password') {
        return ResponseBack(response_type: false, data: e.code);
      }
    }
  }

  // LOGOUT USER :
  LogoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  //////////////////////////////
  // FIRESBASE EMAIL LOGIN:
  //////////////////////////////
  // LoginUser({email, password}) async {
  //   final users = store.collection('users');
  //   try {
  //     users.add({
  //       'email': email,
  //       'password': password,
  //     });
  //   } catch (err) {
  //     print('UNABLE TO LOGIN ${err}');
  //   }
  // }

  // UPLOAD IMAGE :
  UploadProfileImage({image, filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: image, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
