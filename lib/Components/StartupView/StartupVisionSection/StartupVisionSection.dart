import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class StartupVisionSection extends StatefulWidget {
  const StartupVisionSection({Key? key}) : super(key: key);

  @override
  State<StartupVisionSection> createState() => _StartupVisionSectionState();
}

class _StartupVisionSectionState extends State<StartupVisionSection> {
  var vision_text;
  var visionStore = Get.put(BusinessVisionStore(), tag: 'vision_store');
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  double vision_section_width = 0.50;

  double vision_section_height = 0.43;

  double header_fontSize = 32;

  double vision_text_top_space = 0.04;

  double vision_sec_elevation = 1;

  double vision_sec_radius = 15;

  double vision_cont_width = 0.45;

  double vision_cont_height = 0.27; 

  double vision_cont_padding = 20;

  double vision_cont_radius = 15;

  double vision_text_fontSize = 15;

  double vision_text_height = 1.8;

  int vison_text_maxlines = 8;

  @override
  Widget build(BuildContext context) {
    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      var detailViewState = Get.put(StartupDetailViewState());
      final startup_id = await detailViewState.GetStartupId();
      final user_id = await detailViewState.GetFounderId();

      try {
        final resp =
            await startupConnect.FetchBusinessVision(user_id: user_id);
        vision_text = resp['data']['vision'];

        return vision_text;
      } catch (e) {
        return '';
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MileStoneShimmer(context);
          }

          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }

          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    vision_section_width = 0.50;

    vision_section_height = 0.43;

    header_fontSize = 32;

    vision_text_top_space = 0.04;

    vision_sec_elevation = 1;

    vision_sec_radius = 15;

    vision_cont_width = 0.45;

    vision_cont_padding = 20;

    vision_cont_radius = 15;

    vision_text_fontSize = 15;

    vision_text_height = 1.8;

    vison_text_maxlines = 8;

     vision_cont_height = 0.27; 
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1700) {
      vision_section_width = 0.50;

      vision_section_height = 0.43;

      header_fontSize = 32;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.45;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 15;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      
      vision_cont_height = 0.27; 
      print('Greator then 1700');
    }

    if (context.width < 1700) {
       vision_section_width = 0.50;

      vision_section_height = 0.43;

      vision_cont_height = 0.28; 

      header_fontSize = 32;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.50;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 15;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('1700');
    }

    if (context.width < 1600) {
      vision_section_width = 0.50;

      vision_section_height = 0.43;

      header_fontSize = 32;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.50;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 15;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      vision_section_width = 0.60;

      vision_section_height = 0.44;

      header_fontSize = 32;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.55;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 15;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('1500');
    }

    if (context.width < 1300) {
      vision_section_width = 0.65;

      vision_section_height = 0.43;

      header_fontSize = 30;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.60;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 14;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('1300');
    }

    if (context.width < 1200) {
      vision_section_width = 0.65;

      vision_section_height = 0.43;

      header_fontSize = 30;

      vision_text_top_space = 0.04;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.62;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 14;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('1200');
    }

    if (context.width < 1000) {
      vision_section_width = 0.80;

      vision_cont_height = 0.25; 

      vision_section_height = 0.43;

      header_fontSize = 30;

      vision_text_top_space = 0.03;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.80;

      vision_cont_padding = 20;

      vision_cont_radius = 15;

      vision_text_fontSize = 14;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;

      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      vision_section_width = 0.80;

      vision_cont_height = 0.25; 

      vision_section_height = 0.43;

      header_fontSize = 28;

      vision_text_top_space = 0.03;

      vision_sec_elevation = 1;

      vision_sec_radius = 15;

      vision_cont_width = 0.80;

      vision_cont_padding = 15;

      vision_cont_radius = 15;

      vision_text_fontSize = 13;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      vision_section_width = 0.90;

      vision_section_height = 0.43;
      
      vision_cont_height = 0.27; 


      header_fontSize = 28;

      vision_text_top_space = 0.03;

      vision_sec_elevation = 1;

      vision_sec_radius = 10;

      vision_cont_width = 0.90;

      vision_cont_padding = 15;

      vision_cont_radius = 15;

      vision_text_fontSize = 13;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      vision_section_width = 0.99;

      vision_section_height = 0.45;

      vision_cont_height = 0.29; 


      header_fontSize = 25;

      vision_text_top_space = 0.03;

      vision_sec_elevation = 0;

      vision_sec_radius = 10;

      vision_cont_width = 0.99;

      vision_cont_padding = 18;

      vision_cont_radius = 15;

      vision_text_fontSize = 12;

      vision_text_height = 1.8;

      vison_text_maxlines = 8;
      print('480');
    }

    return Container(
      width: context.width * vision_section_width,
      height: context.height * vision_section_height,
    
      child: Column(
        children: [
          // HEADING :
          StartupHeaderText(
            title: 'Vision',
            font_size: header_fontSize,
          ),

          SizedBox(
            height: context.height*vision_text_top_space,
          ),

          // VISION TEXT:
          ClipPath(
            child: Card(
              color: my_theme_background_color,
              elevation: 1,
              shadowColor: startup_container_border_color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(vision_sec_radius),
                right: Radius.circular(vision_sec_radius),
              )),
             
              child: Container(
                  width: context.width * vision_cont_width,
                  height: context.height * vision_cont_height,

                  padding: EdgeInsets.all(vision_cont_padding),
                  decoration: BoxDecoration(
                      border: Border.all(color: startup_container_border_color),
                      borderRadius: BorderRadius.horizontal(
                        
                          left: Radius.circular(vision_cont_radius),
                          right: Radius.circular(vision_cont_radius))),
                  child: SingleChildScrollView(
                    child:Text(
                      vision_text??'',
                      style:GoogleFonts.openSans(
                          textStyle: TextStyle(),
                          color: startup_text_color,
                          fontSize: vision_text_fontSize,
                          height: vision_text_height,
                          fontWeight: FontWeight.w500),
                      maxLines: vison_text_maxlines,
                      overflow: TextOverflow.ellipsis )
                  )),
            ),
          )
        ],
      ),
    );
  }

  Center MileStoneShimmer(BuildContext context) {
    return Center(
        child: Shimmer.fromColors(
      baseColor: shimmer_base_color,
      highlightColor: shimmer_highlight_color,
      child: MainMethod(context),
    ));
  }
}
