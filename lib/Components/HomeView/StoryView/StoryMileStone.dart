import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
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
  StoryMileStone({
    required this.founder_id, 
    required this.startup_id});

  late final TabContainerController _controller;
  List<Widget> mile_title = [];
  List<Widget> mile_desc = [];
  var miles_data = [];
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');


  @override
  Widget build(BuildContext context) {

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
    if (miles_data == [] || miles_data.length <= 0 || miles_data==null) {
      return Container(
        width: context.width * 0.40,
        height: context.height * 0.24,
      );
    }


    _controller = TabContainerController(length: miles_data.length);
    miles_data.forEach((el) {
      final desc = MileDescriptionSection(
          context: context,
          description: long_string,
          title: el['description'],
          dy_height: MediaQuery.of(context).size.height * 0.02);

      final title = MiltTitleTab(title: el['title']);

      mile_title.add(title);
      mile_desc.add(desc);
    });

    return Container(
      width: context.width * 0.40,
      height: context.height * 0.24,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      child: TabContainer(
          childPadding: EdgeInsets.all(30),
          controller: _controller,
          color: Colors.orange.shade200,
          tabEdge: TabEdge.left,
          tabExtent: context.width * 0.10,
          children: mile_desc,
          tabs: mile_title),
    );
  }


// MILESTONE SIDE BAR TITLE TAB  :
// REQUIRED PARAM : Title
  AutoSizeText MiltTitleTab({title}) {
    return AutoSizeText.rich(
      TextSpan(
          text: title,
          style: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: light_color_type4,
            fontSize: 13,
          )),
      style: Get.textTheme.headline2,
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
                    text: title,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type1,
                        fontSize: 14,
                        height: 1.6)),
                style: Get.textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                  text: description,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type1,
                      fontSize: 13,
                      height: 1.6,
                      wordSpacing: 2)),
              style: Get.textTheme.headline2,
              // textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
