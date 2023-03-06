import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:get/get.dart';

class MySocialAuth extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var userStore = UserStore();
  ///////////////////////////////////////////////////////////////
  /// CHECK IF ACCOUNT ALREADY EXIST :
  /// 1. THEN CEHCK ALREADY SINGED IN METHOD :
  /// 2. USE THAT METHOD RE-SIGNIN :
  /// 3. LINK MULTIPLE ACCOUNT TO ALREADY REGISTERD EAMIL :
  ////////////////////////////////////////////////////////////////
  AuthErrorHandling(e) async {
    if (e.code == 'account-exists-with-different-credential') {
      // The account already exists with a different credential
      String? email = e.email;
      AuthCredential? pendingCredential = e.credential;
      List<String> userSignInMethods =
          await auth.fetchSignInMethodsForEmail(email!);

      print('Sign in Method ${userSignInMethods.first}');

      // Link with Email :
      if (userSignInMethods.first == 'password') {
        return ResponseBack(
            response_type: false, message: 'password_method', data: e);
      }

      // Link with Facebook :
      if (userSignInMethods.first == 'facebook.com') {
        return ResponseBack(
            response_type: false, message: 'facebook_method', data: e);
      }
      // Link with Google Account :
      if (userSignInMethods.first == 'google.com') {
        return ResponseBack(
            response_type: false, message: 'google_method', data: e);
      }
      // Link with Google Twitter :
      if (userSignInMethods.first == 'twitter.com') {
        return ResponseBack(
            response_type: false, message: 'twitter_method', data: e);
      }

      // Link with Google Apple :
      if (userSignInMethods.first == 'apple.com') {
        return ResponseBack(
            response_type: false, message: 'apple_method', data: e);
      }
    }
  }

  ////////////////////////////////////////////////////
  /// GOOGLE AUTH :
  ////////////////////////////////////////////////////
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

      // Once signed in, return the UserCredential
      try {
        await FirebaseAuth.instance.signInWithCredential(credintail);
        await auth.setPersistence(Persistence.SESSION);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
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

      try {
        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        await auth.setPersistence(Persistence.SESSION);

        return ResponseBack(response_type: true);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
    } catch (e) {
      print('GOOGLE WEB LOGIN ERROR $e');
    }
  }

  ////////////////////////////////////
  /// FACEBOOK AUTH :
  ////////////////////////////////////
  signInWithFacebookInAndroid() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      try {
        final resp =
            FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        return ResponseBack(response_type: true);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
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
      try {
        await FirebaseAuth.instance.signInWithPopup(facebookProvider);
        return ResponseBack(response_type: true);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
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
      try {
        final resp = await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredential);

        return ResponseBack(response_type: true);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
    } catch (e) {
      print('ERROR WHILE LOGIN WITH TWITTER $e ');
    }
  }

  signInWithTwitterInWeb() async {
    try {
      // Create a new provider
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();

      // Once signed in, return the UserCredential
      try {
        final resp =
            await FirebaseAuth.instance.signInWithPopup(twitterProvider);

        return ResponseBack(response_type: true);
      } on FirebaseAuthException catch (e) {
        final error = await AuthErrorHandling(e);
        return error;
      }
    } catch (e) {
      print('Login with Twitter web Error $e');
    }
  }

/////////////////////////////////////
  /// LOGOUT :
  /// ////////////////////////////////
  Logout() async {
    try {
      final mail = await FirebaseAuth.instance.currentUser?.uid;
      print('Logout user mail $mail');
      await FirebaseAuth.instance.signOut();
      try {
        await FacebookAuth.instance.logOut();
      } catch (e) {
        print('Facebook logout error $e');
      }

      // Google Error :
      try {
        googleSignIn.disconnect();
      } catch (e) {
        print('google logout error $e');
      }
    } catch (e) {
      print('Logout Error $e');
    }
  }
}
