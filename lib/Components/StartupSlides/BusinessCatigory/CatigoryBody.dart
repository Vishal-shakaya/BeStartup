import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessCatigoryStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CatigoryChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CustomInputChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/RemovableChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
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

class _CatigoryBodyState extends State<CatigoryBody> {
  var catigoryStore = Get.put(BusinessCatigoryStore(), tag: 'catigory_store');
  var startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');

  List<CatigoryChip> catigory_list = [];
  List<RemovableChip> default_catigory_chip = [];

  var default_catigory;
  var is_selected = false;
  var my_context = Get.context;

  double vision_cont_width = 0.60;
  double vision_cont_height = 0.70;
  double vision_subheading_text = 20;

// Update   params :
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;

//////////////////////////////////
// SUBMIT CATIGORY FORM :
//////////////////////////////////
  SubmitCatigory() async {
    MyCustPageLoadingSpinner();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var resp = await catigoryStore.PersistCatigory();
    print(resp); // Test

    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(width: snack_width));
    }

    CloseCustomPageLoadingSpinner();
  }

  ///////////////////////////////////////////////////
  /// UPDATE CATIGORIES :
  /// It's a function that updates a catigory ,
  /// in a database.
  ///////////////////////////////////////////////////
  UpdateCatigory() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var resp = await catigoryStore.PersistCatigory();
    var resp1 = updateStore.UpdateBusinessCatigory(); // Test

    // Success Handler :
    if (resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.toNamed(home_page_url);
    }

    // Error Handler :
    if (!resp1['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(width: snack_width));
    }

    CloseCustomPageLoadingSpinner();
  }

////////////////////////////////////////
  /// SET DEFAULT CATIGORIES
////////////////////////////////////////

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

  ///////////////////////////////////
  // SET APP DEFAULT STATE :
  ///////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    pageParam = Get.parameters;
    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    /////////////////////////////////////
    // GET REQUIREMETNS :
    /////////////////////////////////////
    GetLocalStorageData() async {
      var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
      var erro_resp;
      try {
        if(updateMode==true){
          final resp = await startupConnector.FetchBusinessCatigory();
          print(resp['message']);
        }
        
        default_catigory = await catigoryStore.GetCatigory();
        erro_resp = default_catigory;
        await SetDefaultCatigory(default_catigory);

        // Update local catigory storage :
        default_catigory.forEach((el) async {
          await catigoryStore.SetTempCatigory(cat: el);
        });
      } catch (e) {
        return erro_resp;
      }
    }

    ///////////////////////////////////////////
    /// SET REQUIREMENTS :
    ///////////////////////////////////////////
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
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

//////////////////////////////////
  /// MAIN METHOD :
//////////////////////////////////
  Column MainMethod(
    BuildContext context,
  ) {
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
        updateMode == true
            ? UpdateButton(context)
            : BusinessSlideNav(
                slide: SlideType.catigory,
                submitform: SubmitCatigory,
              )
      ],
    );
  }

  //////////////////////////////////////////
  /// External Methods:
  ///////////////////////////////////////////
  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdateCatigory();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Update',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
