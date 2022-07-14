import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
import 'package:be_startup/Backend/Startup/connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
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
  @override
  Widget build(BuildContext context) {
    var startupConnect =
        Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

    var visionStore = Get.put(BusinessVisionStore(), tag: 'vision_store');

    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      final startup_id = await getStartupDetailViewId;
      try {
        final resp = await startupConnect.FetchBusinessVision(
          startup_id: startup_id
        );

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
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: MainMethod(context),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    return Container(
      width: context.width * 0.50,
      height: context.height * 0.42,
      child: Column(
        children: [
          // HEADING :
          StartupHeaderText(
            title: 'Vision',
            font_size: 32,
          ),
          SizedBox(
            height: 15,
          ),
          // VISION TEXT:
          ClipPath(
            child: Card(
              elevation: 1,
              shadowColor: shadow_color1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              )),
              child: Container(
                  width: context.width * 0.45,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: border_color),
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15))),
                  child: AutoSizeText.rich(
                    TextSpan(
                        text: vision_text,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(),
                            color: light_color_type3,
                            fontSize: 15,
                            height: 1.8,
                            fontWeight: FontWeight.w600)),
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.headline2,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
