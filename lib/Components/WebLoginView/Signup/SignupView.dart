import 'package:be_startup/Components/WebLoginView/Signup/SignupBox.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupForm.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupProfileImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:crop_your_image/crop_your_image.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);
  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormBuilderState>();
  String login_text = 'Login';
  final controller = CropController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        child: FractionallySizedBox(
          // widthFactor: 0.20,
          // heightFactor: 0.30,
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                // HEADER TEXT : 
                Text('Signup Now', style: Get.textTheme.headline3),
                
                // UPLOAD PROFILE SECTION : 
                SignupProfileImage(), 

                // SIFNUP FORM : 
                SignupDetailForm()
              ],
          )
           )
            )
             )
        );
      }
}

