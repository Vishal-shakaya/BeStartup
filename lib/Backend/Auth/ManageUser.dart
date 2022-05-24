// Import the firebase_core and cloud_firestore plugin
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserManager extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // 1 UPDATE EMAIL :
  // 2 UPDATE PASSWORD :
  // 3 UPDATE PHONE NO :
  // 4 REMOVE USER :

  // RESET or FORGOT PASSWORD WITH EAMIL LINK :
  ResetPasswordWithEmail() async {
  }

  // DELETE USER :
  DeleteUser() async {
  }
}
