import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Theme Font
TextTheme LightFontTheme(textTheme) {
  return GoogleFonts.latoTextTheme(textTheme).copyWith(
    // Main Header Text:
    headline1: GoogleFonts.merriweather(
      textStyle: TextStyle(),
      color: light_color_type1,
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
    ),

    // SIGNUP HEADER: 
    headline2: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: light_color_type1,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    // Explain Info Login Page Heading : 
    headline3: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: light_color_type2,
      fontSize: 27,
      fontWeight: FontWeight.w600,
    ),

    // TAB Login Signup Heading:
    headline4: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: light_color_type1,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    // Login Info Explain text
    headline5: GoogleFonts.openSans(
      textStyle: TextStyle(),
      color: light_color_type3,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),

    // Login input Label text 
    // headline6: GoogleFonts.openSans(
    //   textStyle: TextStyle(),
    //   color: Colors.blueGrey[900],
    //   fontSize: 16,
    //   fontWeight: FontWeight.w600,
    // ),

    // Web Text Content
    bodyText1: GoogleFonts.openSans(
      textStyle: TextStyle(),
      color: Colors.blueGrey[700],
      fontSize: 19,
    ),
  );
}

// Dark Font theme
TextTheme DarkFontTheme(textTheme) {
  return GoogleFonts.latoTextTheme(textTheme).copyWith(

    // Page Heading text: 
    headline1: GoogleFonts.merriweather(
      textStyle: TextStyle(),
      color: dartk_color_type2, //light grey
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
    ),

    //  Info Explain Heading
    headline3: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: dartk_color_type1, // white
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),

    // Signup Heading Text : 
    headline2: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: dartk_color_type2, // light grey
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    // Login Signup Tab : 
    headline4: GoogleFonts.robotoSlab(
      textStyle: TextStyle(),
      color: dartk_color_type2 , // orange 
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

    // Info Explain text :
    headline5: GoogleFonts.openSans(
      textStyle: TextStyle(),
      color:dartk_color_type4, // light blue_grey 
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),

    // headline6: GoogleFonts.openSans(
    //   textStyle: TextStyle(),
    //   color: Colors.blueGrey[900],
    //   fontSize: 16,
    //   fontWeight: FontWeight.w400,
    // ),

    // Web Text Content
    bodyText1: GoogleFonts.openSans(
      textStyle: TextStyle(),
      color: Colors.blueGrey[700],
      fontSize: 19,
    ),
  );
}
