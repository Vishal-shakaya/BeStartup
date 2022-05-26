import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAuthUserPassword extends StatefulWidget {
  var passwordGetter;
  GetAuthUserPassword({this.passwordGetter, Key? key}) : super(key: key);

  @override
  State<GetAuthUserPassword> createState() => _GetAuthUserPasswordState();
}

class _GetAuthUserPasswordState extends State<GetAuthUserPassword> {
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // HEADER TEXT :
          AutoSizeText.rich(
            TextSpan(text: 'Confirm User', style: TextStyle(fontSize: 18)),
            style: Get.textTheme.headline3,
          ),

          TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Confirm password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),

             // Confirm button widget :      
            SubmitFormButton(),
        ],
      ),
    );
  }

  Container SubmitFormButton() {
    return Container(
      width: 220,
      height: 42,
      margin: EdgeInsets.only(top: 20),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            final pass = passwordController.text;
            await widget.passwordGetter(pass);
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
