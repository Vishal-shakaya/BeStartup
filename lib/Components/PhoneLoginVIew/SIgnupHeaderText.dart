
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupHeaderText extends StatelessWidget {
  const SignupHeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(
        top:context.height *0.07, 
        bottom:context.height *0.01
        ),

      child: AutoSizeText.rich(
        TextSpan(
          text: 'Create New Account',
           style: GoogleFonts.robotoSlab(
              textStyle: TextStyle(),
              color: light_color_type1,
              fontSize: 23,
              fontWeight: FontWeight.w600,
    
        )),
    ));
  }
}