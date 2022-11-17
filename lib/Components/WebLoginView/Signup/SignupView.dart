import 'package:be_startup/Components/WebLoginView/Signup/SignupBox.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupForm.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupProfileImage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);
  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormBuilderState>();
  final controller = CropController();

  String login_text = 'Login';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        child: FractionallySizedBox(

          child: Container(
            margin: EdgeInsets.only(top: context.height*0.10),
           
            child: Column(
             
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                 
                Text(
                  'Signup Now', 
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(),
                    color: light_color_type2,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
                

                // UPLOAD PROFILE SECTION : 
                // SignupProfileImage(), 

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

