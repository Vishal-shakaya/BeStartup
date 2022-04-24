import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/ExploreAlert.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/YearRangeSelector.dart';
import 'package:be_startup/Components/HomeView/SearhBar/SearchBar.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({Key? key}) : super(key: key);

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  double header_sec_width = 0.60;
  double header_sec_height = 0.20;

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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Explore Topics
    ExploreFunction() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ExploreCatigoryAlert()
            );
          });
    }

    return Container(
      width: context.width * header_sec_width,
      height: context.height * header_sec_height,
      child: Container(
        // 1 ADD EXPLORE BUTTON FOR SELECT CATIGORIES :  
        // 2 ADD SEARCH BAR FOR SEARCH SEPCIFIC STARTUP [ BY CEO NAME , STARTUP NAME ] :
        child: Wrap(
          spacing: 10,
          alignment:WrapAlignment.center ,
          children: [
            // Explore Menu :
            Container(
                margin: EdgeInsets.only(
                  top: context.height * 0.04,
                  right: context.width * 0.03 ),
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: border_color)),
                  child: TextButton.icon(
                      onPressed: () {
                        ExploreFunction();
                      },
                      icon: Icon(
                        Icons.wb_incandescent_sharp,
                        size: 15,
                      ),
                      label: Text('Explore')),
                )),

             // SEARCH BAR :
              BusinessSearchBar()
          ],
        ),
      ),
    );
  }

}
