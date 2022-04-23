import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ExploreCatigoryStore extends GetxController {
  static SfRangeValues? date_range;
  static var catigory;
  // SET DATE:
  SetDateRange(range) async {
    try {
      date_range = range;
      print('Test Seting Time ${date_range}');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetDateRange() {
    return date_range;
  }

  // Catigorires :
  SetCatigory(cat) async {
    try {
      catigory = cat;
      print('Test Catigory ${catigory}');
      print('Test Seting Time ${date_range}');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetCatigories() async {
    return catigory;
  }
}
