import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/StartupView/StartupViewConnector.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/VisionPage/StartupMIlesStone.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class VisionPage extends StatefulWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
  var final_data; 

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;

    EditVision() {
      Get.toNamed(create_business_vision_url);
    }

    EditMilestone() {
      Get.toNamed(create_business_milestone_url);
    }

    var startupConnect =
        Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        final vision = await startupConnect.FetchBusinessVision();
        // final miles = await startupConnect.FetchBusinessMilestone();
        // final data = {'vision': vision, 'miles': miles};
        final_data = vision ; 
        return vision;
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
              child: Text(
                'Loading Input Section',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, page_width, EditVision, EditMilestone);
          }
          return MainMethod(context, page_width, EditVision, EditMilestone);
        });
  }

  Container MainMethod(BuildContext context, double page_width,
      Null EditVision(), Null EditMilestone()) {
    return Container(
      width: context.width * page_width,
      child: Container(
        width: context.width * 0.50,
        height: context.height * 0.38,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADING :
              SizedBox(
                height: context.height * 0.01,
              ),
              StartupHeaderText(
                title: 'Vision',
                font_size: 30,
              ),
              SizedBox(
                height: context.height * 0.01,
              ),

              // EDIT BUTTON :
              EditButton(context, EditVision),

              SizedBox(
                height: context.height * 0.01,
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
                            text:final_data,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(),
                                color: light_color_type3,
                                fontSize: 16,
                                height: 1.6)),
                        style: Get.textTheme.headline2,
                      )),
                ),
              ),

              SizedBox(
                height: context.height * 0.02,
              ),

              // MILESTONES WIDGET:
              StartupHeaderText(
                title: 'MileStone',
                font_size: 30,
              ),

              SizedBox(
                height: context.height * 0.02,
              ),

              // EDIT MILESTONE BUTTON:
              EditButton(context, EditMilestone),

              SizedBox(
                height: context.height * 0.02,
              ),

              // MILESTONES :
              StartupMileStone()
            ],
          ),
        ),
      ),
    );
  }

  Container EditButton(BuildContext context, Function Edit) {
    return Container(
        width: context.width * 0.45,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: context.height * 0.02),
        child: Container(
          width: 85,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                Edit();
              },
              icon: Icon(
                Icons.edit,
                size: 15,
              ),
              label: Text('Edit')),
        ));
  }
}
