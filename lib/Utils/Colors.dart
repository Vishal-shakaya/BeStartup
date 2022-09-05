import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Color heading_color = Color(0xff000000);
Color text_color = Color(0xff1e3d59);
Color background_color = Color(0xfff5f0e1);
Color hover_color = Color(0xff1e847f);

// LIGHT COLOR THEME :
final light_color_type1 = Colors.blueGrey[900];
final light_color_type2 = Colors.blueGrey[800];
final light_color_type3 = Colors.blueGrey;
final light_color_type4 = Colors.blueGrey.shade700;
final input_label_color = Colors.grey;

final border_color = Colors.grey.shade300;
final shadow_color1 = Colors.grey.shade300;

// reset text field icon color :
final input_reset_color = Colors.grey;

final primary_light = Color(0xFF54BAB9);
final primary_light_hover = Color(0xFFC8F2EF);

final primary_light2 = Color(0xFF79B4B7);

final light_black = Colors.black87; // input text color
final darkTeal = Colors.teal.shade400; // focus input border

// DARK COLOR THEME :
final dartk_color_type1 = Colors.white;
final dartk_color_type2 = Colors.grey.shade100;
final dartk_color_type4 = Colors.blueGrey.shade100;
final dartk_color_type5 = Colors.blueGrey.shade200;

final tealAccent = Colors.tealAccent; // focus

final dartk_color_type3 = Colors.orangeAccent; // tab

// CHIP COLOR :
Color chip_text_color = Colors.blueGrey;

Color chip_color = Colors.blueGrey;
Color chip_activate_text_color = Colors.white;
Color chip_activate_background = primary_light;
// Color chip_activate_text_color = primary_light;
// Color chip_activate_background = Colors.teal.shade50;

Color shimmer_base_color = Colors.blueGrey;
Color shimmer_highlight_color = Colors.blueGrey.shade200;
Color shimmer_background_color = Colors.blueGrey.shade50;

Gradient g1 = const LinearGradient(
  colors: [
    Color(0xFF02AABD),
    Color(0xFF00CDAC),
  ],
);

Gradient g2 = const LinearGradient(colors: [
  Color(0xfff12711),
  Color(0xfff5af19),
]);

// Signup button gradient :
Gradient g3 = const LinearGradient(colors: [
  Color(0xffffffff),
  Color(0xffffffff),
]);

///////////////////////////////////////////
/// Theme Color:
// #596668
// cancel icon size : 16
///////////////////////////////////////////

// Theme Color :
Color my_theme_background_color = Get.isDarkMode ? Colors.grey.shade900 : Colors.white;

// Input Field Hint text color :
Color input_hind_color =
    Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade300;

Color input_text_color =
    Get.isDarkMode ? Colors.grey.shade300 : Colors.blueGrey.shade900;

// Startup Slide Header text color :
Color slide_header_color =
    Get.isDarkMode ? Colors.grey.shade200 : Colors.blueGrey.shade800;

// Startup Slide Sub Header text color :
Color slide_subheader_color =
    Get.isDarkMode ? Colors.blueGrey.shade200 : Colors.blueGrey;

// cross icon color close dialog and clear input filed icon color :
Color cancel_btn_color = Colors.blueGrey.shade200;

Color next_back_btn_color =
    Get.isDarkMode ? Color(0xFF54BAB9) : Colors.grey.shade800;

// Product Title color little dart and des ligheter then product :
Color product_title_color =
    Get.isDarkMode ? Colors.blueGrey.shade200 : Colors.blueGrey.shade800;

Color product_description_color =
    Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade800;

Color form_shadow_color = Get.isDarkMode ? Colors.white : Colors.grey;
Color form_border_color = Get.isDarkMode ? Colors.white : Colors.transparent;

// Dialog Color Light and dark :
Color my_dialog_color = Colors.grey;

Color darkGrey = Colors.grey.shade800;

////////////////////////////////////////////
///  Icon :
////////////////////////////////////////////
var my_cancel_icon = FontAwesomeIcons.xmark;
