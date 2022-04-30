// Import the firebase_core and cloud_firestore plugin
import 'package:be_startup/Backend/Auth/ManageUserStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MyAuthentication extends GetxController {
  static String image_url = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  var manage_user = AuthUserManagerStore();
  var userStore = UserStore();
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

      // Verify if eamil is verified or not :
      final user = auth.currentUser;
      final verify_email = user?.emailVerified;

      if (verify_email == false) {
        return ResponseBack(response_type: false, data: 'email_not_verify');
      } else {
        // Create User :
        try {
          userStore.CreateUser(email: email);
          return ResponseBack(response_type: true);
        } catch (e) {
          return ResponseBack(response_type: false);
        }
      }

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
    try {
      print(auth.currentUser);
      await auth.signOut();
      print(auth.currentUser);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // RESET USER PASSWORD BY SENDING EMAIL LINK:
  ResetPasswordWithEmail() async {
    var resp = await manage_user.ResetPasswordWithEmail();
    if (resp) {
      return ResponseBack(response_type: true);
    } else {
      return ResponseBack(response_type: false);
    }
  }

  // PERMANENT DELETE USER :
  Deleteuser() async {
    var resp = await manage_user.DeleteUser();
    if (resp) {
      return ResponseBack(response_type: true);
    } else {
      ResponseBack(response_type: false);
    }
  }

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
