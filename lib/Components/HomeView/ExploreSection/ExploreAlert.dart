import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/YearRangeSelector.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ExploreCatigoryAlert extends StatefulWidget {
  var changeView;

  ExploreCatigoryAlert({this.changeView, Key? key}) : super(key: key);

  @override
  State<ExploreCatigoryAlert> createState() => _ExploreCatigoryAlertState();
}

class _ExploreCatigoryAlertState extends State<ExploreCatigoryAlert> {
  double header_sec_width = 0.50;
  double header_sec_height = 0.30;

  double con_button_width = 80;
  double con_button_height = 40;
  double con_btn_top_margin = 40;

  SfRangeValues values =
      SfRangeValues(DateTime(2000, 01, 01), DateTime(2022, 01, 01));

  var exploreStore = Get.put(ExploreCatigoryStore(), tag: 'explore_store');


  // SUBMIT DATE AND CATIGORY :
  var catigories = [];
  SubmitExploreCatigory(context) async {
    exploreStore.SetCatigory(catigories);
    
    await widget.changeView(HomePageViews.exploreView);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.35,
      height: context.height * 0.40,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // FIRST ROW MAIN TOPICS (In Method):
              // 1. MAIN TOPICS LIST :
              // 2. YEAR RANGE :
              LabelHeading('Select Period'),

              // DATE PICKER  (Ext Method):
              DateRangePicker(),

              // CUSTOME DIVIDER (IN Method):
              CustomDivider(context, 0.03),

              // SPACING:
              SizedBox(
                height: context.height * 0.01,
              ),
              // TOP SELECTOR:
              MultiSelectContainer(
                  wrapSettings: WrapSettings(spacing: 8),
                  itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey.shade300)),
                      selectedDecoration: BoxDecoration(
                          color: primary_light,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: primary_light))),
                  items: [
                    TopicChip('Latest'),
                    TopicChip('Trending'),
                    TopicChip('MostLike'),
                    TopicChip('Popular'),
                  ],
                  onChange: (allSelectedItems, selectedItem) {
                    catigories.add(selectedItem);
                  }),

              // CUSTOME DIVIDER (In Method):
              CustomDivider(context, 0.03),
              // SPACING:
              SizedBox(
                height: context.height * 0.01,
              ),

              // ALL TOPICS :
              MultiSelectContainer(
                  wrapSettings: WrapSettings(spacing: 8),
                  itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey.shade300)),
                      selectedDecoration: BoxDecoration(
                          color: primary_light,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: primary_light))),
                  items: [
                    TopicChip('Hell'),
                    TopicChip('Dart'),
                    TopicChip('Police'),
                    TopicChip('Hell'),
                    TopicChip('Dart'),
                    TopicChip('Police'),
                    TopicChip('Hell'),
                    TopicChip('Dart'),
                    TopicChip('Police'),
                  ],
                  onChange: (allSelectedItems, selectedItem) {
                    catigories.add(selectedItem);
                  }),

              // SUBMIT BUTTON :
              // 1 GET DATE RANGE  ,
              // 2 TOP AND OTHER CATIGORIES :
              Container(
                margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
                child: InkWell(
                  highlightColor: primary_light_hover,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
                  onTap: () async {
                    await SubmitExploreCatigory(context);
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: light_color_type3,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      width: con_button_width,
                      height: con_button_height,
                      decoration: BoxDecoration(
                          color: primary_light,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20))),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            letterSpacing: 2.5,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Container CustomDivider(BuildContext context, width) {
    return Container(
        margin: EdgeInsets.only(top: context.height * width), child: Divider());
  }

  Container LabelHeading(heading) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.topCenter,
        child: AutoSizeText.rich(
          TextSpan(
              text: heading,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              )),
        ));
  }

  MultiSelectCard<String> TopicChip(String label) {
    return MultiSelectCard(
      value: label,
      label: label,
    );
  }
}
