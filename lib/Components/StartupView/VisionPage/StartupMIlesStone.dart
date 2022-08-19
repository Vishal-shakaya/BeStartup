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
          dy_height: MediaQuery.of(context).size.height * 0.02);

      final title = MiltTitleTab(title: el['title']);

      mile_title.add(title);
      mile_desc.add(desc);
    });


    return Container(
      width: context.width * 0.55,
      height: context.height * 0.45,
      margin: EdgeInsets.only(bottom: 50, top: 10),
     
      child: TabContainer(
          childPadding: EdgeInsets.all(50),
          controller: _controller,
          color: Colors.orange.shade200,
          tabEdge: TabEdge.left,
          tabExtent: MediaQuery.of(context).size.width * 0.15,
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
              fontSize: 16,
              fontWeight: FontWeight.w600)),
      style: Get.textTheme.headline2,
    );
  }




// MILESTONE DESCRIPTION COLUMN :
// 1 REQUIRED PARAM :  TITLE AND DESCRIPTION ,
  Container MileDescriptionSection({context, description, title, dy_height}) {
    return Container(
      alignment: Alignment.topCenter,
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
                      fontSize: 15,
                      height: 1.5)),
              style: Get.textTheme.headline2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      
      
          AutoSizeText.rich(
            TextSpan(
                text: description,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(),
                    color: light_color_type1,
                    fontSize: 13,
                    height: 1.8,
                    wordSpacing: 2)),
            style: Get.textTheme.headline2,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
