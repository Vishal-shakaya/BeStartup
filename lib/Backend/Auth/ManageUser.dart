// Import the firebase_core and cloud_firestore plugin
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthUserManager extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  LinkAccountUsingEmailPassword({email, password, pendingCredential}) async {
    try {
      // Sign the user in to their account with the password
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Link the pending credential with the existing account
      await userCredential.user?.linkWithCredential(pendingCredential!);
      print('Account Linked ');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  ////////////////////////////////////
  /// FACEBOOK AUTH :
  ////////////////////////////////////
  // FACEBOOK PHONE :
  LinkWithFacebookInAndroid({pendingCredential}) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential resp = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      resp.user?.linkWithCredential(pendingCredential);
      print('Account Linked ');
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }

  // FACEBOOK WEB LOGIN :
  LinkWithFacebookInWeb(pendingCredential) async {
    try {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      var resp = await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      resp.user?.linkWithCredential(pendingCredential);
      print('Account Linked ');
      
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }
}
