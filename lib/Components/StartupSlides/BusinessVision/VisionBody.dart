import 'dart:math';

import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class VisionBody extends StatefulWidget {
  VisionBody({Key? key}) : super(key: key);

  @override
  State<VisionBody> createState() => _VisionBodyState();
}

class _VisionBodyState extends State<VisionBody> {
  var startupUpdater = Get.put(StartupUpdater(), tag: 'update_startup');
  var visionStore = Get.put(BusinessVisionStore(), tag: 'vision_store');
  var startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');
  var my_context = Get.context;

  final formKey = GlobalKey<FormBuilderState>();

  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  int vision_cur_len = 1;
  int? vision_max_len = 20;
  bool vision_is_focus = true;

  double vision_cont_width = 0.50;
  double vision_cont_height = 0.70;
  double vision_subheading_text = 20;
  int maxlines = 15;

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;
  String? inital_val = '';



  /////////////////////////////
  /// SUBMIT FORM :
  /////////////////////////////
  SubmitVisionForm() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var vision = formKey.currentState!.value['vision'];
      var res = await visionStore.SetVision(visionText: vision);

      // Success Handler :
      if (res['response']) {
        Get.closeAllSnackbars();
        Get.toNamed(create_business_catigory_url);
      }

      // Error Handler
      if (!res['response']) {
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, message: res['message']));
      }
    }

    // Invalid Form :
    else {
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
      ));
    }
  }



  /////////////////////////////
  /// UPDATE VISION  FORM :
  /////////////////////////////
  UpdatetVisionFrom() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var vision = formKey.currentState!.value['vision'];
      var res = await visionStore.SetVision(visionText: vision);
      var resp = await startupUpdater.UpdatehBusinessVision();
      // Success Handler Cached Data:
      if (res['response']) {

         // Update Success Handler :  
        if(resp['response']){
          Get.closeAllSnackbars();
          Get.toNamed(create_business_catigory_url);
        }

        //  Update Error Handler : 
        if(!resp['response']){
          Get.closeAllSnackbars();
          Get.showSnackbar(
              MyCustSnackbar(width: snack_width, message: res['message']));
        }
      }

      // Error Handler Data : 
      if (!res['response']) {
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, message: res['message']));
      }
    }

    // Invalid Form :
    else {
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
      ));
    }
  }

  
  /////////////////////////////////////
  // SET PAGE DEFAULT STATE : 
  /////////////////////////////////////
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
    if (context.width > 1200) {
      maxlines = 15;
      vision_subheading_text = 20;
      vision_cont_width = 0.50;
      vision_cont_height = 0.70;
    }

    // PC:
    if (context.width < 1200) {
      maxlines = 15;
      vision_subheading_text = 20;
      vision_cont_width = 0.70;
      vision_cont_height = 0.70;
    }

    if (context.width < 1000) {
      maxlines = 15;
      vision_cont_width = 0.70;
      vision_cont_height = 0.70;
    }

    // TABLET :
    if (context.width < 800) {
      maxlines = 15;
      vision_cont_width = 0.80;
      vision_cont_height = 0.70;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      maxlines = 11;
      vision_cont_width = 0.80;
      vision_cont_height = 0.70;
    }

    // PHONE:
    if (context.width < 480) {
      maxlines = 15;
      vision_cont_width = 0.60;
      vision_cont_height = 0.70;
    }



    ////////////////////////////
    // GET REQUIREMENTS : 
    ////////////////////////////
    Future<String?> GetLocalStorageData() async {
      var snack_width = MediaQuery.of(context).size.width * 0.50;
      try {
        final resp = await startupConnector.FetchBusinessVision();
        print(resp['message']);
        // Success Handler :
        if (resp['response']) {
          final data = await visionStore.GetVision();
          inital_val = data;
          return data;
        }

        // Error Handler :
        if (!resp['response']) {
          Get.closeAllSnackbars();
          Get.showSnackbar(MyCustSnackbar(
              width: snack_width,
              message: fetch_data_error_msg,
              title: fetch_data_error_title));
        }
      } catch (e) {
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width, message: e, title: fetch_data_error_title));
        return '';
      }
    }



  /////////////////////////////
  /// SET REQUIREMENTS : 
  /////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Vision',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            print(snapshot.data);
            return MainMethod(
                context,
                snapshot
                    .data); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
          inital_val = snapshot.data.toString();
          return MainMethod(context, snapshot.data);
        });
  }


  //////////////////////////////////////////
  // MAIN METHOD SECTION :
  //////////////////////////////////////////
  Column MainMethod(
    BuildContext context,
    data,
  ) {
    return Column(
      children: [
        Container(
          width: context.width * vision_cont_width,
          height: context.height * vision_cont_height,
          child: Column(
            children: [
              // SUB HEADING :
              SubHeadingSection(context),

              // Vision input field
              WhyInputField(context)
            ],
          ),
        ),

        // BOTTOM NAVIGATION:
        updateMode == true
            ? UpdateButton(context)
            : BusinessSlideNav(
                slide: SlideType.vision,
                submitform: SubmitVisionForm,
              )
      ],
    );
  }


  //////////////////////////////
  /// EXTERNAL METHODS : 
  /// 1. WhyInputFiels
  /// 2. 
  //////////////////////////////
  Container WhyInputField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.04),
      height: maxlines * 24.0,
      child: FormBuilder(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: FormBuilderTextField(
          initialValue: inital_val != "null" ? inital_val : '',
          name: 'vision',
          maxLength: 2000,
          style: GoogleFonts.robotoSlab(
            fontSize: 15,
          ),
          validator: FormBuilderValidators.compose([
            // Remove Comment in  Production mode:
            FormBuilderValidators.minLength(context, 500,
                errorText: 'At least 500 required'),

            FormBuilderValidators.maxLength(context, 2000,
                errorText: 'Maximum 2000 char allow ')
          ]),
          scrollPadding: EdgeInsets.all(10),
          maxLines: maxlines,
          decoration: InputDecoration(
              helperText: 'min allow 200 ',
              hintText: "your vision",
              hintStyle: TextStyle(
                color: Colors.blueGrey.shade200,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(width: 1.5, color: Colors.blueGrey.shade200)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: primary_light)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ),
    );
  }

  Container SubHeadingSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.05),
      child: AutoSizeText.rich(
          TextSpan(style: context.textTheme.headline2, children: [
        TextSpan(
            text: vision_subHeading_text,
            style: TextStyle(
                color: light_color_type3, fontSize: vision_subheading_text))
      ])),
    );
  }

  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdatetVisionFrom();
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
