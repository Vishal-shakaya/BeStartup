import 'dart:html';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class MySocialAuth extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ////////////////////////////////////////////////////
  /// GOOGLE AUTH :
  ////////////////////////////////////////////////////
  // Google param :
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  // PHONE : ANDROID AND IOS LOGIN :
  SigninWithGoogleInAndroid() async {
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
      final resp = await FirebaseAuth.instance.signInWithCredential(credintail);
    } catch (e) {
      print('google android error $e');
    }
  }

  // WEB LOGIN :
  SignInWithGoogleInWeb() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      // Once signed in, return the UserCredential
      final resp = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      print(resp.user?.email);
      print(resp.user);
    } catch (e) {
      print('GOOGLE WEB LOGIN ERROR $e');
    }
  }

  ////////////////////////////////////
  /// FACEBOOK AUTH :
  ////////////////////////////////////
  // FACEBOOK PHONE :
  signInWithFacebookInAndroid() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final resp =
          FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }

  // FACEBOOK WEB LOGIN :
  signInWithFacebookInWeb() async {
    try {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    } catch (e) {
      print(' FACEBOOK ANDROID LOGIN ERROR $e');
    }
  }

  ////////////////////////////////////////////////////
  /// TWITTER AUTH :
  ////////////////////////////////////////////////////
  signInWithTwitterAndroid() async {
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
      // Once signed in, return the UserCredential
      final resp = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      print(resp);
    } catch (e) {
      print('ERROR WHILE LOGIN WITH TWITTER $e ');
    }
  }

  signInWithTwitterInWeb() async {
    try {
      // Create a new provider
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();
      // Once signed in, return the UserCredential
      final resp = await FirebaseAuth.instance.signInWithPopup(twitterProvider);
      print(resp);
    } catch (e) {
      print('Login with Twitter web Error $e');
    }
  }

  Logout() async {
    // Logout from firebase :
    FirebaseAuth.instance.signOut();
    // Facebook signout :
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print('Facebook logout error');
    }

    // Google Error :
    try {
      googleSignIn.disconnect();
    } catch (e) {
      print('google logout error');
    }
  }
}
