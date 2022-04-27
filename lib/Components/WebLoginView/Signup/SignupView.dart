import 'dart:typed_data';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupBox.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupProfileImage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:get/get.dart';

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
                SignupForm(), 

              ],
          )
           )
            )
             )
          );
      }
}

