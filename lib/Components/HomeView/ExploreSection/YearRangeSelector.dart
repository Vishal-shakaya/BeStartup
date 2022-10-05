import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DateRangePicker extends StatefulWidget {
  DateRangePicker({Key? key}) : super(key: key);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  SfRangeValues values =
      SfRangeValues(DateTime(2003, 01, 01), DateTime(2010, 01, 01));

  var exploreStore = Get.put(ExploreCatigoryStore(), tag: 'explore_store');

  double range_cont_width = 0.45;
  double tooltip_fontSize = 12;
  double thumbnail_radius = 9;

  SetRange(range) async {
    var res = await exploreStore.SetDateRange(range);
  }

  @override
  Widget build(BuildContext context) {
    range_cont_width = 0.45;
    tooltip_fontSize = 12;
    thumbnail_radius = 9;

    // DEFAULT :
    if (context.width > 1700) {
      range_cont_width = 0.45;
      tooltip_fontSize = 12;
      thumbnail_radius = 9;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      range_cont_width = 0.40;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      range_cont_width = 0.50;
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      range_cont_width = 0.60;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      range_cont_width = 0.70;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      tooltip_fontSize = 11;
      range_cont_width = 0.80;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      range_cont_width = 0.95;
      tooltip_fontSize = 10;
      print('480');
    }

    return Container(
      width: context.width * range_cont_width,
      child: SfRangeSliderTheme(
        data: SfRangeSliderThemeData(
          tooltipTextStyle: TextStyle(
            fontSize: tooltip_fontSize,
            color: Colors.white,
          ),
          thumbColor: Colors.orange.shade300,
          thumbRadius: thumbnail_radius,
          activeTrackColor: Colors.orange.shade300,
          activeLabelStyle: TextStyle(
              color: light_color_type2,
              fontSize: tooltip_fontSize,
              fontStyle: FontStyle.italic),
          inactiveLabelStyle: TextStyle(
              color: Colors.grey,
              fontSize: tooltip_fontSize,
              fontStyle: FontStyle.italic),
        ),
        child: SfRangeSlider(
          values: values,
          min: DateTime(2000, 01, 01, 00),
          max: DateTime(2022, 1, 1, 1),
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          interval: 4,
          dateFormat: DateFormat.y(),
          dateIntervalType: DateIntervalType.years,
          onChanged: (SfRangeValues newValues) async {
            setState(() {
              values = newValues;
            });

            await SetRange(newValues);
          },
        ),
      ),
    );
    ;
  }
}
