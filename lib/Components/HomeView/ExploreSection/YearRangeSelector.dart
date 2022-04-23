import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
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

  SetRange(range) async {
    var res = await exploreStore.SetDateRange(range);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.3,
      child: SfRangeSliderTheme(
        data: SfRangeSliderThemeData(
          tooltipTextStyle: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          thumbColor: Colors.orange.shade300,
          thumbRadius: 9,
          activeTrackColor: Colors.orange.shade300,
          activeLabelStyle: TextStyle(
              color: light_color_type2,
              fontSize: 12,
              fontStyle: FontStyle.italic),
          inactiveLabelStyle: TextStyle(
              color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
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
          onChanged: (SfRangeValues newValues) async{
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
