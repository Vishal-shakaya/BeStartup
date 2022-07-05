
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class ReAuthentication extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ////////////////////////////////////////////////////
  /// GOOGLE AUTH :
  ////////////////////////////////////////////////////
  // Google param :
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;

  // PHONE : ANDROID AND IOS LOGIN :
  ReSigninWithGoogleInAndroid() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        user = googleUser;
      }
      final googleAuth = await googleUser?.authentication;
      final credintail = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.currentUser?.reauthenticateWithCredential(credintail);
    } catch (e) {
      print('google android error $e');
    }
  }

  // WEB LOGIN :
  ReSignInWithGoogleInWeb() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      var resp1 = googleProvider
          .setCustomParameters({'login_hint': 'user@example.com'});
      // Once signed in, return the UserCredential
      print(resp1);
      final resp = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      await auth.currentUser?.reauthenticateWithCredential(resp.credential!);
      
    } catch (e) {
      print('GOOGLE WEB LOGIN ERROR $e');
    }
  }
}
