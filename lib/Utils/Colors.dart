import 'package:flutter/cupertino.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:flutter/material.dart';

Color heading_color = Color(0xff000000);
Color text_color = Color(0xff1e3d59);
Color background_color = Color(0xfff5f0e1);
Color hover_color = Color(0xff1e847f);

// LIGHT COLOR THEME :
final light_color_type1 = Colors.blueGrey[900];
final light_color_type2 = Colors.blueGrey[800];
final light_color_type3 = Colors.blueGrey;
final primary_light = Color(0xFF54BAB9); 

// DARK COLOR THEME :
final dartk_color_type1 = Colors.white;
final dartk_color_type2 = Colors.grey.shade100;
final dartk_color_type3 = Colors.orangeAccent;
final dartk_color_type4 = Colors.blueGrey.shade200;

Gradient g1 = LinearGradient(
  colors: [
    Color(0xFF02AABD),
    Color(0xFF00CDAC),
  ],
);

Gradient g2 = LinearGradient(colors: [
  Color(0xfff12711),
  Color(0xfff5af19),
]);

// Signup button gradient :
Gradient g3 = LinearGradient(colors: [
  Color(0xffffffff),
  Color(0xffffffff),
]);
