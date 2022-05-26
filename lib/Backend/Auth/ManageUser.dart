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
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthUserManager extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///////////////////////////////////////////////////
  // EMAIL AND PASSWORD METHOD TO LOGIN ACCOUNT :
  ///////////////////////////////////////////////////
  LinkAccountUsingEmailPassword({email, password, pendingCredential}) async {
    
    try {
      // Sign the user in to their account with the password
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.linkWithCredential(pendingCredential!);
      print('Account Linked ');

      // Signin and Link Account :
      final user = auth.currentUser;
      final verify_email = user?.emailVerified;
      if (verify_email == false) {
        await user?.sendEmailVerification();
        return ResponseBack(response_type: false, message: 'email_not_verify');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  ////////////////////////////////////
  /// FACEBOOK AUTH :
  ////////////////////////////////////
  LinkWithFacebookInAndroid(pendingCredential) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Signin and Link Account :
      final resp = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      resp.user?.linkWithCredential(pendingCredential);
      print('Account Linked Facebook account ');
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }

  // FACEBOOK WEB LINK ACCOUNT  :
  LinkWithFacebookInWeb(pendingCredential) async {
    try {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Signin and Link Account :
      var resp = await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      resp.user?.linkWithCredential(pendingCredential);
      print('Account Linked Facebook account ');
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }

  ////////////////////////////////////////////
  /// GOOGLE ACCOUNT LINKING :
  ////////////////////////////////////////////
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;

  // PHONE : ANDROID AND IOS LOGIN :
  LinkInWithGoogleInAndroid(pendingCredential) async {
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

      // Signin and Link Account :
      final resp = await FirebaseAuth.instance.signInWithCredential(credintail);
      resp.user?.linkWithCredential(pendingCredential);
      print('Successful link account with google');
    } catch (e) {
      print('google android error $e');
    }
  }

  LinkWithGoogleInWeb(pendingCredential) async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Signin and Link Account :
      final resp = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      resp.user?.linkWithCredential(pendingCredential);
      print('Successful link account with google');
    } catch (e) {
      print('GOOGLE WEB LOGIN ERROR $e');
    }
  }

  ////////////////////////////////////////////////////
  /// TWITTER LINK ACCOUNT :
  ////////////////////////////////////////////////////
  LinkInWithTwitterAndroid(pendingCredential) async {
    try {
      // Create a TwitterLogin instance
      final twitterLogin = new TwitterLogin(
          apiKey: 'AT6OPJs58IopqfbYUYrziuFgh',
          apiSecretKey: 'CD62jEONWJJOTmWdTGPQN9H1yVrYfKuqDq3t4I7c9fDy6ZHrBy',
          redirectURI:
              'https://bestartup-680d0.firebaseapp.com/__/auth/handler');

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Signin and Link Account :
      final resp = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      resp.user?.linkWithCredential(pendingCredential);
      print('Successful link account with Twitter');
    } catch (e) {
      print('ERROR WHILE LOGIN WITH TWITTER $e ');
    }
  }

  // Twitter Web :
  LinkInWithTwitterInWeb(pendingCredential) async {
    try {
      // Create a new provider
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();

      // Signin and Link Account :
      final resp = await FirebaseAuth.instance.signInWithPopup(twitterProvider);
      resp.user?.linkWithCredential(pendingCredential);
      print('Successful link account with Twitter');
    } catch (e) {
      print('Login with Twitter web Error $e');
    }
  }
}
