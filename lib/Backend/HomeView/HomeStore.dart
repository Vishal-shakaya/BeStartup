import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class ExploreCatigoryStore extends GetxController {
  static SfRangeValues? date_range;
  static var catigory;

// SET DATE:
  SetDateRange(range) async {
    try {
      date_range = range;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetDateRange() async {
    /// Converting the date to a string.
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String? start = formatter.format(date_range!.start);
    // final String? end = formatter.format(date_range!.end);
    print(date_range);
    var rang = {'start': date_range!.start ?? '', 'end': date_range!.end ?? ''};
    return rang;
  }

  // Catigorires :
  SetCatigory(cat) async {
    try {
      catigory = cat;
      // print('Test Catigory ${catigory}');
      // print('Test Setting Time ${date_range}');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetCatigories() async {
    return catigory ?? [];
  }
}
