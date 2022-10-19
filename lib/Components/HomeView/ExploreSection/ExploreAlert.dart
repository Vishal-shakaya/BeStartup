import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/YearRangeSelector.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:google_fonts/google_fonts.dart';
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

  double explore_box_width = 0.35;
  double explore_box_height = 0.40;

  double divider_width = 0.03;

  double spacing = 0.01;

  double top_selector_spacing = 8;

  double label_heading = 15; 

  double detail_chip_divider = 0.03;
  double detail_chip_spacing = 0.01;
  double detail_selector_spacing = 8;

  double con_btn_top_margin = 40;
  double submit_btn_bottom_margin = 20;
  double submit_btn_fontSize = 16;

  double label_fontSize = 13; 
  double selected_label_fontSize = 12; 

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
    header_sec_width = 0.50;
    header_sec_height = 0.30;

    con_button_width = 80;
    con_button_height = 40;

    explore_box_width = 0.35;
    explore_box_height = 0.45;

    divider_width = 0.03;

    spacing = 0.01;

    label_heading = 15; 
    
    top_selector_spacing = 8;

    detail_chip_divider = 0.03;
    detail_chip_spacing = 0.01;
    detail_selector_spacing = 8;

    con_btn_top_margin = 40;
    submit_btn_bottom_margin = 20;
    submit_btn_fontSize = 16;

     label_fontSize = 13; 
     selected_label_fontSize = 12;

    // DEFAULT :
    if (context.width > 1700) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.35;
      explore_box_height = 0.45;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 15; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 20;
      submit_btn_fontSize = 16;
      con_button_width = 80;
      con_button_height = 40;

      label_fontSize = 13; 
      selected_label_fontSize = 12;

      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.40;
      explore_box_height = 0.45;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 15; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 20;
      submit_btn_fontSize = 16;
      con_button_width = 80;
      con_button_height = 40;

      label_fontSize = 13; 
      selected_label_fontSize = 12;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.50;
      explore_box_height = 0.50;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 15; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 20;
      submit_btn_fontSize = 16;
      con_button_width = 80;
      con_button_height = 40;

      label_fontSize = 13; 
      selected_label_fontSize = 12;
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.60;
      explore_box_height = 0.50;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 15; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 20;
      submit_btn_fontSize = 16;
      con_button_width = 80;
      con_button_height = 40;

      label_fontSize = 13; 
      selected_label_fontSize = 12;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.70;
      explore_box_height = 0.50;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 15; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 20;
      submit_btn_fontSize = 14;
      con_button_width = 80;
      con_button_height = 35;

      label_fontSize = 13; 
      selected_label_fontSize = 12;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.80;
      explore_box_height = 0.48;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 8;

      label_heading = 14; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 15;
      submit_btn_fontSize = 13;
      con_button_width = 80;
      con_button_height = 30;

      label_fontSize = 12; 
      selected_label_fontSize = 11;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      header_sec_width = 0.50;
      header_sec_height = 0.30;

      explore_box_width = 0.95;
      explore_box_height = 0.55;

      divider_width = 0.03;

      spacing = 0.01;

      top_selector_spacing = 8;

      detail_chip_divider = 0.03;
      detail_chip_spacing = 0.01;
      detail_selector_spacing = 9;

      label_heading = 14; 

      con_btn_top_margin = 40;
      submit_btn_bottom_margin = 15;
      submit_btn_fontSize = 13;
      con_button_width = 80;
      con_button_height = 30;

      label_fontSize = 10; 
      selected_label_fontSize = 9;
      print('480');
    }

    return SizedBox(
      width: context.width * explore_box_width,
      height: context.height * explore_box_height,
      
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
              CustomDivider(context, divider_width),

              // SPACING:
              SizedBox(
                height: context.height * spacing,
              ),

              // TOP SELECTOR:
              MultiSelectContainer(
                  wrapSettings: WrapSettings(spacing: top_selector_spacing),
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
                    TopicChip('Indian'),
                    TopicChip('Latest'),
                    TopicChip('Trending'),
                    TopicChip('MostLike'),
                    TopicChip('Popular'),
                  ],
                  onChange: (allSelectedItems, selectedItem) {
                    catigories.add(selectedItem);
                  }),

              // CUSTOME DIVIDER (In Method):
              CustomDivider(context, detail_chip_spacing),

              // SPACING:
              SizedBox(
                height: context.height * detail_chip_spacing,
              ),

              // ALL TOPICS :
              MultiSelectContainer(
                alignments:const MultiSelectAlignments(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center),
                  
                  wrapSettings: WrapSettings(spacing: top_selector_spacing),
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
                    TopicChip('AI'),
                    TopicChip('IOT'),
                    TopicChip('Tech'),
                    TopicChip('Data Science'),
                    TopicChip('Cyber Security'),
                    TopicChip('Cloud Computing.'),
                    TopicChip('B2B'),
                    TopicChip('Health'),
                    TopicChip('Agriculture'),
                    TopicChip('Economy'),
                    TopicChip('Biotechnology'),
                    TopicChip('Textile'),
                    TopicChip('Data Analytics'),
                  ],
                  onChange: (allSelectedItems, selectedItem) {
                    catigories.add(selectedItem);
                  }),

              // SUBMIT BUTTON :
              // 1 GET DATE RANGE  ,
              // 2 TOP AND OTHER CATIGORIES :
              Container(
                margin: EdgeInsets.only(
                    top: con_btn_top_margin, bottom: submit_btn_bottom_margin),
                child: InkWell(
                  highlightColor: primary_light_hover,
                  borderRadius: const BorderRadius.horizontal(
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
                      child: Text(
                        'Done',
                        style: TextStyle(
                            letterSpacing: 2.5,
                            color: Colors.white,
                            fontSize: submit_btn_fontSize,
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
              style:  GoogleFonts.merriweather(
              color: input_text_color,
              fontSize: label_heading ,
              fontWeight: FontWeight.w600,
            )
      )),);
  }

  MultiSelectCard<String> TopicChip(String label) {
    return MultiSelectCard(
      value: label,
      label: label,
      textStyles: MultiSelectItemTextStyles (
        selectedTextStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: light_color_type1,
            fontSize: selected_label_fontSize,
            fontWeight: FontWeight.w600,
          ), 
            
          textStyle: GoogleFonts.robotoSlab(
              textStyle: TextStyle(),
              color: input_text_color,
              fontSize: label_fontSize ,
              fontWeight: FontWeight.w600,
            )
      )
    );
  }
}
