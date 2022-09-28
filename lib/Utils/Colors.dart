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
Color my_theme_background_color =
    Get.isDarkMode ? Colors.grey.shade900 : Colors.white;

Color my_theme_container_color =
    Get.isDarkMode ? Colors.grey.shade800 : Colors.white;

Color my_theme_icon_color =
    Get.isDarkMode ? Colors.tealAccent : Colors.orangeAccent;

Color my_theme_shadow_color =
    Get.isDarkMode ? Colors.tealAccent : Colors.orangeAccent;

Color serach_bar_text_color = Colors.black;

Color view_btn_text_color =
    Get.isDarkMode ? Colors.teal.shade400 : Colors.teal.shade500;

Color mile_text_color =
    Get.isDarkMode ? Colors.blueGrey.shade900 : Colors.blueGrey.shade900;

Color mile_cont_bg_color =
    Get.isDarkMode ? Colors.orange.shade400 : Colors.orange.shade200;



Color edit_btn_color =
    Get.isDarkMode ? Colors.blueGrey.shade300 : Colors.blueGrey.shade800;



Color delete_background_btn_color =
    Get.isDarkMode ? Colors.transparent : Colors.red.shade50;

Color tab_color =
    Get.isDarkMode ? Colors.blueGrey.shade200 : Colors.blueGrey.shade700;

Color tab_border_color =
    Get.isDarkMode ? Colors.blueGrey.shade400 : Colors.grey.shade200;

Color minimap_border_color =
    Get.isDarkMode ? Colors.blueGrey.shade400 : Colors.grey.shade200;

Color mini_map_background_color =
    Get.isDarkMode ? Colors.grey.shade800 : Colors.white;

Color startup_container_border_color =
    Get.isDarkMode ? Colors.blueGrey.shade400 : Colors.grey.shade300;

Color map_text_color =
    Get.isDarkMode ? Colors.grey.shade300 : Colors.blueGrey.shade800;


Color startup_title_text_color =
    Get.isDarkMode ? Colors.blueGrey.shade400 : Colors.grey.shade300;


Color startup_text_color =
    Get.isDarkMode ? Colors.grey.shade300 : Colors.blueGrey;

Color startup_heding_color =
    Get.isDarkMode ? Colors.blueGrey.shade300 : Colors.blueGrey.shade700;

Color startup_profile_color =
    Get.isDarkMode ? Colors.grey.shade300 : Colors.black;



Color login_page_heading_color =
    Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade900;

Color login_page_detail_sec_title_color =
    Get.isDarkMode ? Colors.grey.shade200 : Colors.blueGrey.shade800;

Color login_page_detail_sec_desc_color =
    Get.isDarkMode ? Colors.blueGrey.shade200 : Colors.blueGrey;


Color login_page_singin_text =
    Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade900;




Color home_profile_text_color =
    Get.isDarkMode ? Colors.blueGrey.shade100: Colors.black87;

Color home_profile_contact_color =
    Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade700;

Color home_profile_map_color =
    Get.isDarkMode ? Colors.grey.shade300 : Colors.blueGrey.shade300;

Color home_profile_cont_color =
    Get.isDarkMode ? Colors.grey.shade900 : Colors.blueGrey.shade300;

Color home_setting_tile_hover_color =
    Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;





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
Color close_model_color =
    Get.isDarkMode ? Colors.blueGrey.shade300 : Colors.blueGrey.shade800;

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
/// Cancel Icon : Icons.close :
/// CLose Dialog button : cancel_rounded,
////////////////////////////////////////////
var my_cancel_icon = FontAwesomeIcons.xmark;
