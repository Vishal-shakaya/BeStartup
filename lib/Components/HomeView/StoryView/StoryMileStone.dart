import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/HomeView/StoryView/MileTitleList.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tab_container/tab_container.dart';

class StoryMileStone extends StatelessWidget {
  var founder_id;
  var startup_id;
  StoryMileStone({required this.founder_id, required this.startup_id});

  late final TabContainerController _controller;
  List<Widget> mile_title = [];
  List<Widget> mile_desc = [];
  var mile_title_text = [];
  var miles_data = [];

  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  double mile_width = 0.40;
  double mile_height = 0.24;

  double desc_sec_height = 0.02;

  double tab_extend = 0.10;
  double tab_cont_child_padding = 30;

  double mile_tab_fontSize = 13;

  double mile_desc_title_fontSize = 14;
  double mile_desc_title_ext_height = 1.6;

  double mile_desc_fontSize = 13;
  double mile_desc_text_height = 1.6;

  double mile_top_margin = 0;

  int? maxlines = 5;

  @override
  Widget build(BuildContext context) {
    mile_top_margin = 0;
    mile_width = 0.40;
    mile_height = 0.24;

    desc_sec_height = 0.02;

    tab_extend = 0.10;
    tab_cont_child_padding = 30;

    mile_tab_fontSize = 13;

    mile_desc_title_fontSize = 14;
    mile_desc_title_ext_height = 1.6;

    mile_desc_fontSize = 13;
    mile_desc_text_height = 1.6;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      mile_top_margin = 0;

      mile_width = 0.40;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.10;
      tab_cont_child_padding = 30;

      mile_tab_fontSize = 13;

      mile_desc_title_fontSize = 14;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 13;
      mile_desc_text_height = 1.6;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      mile_width = 0.45;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.10;
      tab_cont_child_padding = 30;

      mile_tab_fontSize = 13;

      mile_desc_title_fontSize = 14;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 13;
      mile_desc_text_height = 1.6;
      print('1500');
    }

    if (context.width < 1400) {
      mile_width = 0.50;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.10;
      tab_cont_child_padding = 30;

      mile_tab_fontSize = 13;

      mile_desc_title_fontSize = 14;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 13;
      mile_desc_text_height = 1.6;
      print('1400');
    }

    if (context.width < 1200) {
      mile_width = 0.55;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.10;
      tab_cont_child_padding = 30;

      mile_tab_fontSize = 13;

      mile_desc_title_fontSize = 14;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 13;
      mile_desc_text_height = 1.6;
      print('1200');
    }

    if (context.width < 1000) {
      mile_width = 0.64;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.13;
      tab_cont_child_padding = 30;

      mile_tab_fontSize = 13;

      mile_desc_title_fontSize = 13;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 12;
      mile_desc_text_height = 1.6;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      mile_top_margin = 5;
      mile_width = 0.80;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.16;
      tab_cont_child_padding = 25;

      mile_tab_fontSize = 12;

      mile_desc_title_fontSize = 13;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 12;
      mile_desc_text_height = 1.6;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      mile_top_margin = 8;
      mile_width = 0.85;
      mile_height = 0.24;

      desc_sec_height = 0.02;

      tab_extend = 0.17;
      tab_cont_child_padding = 25;

      mile_tab_fontSize = 12;

      mile_desc_title_fontSize = 13;
      mile_desc_title_ext_height = 1.6;

      mile_desc_fontSize = 12;
      mile_desc_text_height = 1.6;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
        mile_top_margin = 8;
        mile_width = 0.85;
        mile_height = 0.24;

        desc_sec_height = 0.02;

        tab_extend = 0.17;
        tab_cont_child_padding = 25;

        mile_tab_fontSize = 12;

        mile_desc_title_fontSize = 13;
        mile_desc_title_ext_height = 1.6;

        mile_desc_fontSize = 12;
        mile_desc_text_height = 1.6;


      print('480');
    }

    /////////////////////////////////////
    /// GET REQUIREMENTS ;
    /////////////////////////////////////
    GetLocalStorageData() async {
      try {
        final miles =
            await startupConnect.FetchBusinessMilestone(startup_id: startup_id);
        miles_data = miles['data']['milestone'];
        return miles_data;
      } catch (e) {
        return miles_data;
      }
    }

    /////////////////////////////////////
    /// SET  REQUIREMENTS ;
    /////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading MileStones',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
              context,
            );
          }
          return MainMethod(
            context,
          );
        });
  }

  Container MainMethod(BuildContext context) {
    // NULL CHECK :
    if (miles_data == [] || miles_data.isEmpty) {
      return Container(
        width: context.width * mile_width,
        height: context.height * mile_height,
      );
    }

    _controller = TabContainerController(length: miles_data.length);

    miles_data.forEach((el) {
      final desc = MileDescriptionSection(
          context: context,
          description: long_string,
          title: el['description'],
          dy_height: MediaQuery.of(context).size.height * desc_sec_height);

      final title = MiltTitleTab(title: el['title']);

      mile_title.add(title);
      mile_desc.add(desc);
      mile_title_text.add(el['title']);
    });

    // Build Milestone ListView :
    Container smallMilestone = Container(
      height: context.height * mile_height,
      child: ListView.builder(
          itemCount: mile_title_text.length,
          itemBuilder: (context, index) {
            return MileTitleList(
              milestone: mile_title_text[index],
            );
          }),
    );

    Container bigMilestone = Container(
      width: context.width * mile_width,
      height: context.height * mile_height,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(top: mile_top_margin),
      child: TabContainer(
        childPadding: EdgeInsets.all(tab_cont_child_padding),
        controller: _controller,
        color: Colors.orange.shade200,
        tabEdge: TabEdge.left,
        tabExtent: context.width * tab_extend,
        children: mile_desc,
        tabs: mile_title,
      ),
    );



    if (context.width < 640) {
      return smallMilestone;
    } else {
      return bigMilestone;
    }
  }



// MILESTONE SIDE BAR TITLE TAB  :
// REQUIRED PARAM : Title
  Container MiltTitleTab({title}) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      alignment: Alignment.center,
      child: AutoSizeText.rich(
        TextSpan(
            text: title.toString().capitalizeFirst,
            style: GoogleFonts.robotoSlab(
              textStyle: TextStyle(),
              color: mile_text_color,
              fontSize: mile_tab_fontSize,
            )),
        style: Get.textTheme.headline2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
    );
  }

// MILESTONE DESCRIPTION COLUMN :
// 1 REQUIRED PARAM :  TITLE AND DESCRIPTION ,
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
                        color: mile_text_color,
                        fontSize: mile_desc_title_fontSize,
                        height: mile_desc_title_ext_height)),
                style: Get.textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                  text: description,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: mile_text_color,
                      fontSize: mile_desc_fontSize,
                      height: mile_desc_text_height,
                      wordSpacing: 2)),
              style: Get.textTheme.headline2,

              // textAlign: TextAlign.center,
              maxLines: maxlines,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
