import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/DetailViewState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/VisionPage/StartupMIlesStone.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionPage extends StatefulWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
  var detailViewState = Get.put(StartupDetailViewState());
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  var final_data;
  double page_width = 0.80;
  var startup_id;

  EditVision() {
    Get.toNamed(create_business_vision_url, parameters: {'type': 'update'});
  }

  EditMilestone() {
    Get.toNamed(create_business_milestone_url, parameters: {'type': 'update'});
  }

  //////////////////////////////////
  // GET REQUIREMENTS :
  //////////////////////////////////
  GetLocalStorageData() async {
    startup_id = await detailViewState.GetStartupId();
    try {
      final vision =
          await startupConnect.FetchBusinessVision(startup_id: startup_id);
      final_data = vision['data']['vision'];

      return final_data;
    } catch (e) {
      return final_data;
    }
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////
    // SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Startup Vision',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }


//////////////////////////////////////////
/// Main Method : 
//////////////////////////////////////////
  Container MainMethod(BuildContext context) {
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
                
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  )),
                 
                 
                  child: Container(
                      width: context.width * 0.45,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: border_color),
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15))),
                    
                    
                      child: AutoSizeText.rich(
                        TextSpan(
                            text: final_data,
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(),
                                color: light_color_type3,
                                fontSize: 15,
                                height: 1.8,
                                fontWeight: FontWeight.w600)),
                        style: Get.textTheme.headline2,
                        maxLines: 18,
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
