// Import the firebase_core and cloud_firestore plugin
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAuthentication extends GetxController{
  static String image_url = '';

  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  
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
  
  //////////////////////////////
  // FIRESBASE EMAIL LOGIN: 
  //////////////////////////////
  LoginUser({email, password}) async {
    final users = store.collection('users');
    try {
      users.add({
        'email': email,
        'password': password,
      });
    } catch (err) {
      print('UNABLE TO LOGIN ${err}');
    }
  }

}