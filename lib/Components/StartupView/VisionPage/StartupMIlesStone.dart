import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_container/tab_container.dart';

class StartupMileStone extends StatefulWidget {
  const StartupMileStone({Key? key}) : super(key: key);

  @override
  State<StartupMileStone> createState() => _StartupMileStoneState();
}

class _StartupMileStoneState extends State<StartupMileStone> {
  late final TabContainerController _controller;
  var detailViewState = Get.put(StartupDetailViewState());
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  var miles_data = [];
  var startup_id;

  double mile_desc_fontSize = 15;
  double mile_desc_height = 1.5;

  double mile_desc_detail_fontSize = 13;
  double mile_desc_detail_height = 1.8;
  double mile_desc_detail_wordspacing = 2;
  double mile_desc_top_margin = 0.02;

  double mile_sec_width = 0.55;
  double mile_sec_height = 0.45;

  double mile_sec_top_margin = 10;
  double mile_sec_bottom_margin = 50;

  double mile_cont_padding = 50;
  double tab_extend_width = 0.15;

  double mile_tab_fontSize = 16; 
/////////////////////////////////////
  /// GET REQUIREMENTS ;
/////////////////////////////////////
  GetLocalStorageData() async {
    startup_id = await detailViewState.GetStartupId();

    try {
      final miles =
          await startupConnect.FetchBusinessMilestone(startup_id: startup_id);
      miles_data = miles['data']['milestone'];

      return miles_data;
    } catch (e) {
      return miles_data;
    }
  }

  @override
  Widget build(BuildContext context) {
     mile_desc_fontSize = 15;
     mile_desc_height = 1.5;

     mile_desc_detail_fontSize = 13;
     mile_desc_detail_height = 1.8;
     mile_desc_detail_wordspacing = 2;
     mile_desc_top_margin = 0.02;

     mile_sec_width = 0.55;
     mile_sec_height = 0.45;

     mile_sec_top_margin = 10;
     mile_sec_bottom_margin = 50;

     mile_cont_padding = 50;
     tab_extend_width = 0.15;

     mile_tab_fontSize = 16; 
    ////////////////////////////////////
    /// RESPONSIVENESS : 
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
      }

    if (context.width < 1700) {
      print('1700');
      }

  		// DEFAULT :
    if (context.width < 1600) {
        mile_desc_fontSize = 15;
        mile_desc_height = 1.5;

        mile_desc_detail_fontSize = 13;
        mile_desc_detail_height = 1.8;
        mile_desc_detail_wordspacing = 2;
        mile_desc_top_margin = 0.02;

        mile_sec_width = 0.60;
        mile_sec_height = 0.45;

        mile_sec_top_margin = 10;
        mile_sec_bottom_margin = 50;

        mile_cont_padding = 30;
        tab_extend_width = 0.15;

        mile_tab_fontSize = 15; 
        print('1600');
      }

    // PC:
    if (context.width < 1500) {
        mile_desc_fontSize = 14;
        mile_desc_height = 1.8;

        mile_desc_detail_fontSize = 13;
        mile_desc_detail_height = 1.8;
        mile_desc_detail_wordspacing = 2;
        mile_desc_top_margin = 0.02;

        mile_sec_width = 0.68;
        mile_sec_height = 0.45;

        mile_sec_top_margin = 10;
        mile_sec_bottom_margin = 50;

        mile_cont_padding = 30;
        tab_extend_width = 0.16;

        mile_tab_fontSize = 14; 
      print('1500');
      }

    if (context.width < 1200) {
        mile_desc_fontSize = 14;
        mile_desc_height = 1.8;

        mile_desc_detail_fontSize = 13;
        mile_desc_detail_height = 1.8;
        mile_desc_detail_wordspacing = 2;
        mile_desc_top_margin = 0.02;

        mile_sec_width = 0.90;
        mile_sec_height = 0.45;

        mile_sec_top_margin = 10;
        mile_sec_bottom_margin = 50;

        mile_cont_padding = 30;
        tab_extend_width = 0.20;

        mile_tab_fontSize = 14; 
      print('1200');
      }
    
