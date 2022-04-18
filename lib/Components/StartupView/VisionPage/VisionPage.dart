import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/VisionPage/StartupMIlesStone.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionPage extends StatelessWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;

    EditVision() {
      Get.toNamed(create_business_vision_url);
    }

    EditMilestone() {
      Get.toNamed(create_business_milestone_url);
    }

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
              StartupHeaderText(title: 'Vision',font_size: 30,),
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
                            text: long_string,
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
                height: context.height*0.02,
              ),
              StartupHeaderText(title: 'MileStone',font_size: 30,),
              SizedBox(
                height: context.height*0.02,
              ),

              // EDIT MILESTONE BUTTON: 
              EditButton(context, EditMilestone),

              SizedBox(
                height: context.height*0.02,
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
