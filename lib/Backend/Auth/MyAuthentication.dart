// Import the firebase_core and cloud_firestore plugin

import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Auth/LinkUser.dart';
import 'package:be_startup/Backend/Auth/Reauthenticate.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/Connector/DeleteStartup.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAuthentication extends GetxController {
  static String image_url = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  var manage_user = AuthUserManager();
  var userStore = UserStore();
  ////////////////////////////////////////
  /// Verify Phone No :
  ////////////////////////////////////////
  VerifyPhoneNo({number, is_update}) async {
    try {
      final currentUser = auth.currentUser;
      // If Updating user then use singin operation
      // else use link Operation to just verify user :
      final confirmationResult = is_update == NumberOperation.update
          ? await auth.signInWithPhoneNumber(number)
          : await auth.currentUser?.linkWithPhoneNumber(number);

      return ResponseBack(response_type: true, data: {
        'confirmationResult': confirmationResult,
        'currentUser': currentUser,
        'verificanId': confirmationResult?.verificationId,
      });
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  // Verify Otp :
  VerifyOtp({currentUser, confirmationResult, otp}) async {
    try {
      UserCredential userCredential = await confirmationResult.confirm(otp);

      return ResponseBack(response_type: true);
    } catch (e) {
      print('not link cred $e');
      return ResponseBack(response_type: false, message: e);
    }
  }

  // Update phone no of currently login user :
  UpdatePhoneNo({verificationId, otp}) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      final update_no = auth.currentUser?.updatePhoneNumber(credential);
      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

// Phone number verification and link no in Android or ios device :
  AndroidPhoneVerificaiton(number) async {
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      // Check Invalid Phone no :
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e);
        return ResponseBack(response_type: false);
      },

      // ANDROID ONLY!
      // Sign the user in (or link) with the auto-generated credential
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('Android code Verification');
        // var res = await auth.signInWithCredential(credential);
        if (GetPlatform.isAndroid) {
          auth.currentUser?.linkWithCredential(credential);
        }
      },

      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },

      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        print('confirm otp');
        String smsCode = '';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await auth.currentUser?.linkWithCredential(credential);
      },
    );
  }

  //////////////////////////////////
  // SIGNUP USING EMAIL , PASSWOD :
  //////////////////////////////////
  SignupUser({email, password}) async {
    // print('Get Signup mail $email');
    // print('Get Signup  password $password');

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verify user email :
      await auth.currentUser?.sendEmailVerification();
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
    // print('Get Login mail $email');
    // print('Get Login  password $password');
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Verify if eamil is verified or not :
      final user = auth.currentUser;
      final verify_email = user?.emailVerified;

      if (verify_email == false) {
        return ResponseBack(response_type: false, data: 'email_not_verify');
      } else {
        try {
          if (GetPlatform.isWeb) {
            await auth.setPersistence(Persistence.SESSION);
          }
          return ResponseBack(response_type: true);
        } catch (e) {
          return ResponseBack(response_type: false);
        }
      }
      // Error Exception:
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ResponseBack(response_type: false, data: e.code);
      } else if (e.code == 'wrong-password') {
        return ResponseBack(response_type: false, data: e.code);
      }
    }
  }

  // RESET USER PASSWORD BY SENDING EMAIL LINK:
  ResetPasswordWithEmail() async {
    try {
      final user = auth.currentUser;
      String? email = user?.email;
      print(email!);
      await user?.reload();
      auth.sendPasswordResetEmail(email: email);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  ForgotPassword(email) async {
    try {
      final method =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (method.contains('password')) {
        auth.sendPasswordResetEmail(email: email);
        return ResponseBack(response_type: true);
      }

      return ResponseBack(
          response_type: false, message: 'mail address not registered');
    } on FirebaseAuthException catch (e) {
      return ResponseBack(
          response_type: false, message: 'mail address not registered');
    }
  }

  // PERMANENT DELETE USER :
  Deleteuser() async {
    var removeStore = Get.put(RemoveStartup());
    var userState = Get.put(UserState());
    var resp;
    final userType = await userState.GetUserType();
    final user = auth.currentUser;

    if (userType == 'investor') {
      resp = await removeStore.DeleteInvestorComplete(user_id: user?.uid);
    }

    if (userType == 'founder') {
      resp = await removeStore.DeleteFounderWithStartups(user_id: user?.uid);
    }
    if (resp['response']) {
      try {
        await user?.delete();
        Get.toNamed(login_handler_url);
        return ResponseBack(response_type: true);
      } catch (e) {
        return ResponseBack(response_type: false, message: e);
      }
    }
  }

  UpdateUserMail(email) async {
    final user = auth.currentUser;
    try {
      await user?.updateEmail(email);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
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
