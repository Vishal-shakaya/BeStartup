import 'package:be_startup/Backend/Auth/ManageUser.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Components/Widgets/GetPasswordDialog.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';

class SocailAuth extends StatefulWidget {
  const SocailAuth({Key? key}) : super(key: key);

  @override
  State<SocailAuth> createState() => _SocailAuthState();
}

class _SocailAuthState extends State<SocailAuth> {
  bool is_theme_light = false;
  var auth = Get.put(MySocialAuth(), tag: 'socail_auth');
  var authManager = Get.put(AuthUserManager(), tag: 'user_manager');

  @override
  Widget build(BuildContext context) {
    var confirm_pass;

    // Getting password throung dialog : 
    GetPassword(password) {
      confirm_pass = password;
    }

    //  Get user password for link account to already registor account : 
    GetPasswordDialog({task, updateMail}) async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                    width: context.width * 0.20,
                    height: context.height * 0.20,
                    child: GetAuthUserPassword(
                      passwordGetter: GetPassword,
              )));
          });
    }



  //////////////////////////////////////////////////
  /// ALREADY REGISTOR ACCOUNT LINKING PROCESS : 
  ///  [ HANDLE BOTH PHONE AND WEB ]
  ///  1 WITH PASSWORD : 
  ///  2 GOOGLE : 
  ///  3 FACEBOOK : 
  //////////////////////////////////////////////////
    LinkAccountWithWeb(message, data) async {
      final pendingCredentail = data.credential;
      final email = data.email;
      print('user Email $email');
      print('user pending credintail $pendingCredentail');

      if (message == "password_method") {
        // Getting password here:
        await GetPasswordDialog();
        authManager.LinkAccountUsingEmailPassword(
            email: email,
            pendingCredential: pendingCredentail,
            password: confirm_pass);
      }
      if (message == "facebook_method") {
        authManager.LinkWithFacebookInWeb(pendingCredentail);
      }
      if (message == "google_method") {
        authManager.LinkWithGoogleInWeb(pendingCredentail);
      }
      if (message == "twitter_method") {
        authManager.LinkInWithTwitterInWeb(pendingCredentail);
      }

      // if (resp['message'] == "apple_method") {
      //   authManager.LinkWithFacebookInWeb(resp['data']);
      // }
      confirm_pass = '';
    }




    LinkAccountWithPhone(message, data) async {
      final pendingCredentail = data.credential;
      final email = data.eamil;
      print('user Email $email');
      print('user pending credintail $pendingCredentail');

      if (message == "password_method") {
        // Getting password here:
        await GetPasswordDialog();
        authManager.LinkAccountUsingEmailPassword(
            email: email,
            pendingCredential: pendingCredentail,
            password: confirm_pass);
      }

      if (message == "facebook_method") {
        authManager.LinkInWithGoogleInAndroid(pendingCredentail);
      }
      if (message == "google_method") {
        authManager.LinkWithFacebookInAndroid(pendingCredentail);
      }
      if (message == "twitter_method") {
        authManager.LinkInWithTwitterAndroid(pendingCredentail);
      }

      // if (resp['message'] == "apple_method") {
      //   authManager.LinkWithFacebookInWeb(resp['data']);
      // }
    }





    // Google SignIn :
    GoogleSingIn() async {
      var resp;
      if (GetPlatform.isWeb) {
        resp = await auth.SignInWithGoogleInWeb();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithWeb(message, data);
        }
      } else {
        resp = await auth.SigninWithGoogleInAndroid();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithPhone(message, data);
        }
      }
    }



    // Facebook SingIn :
    FacebookSingIn() async {
      var resp;
      if (GetPlatform.isWeb) {
        resp = await auth.signInWithFacebookInWeb();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithWeb(message, data);
        }
      } else {
        resp = await auth.signInWithFacebookInAndroid();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithPhone(message, data);
        }
      }
    }



    // Twitter Singin :
    TwitterSingIn() async {
      var resp;
      if (GetPlatform.isWeb) {
        resp = await auth.signInWithTwitterInWeb();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithWeb(message, data);
        }
      } else {
        resp = await auth.signInWithTwitterAndroid();

        print('Sing in response $resp');
        if (!resp['response']) {
          var data = resp['data'];
          var message = resp['message'];
          await LinkAccountWithPhone(message, data);
        }
      }
    }



    AppleSingIn() async {}

    return Container(
        // alignment: Alignment.centerLeft,
        // margin: EdgeInsets.only(right: 70),
        child: Wrap(
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.down,
      spacing: 15,
      children: [
        // GOOGLE :
        SignInButton(
            buttonType:
                Get.isDarkMode ? ButtonType.googleDark : ButtonType.google,
            elevation: 3,
            onPressed: () async {
              GetPasswordDialog();
              // await GoogleSingIn();
            }),

        // TWITTER :
        SignInButton(
            buttonType: ButtonType.twitter,
            elevation: 3,
            onPressed: () async {
              await TwitterSingIn();
            }),

        // FACEBOOK :
        SignInButton(
            buttonType:
                Get.isDarkMode ? ButtonType.facebookDark : ButtonType.facebook,
            elevation: 3,
            onPressed: () async {
              await FacebookSingIn();
            }),

        // APPLE :
        SignInButton(
            buttonType: ButtonType.apple,
            elevation: 3,
            onPressed: () async {
              await AppleSingIn();
            }),
      ],
    ));
  }
}