    if (context.width < 1000) {
      print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        mile_desc_fontSize = 13;
        mile_desc_height = 1.8;

        mile_desc_detail_fontSize = 12;
        mile_desc_detail_height = 1.8;
        mile_desc_detail_wordspacing = 2;
        mile_desc_top_margin = 0.02;

        mile_sec_width = 0.90;
        mile_sec_height = 0.45;

        mile_sec_top_margin = 10;
        mile_sec_bottom_margin = 50;

        mile_cont_padding = 28;
        tab_extend_width = 0.25;

        mile_tab_fontSize = 13; 
      print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
        mile_desc_fontSize = 13;
        mile_desc_height = 1.8;

        mile_desc_detail_fontSize = 12;
        mile_desc_detail_height = 1.8;
        mile_desc_detail_wordspacing = 2;
        mile_desc_top_margin = 0.02;

        mile_sec_width = 0.98;
        mile_sec_height = 0.45;

        mile_sec_top_margin = 10;
        mile_sec_bottom_margin = 50;

        mile_cont_padding = 28;
        tab_extend_width = 0.25;

        mile_tab_fontSize = 13; 
      print('480');
      }


    /////////////////////////////////////
    /// SET  REQUIREMENTS ;
    /////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading MileStone Section');
          }

          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }

          return MainMethod(context);
        });
  }

////////////////////////////////////////
  /// Main Method;
////////////////////////////////////////
  Container MainMethod(BuildContext context) {
    List<Widget> mile_title = [];
    List<Widget> mile_desc = [];

    // NULL CHECK :
    if (miles_data == [] || miles_data.length <= 0 || miles_data == null) {
      return Container();
    }

    _controller = TabContainerController(length: miles_data.length);

    miles_data.forEach((el) {
      final desc = MileDescriptionSection(
          context: context,
          description: long_string,
          title: el['description'],
          dy_height: MediaQuery.of(context).size.height * mile_desc_top_margin);

      final title = MiltTitleTab(title: el['title']);

      mile_title.add(title);
      mile_desc.add(desc);
    });

    return Container(
      width: context.width * mile_sec_width,
      height: context.height * mile_sec_height,
      margin: EdgeInsets.only(
          bottom: mile_sec_bottom_margin, top: mile_sec_top_margin),
      child: TabContainer(
          childPadding: EdgeInsets.all(mile_cont_padding),
          controller: _controller,
          color: Colors.orange.shade200,
          tabEdge: TabEdge.left,
          tabExtent: MediaQuery.of(context).size.width * tab_extend_width,
          children: mile_desc,
          tabs: mile_title),
    );
  }

// MILESTONE SIDE BAR TITLE TAB  :
// REQUIRED PARAM : Title
  AutoSizeText MiltTitleTab({title}) {
    return AutoSizeText.rich(
      TextSpan(
          text: title.toString().capitalizeFirst,
          style: GoogleFonts.robotoSlab(
              textStyle: TextStyle(),
              color: light_color_type4,
              fontSize: mile_tab_fontSize,
              fontWeight: FontWeight.w600)),
      style: Get.textTheme.headline2,
    );
  }

/////////////////////////////////////////////////
// MILESTONE DESCRIPTION COLUMN :
// 1 REQUIRED PARAM :  TITLE AND DESCRIPTION ,
/////////////////////////////////////////////////
  Container MileDescriptionSection({context, description, title, dy_height}) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: dy_height),
              child: AutoSizeText.rich(
                TextSpan(
                    text: title.toString().capitalizeFirst,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type1,
                        fontSize: mile_desc_fontSize,
                        height: mile_desc_height)),
               
                style: Get.textTheme.headline2,
                textAlign: TextAlign.left,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                  text: description,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type1,
                      fontSize: mile_desc_detail_fontSize,
                      height: mile_desc_detail_height,
                      wordSpacing: mile_desc_detail_wordspacing)),
              style: Get.textTheme.headline2,
              // textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
