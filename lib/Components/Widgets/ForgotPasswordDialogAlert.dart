import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordAlert extends StatefulWidget {
  ForgotPasswordAlert({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordAlert> createState() => _ForgotPasswordAlertState();
}

class _ForgotPasswordAlertState extends State<ForgotPasswordAlert> {
  var emailController = TextEditingController();
  var fireAuth = Get.put(MyAuthentication(), tag: 'my_auth');


  ShowAlert(context) {
    CoolAlert.show(
        context: context,
        width: 200,
        title: 'Successful',
        type: CoolAlertType.info,
        widget: Text(
          'Password reset link send to registor mail address',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
          ),
        ));
  }


  ErrorSnakbar(message) async {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      margin: EdgeInsets.only(top: 10),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.shade50,
      titleText: MySnackbarTitle(title: 'Something went wrong'),
      messageText: MySnackbarContent(message: message),
      maxWidth: context.width * 0.50,
    );
  }


  //////////////////////////////////////////////
  // Send Email to forgot password : 
  // Only send mailif user already resgitered 
  // With using password method : 
  //////////////////////////////////////////////
  SendpasswordResetLink(context) async {
    final email = emailController.text;
    var resp = await fireAuth.ForgotPassword(email);

    if (resp['response']) {
      Navigator.of(context).pop();
      ShowAlert(context);
    }
    if (!resp['response']) {
      await ErrorSnakbar(resp['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // HEADER TEXT :
          AutoSizeText.rich(
            TextSpan(
                text: 'Enter resgistor mail', style: TextStyle(fontSize: 18)),
            style: Get.textTheme.headline3,
          ),

          TextField(
              controller: emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.key),
                  hintText: 'Enter mail',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),

          // Confirm button widget :
          SubmitFormButton(context),
        ],
      ),
    );
  }


  Container SubmitFormButton(context) {
    return Container(
      width: 220,
      height: 42,
      margin: EdgeInsets.only(top: 20),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            await SendpasswordResetLink(context);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            // side: BorderSide(color: Colors.orange)
          ))),
          child: Text('Submit',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ))),
    );
  }
}
