// Import the firebase_core and cloud_firestore plugin
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserManagerStore extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // 1 UPDATE EMAIL :
  // 2 UPDATE PASSWORD :
  // 3 UPDATE PHONE NO :
  // 4 REMOVE USER :

  // RESET PASSWORD WITH EAMIL LINK :
  ResetPasswordWithEmail() async {
    try {
      final user = auth.currentUser;
      String? email = user?.email;
      print(email!);
      await user?.reload();
      auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  // DELETE USER :
  DeleteUser() async {
    final user = auth.currentUser;
    try {
      await user?.reload();
      await user?.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
