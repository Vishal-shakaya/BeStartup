import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessCatigoryStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CatigoryChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CustomInputChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/RemovableChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:be_startup/Utils/Messages.dart';
// import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CatigoryBody extends StatefulWidget {
  CatigoryBody({Key? key}) : super(key: key);

  @override
  State<CatigoryBody> createState() => _CatigoryBodyState();
}

double vision_cont_width = 0.60;
double vision_cont_height = 0.70;
double vision_subheading_text = 20;
var catigoryStore = Get.put(BusinessCatigoryStore(), tag: 'catigory_store');
var startupConnector =
    Get.put(StartupViewConnector(), tag: 'startup_connector');

class _CatigoryBodyState extends State<CatigoryBody> {
  @override
  Widget build(BuildContext context) {
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    var is_selected = false;
    List<CatigoryChip> catigory_list = [];
    List<RemovableChip> default_catigory_chip = [];
    var default_catigory;
    // DEFAULT :
    if (context.width > 1500) {
      vision_cont_height = 0.70;
      vision_cont_width = 0.60;
      vision_subheading_text = 20;
    }
    if (context.width < 1500) {
      vision_cont_height = 0.70;
      vision_cont_width = 0.75;
      vision_subheading_text = 20;
    }

    // PC:
    if (context.width < 1200) {
      vision_cont_width = 0.80;
      vision_subheading_text = 20;
    }

    if (context.width < 1000) {
      vision_cont_width = 0.85;
      vision_subheading_text = 20;
    }

    // TABLET :
    if (context.width < 800) {
      vision_cont_width = 0.80;
      vision_subheading_text = 20;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      vision_cont_width = 0.70;
      vision_subheading_text = 18;
    }

    // PHONE:
    if (context.width < 480) {
      vision_cont_width = 0.99;
      vision_subheading_text = 16;
    }

    // SHOW LOADING SPINNER :
    StartLoading() {
      var dialog = SmartDialog.showLoading(
          background: Colors.white,
          maskColorTemp: Color.fromARGB(146, 252, 250, 250),
          widget: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ));
      return dialog;
    }

    // End Loading
    EndLoading() async {
      SmartDialog.dismiss();
    }

    // SUBMIT CATIGORY :
    SubmitCatigory() async {
      StartLoading();
      var resp = await catigoryStore.PersistCatigory();
      print(resp);
      if (resp == false) {
        EndLoading();

        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(width: snack_width));
      }
      EndLoading();
    }

    SetDefaultCatigory(List default_catigory) async {
      // Set Default Catigory Chip:
      business_catigories.forEach((cat) async {
        if (default_catigory.contains(cat)) {
          is_selected = true;
        } else {
          is_selected = false;
        }

        catigory_list.add(CatigoryChip(
          key: UniqueKey(),
          catigory: cat,
          is_selected: is_selected,
        ));
      });
    }

    // INITILIZE DEFAULT STATE :
// GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        final resp = await startupConnector.FetchBusinessCatigory();
        // Success Handler :
        if (resp['response']) {
          print(resp['message']);
          default_catigory = await catigoryStore.GetCatigory();
          await SetDefaultCatigory(default_catigory);
        }

        // Error Handler :
        if (!resp['response']) {
          Get.closeAllSnackbars();
          Get.showSnackbar(
              MyCustSnackbar(
                width: snack_width,
                message: resp['message']));
        }
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
                'Loading Catigory Section',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
                context, catigory_list, default_catigory, SubmitCatigory);
          }
          return MainMethod(
              context, catigory_list, default_catigory, SubmitCatigory);
        });
  }

  Column MainMethod(BuildContext context, List<CatigoryChip> catigory_list,
      List default_catigory, Future<Null> SubmitCatigory()) {
    return Column(
      children: [
        Container(
            width: context.width * vision_cont_width,
            height: context.height * vision_cont_height,
            child: Column(
              children: [
                // SUBHEADING TEXT :
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.05),
                  child: AutoSizeText.rich(
                      TextSpan(style: context.textTheme.headline2, children: [
                    TextSpan(
                        text: catigory_subHeading_text,
                        style: TextStyle(
                            color: light_color_type3,
                            fontSize: vision_subheading_text))
                  ])),
                ),

                //////////////////////////////////////////
                // CATIGORY SELECT SECTION :
                // DISPLAY DEFAULT CATIGORIES CHIPS :
                //////////////////////////////////////////
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.05),
                  child: Wrap(
                    spacing: 2,
                    alignment: WrapAlignment.center,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    children: catigory_list,
                  ),
                ),

                ///////////////////////////////////////////////////
                // INPUT CHIP TO GET CUSTOME BUSINESS CATIGORY :
                // ADD CUSTOM BUSINESS CATIGORIES :
                // 1 TAKE INPUT AND CONVERT IN TO CHIP
                ///////////////////////////////////////////////////
                CustomInputChip(
                  key: UniqueKey(),
                  defualt_custom_chip: default_catigory,
                )
              ],
            )),
        BusinessSlideNav(
          slide: SlideType.catigory,
          submitform: SubmitCatigory,
        )
      ],
    );
  }
}
