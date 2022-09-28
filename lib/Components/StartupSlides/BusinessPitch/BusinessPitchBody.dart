import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinesssPitchStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class BusinessPitchBody extends StatefulWidget {
  BusinessPitchBody({Key? key}) : super(key: key);

  @override
  State<BusinessPitchBody> createState() => _BusinessPitchBodyState();
}

class _BusinessPitchBodyState extends State<BusinessPitchBody> {
  var my_context = Get.context;

  var url_controller = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();

  var startupConnector = Get.put(StartupViewConnector());

  var startupUpdater = Get.put(StartupUpdater());

  var pitchStore = Get.put(BusinessPitchStore());

  double mile_cont_width = 0.70;

  double mile_cont_height = 0.70;

  double subhead_sec_width = 400;

  double subhead_sec_height = 85;

  double con_button_width = 150;

  double con_button_height = 40;

  double con_btn_top_margin = 30;

  double mile_subhead_fontSize = 20;

  double input_field_width = 0.30;

  double input_field_fontSize = 13;

  double input_field_top_margin = 0.08;

  double subhead_con_width = 0.40;

  double subhead_con_height = 0.20;

  double subhead_con_top_margin = 0.03;

  double subhead_fontSize = 14;

  String? inital_val = '';

  var pageParam;

  var startup_id;

  var founder_id;

  var is_admin;

  bool? updateMode = false;

  //////////////////////////////////////////////////
  /// Important Function Section :
  /// Here Create and Update pitch to backend :
  ///////////////////////////////////////////////////

  /////////////////////////////
  /// SUBMIT FORM :
  /////////////////////////////
  SubmitPitch() async {
    MyCustPageLoadingSpinner();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      var pitch = formKey.currentState!.value['pitch'];
      print('pitch ${pitch}');
      var res = await pitchStore.SetPitch(pitchText: pitch);

      // Success Handler :
      if (res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.toNamed(create_business_milestone_url);
      }

      // Error Handler
      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, message: res['message']));
      }
    }

    // Invalid Form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
      ));
    }
  }

  /////////////////////////////
  /// UPDATE Pitch  FORM :
  /////////////////////////////
  UpdatePitch() async {
    MyCustPageLoadingSpinner();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var pitch = formKey.currentState!.value['[pitch]'];
      await pitchStore.SetPitchParam(data: pitch);

      var resp =
          await startupUpdater.UpdatehBusinessPitch(startup_id: startup_id);

      // Success Handler Cached Data:
      // Update Success Handler :
      if (resp['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.toNamed(vision_page_url);
      }

      //  Update Error Handler :
      if (!resp['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, message: resp['message']));
      }
    }

    // Invalid Form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
      ));
    }
  }

  ////////////////////////////
  // GET REQUIREMENTS :
  ////////////////////////////
  GetLocalStorageData() async {
    MyCustPageLoadingSpinner();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    try {
      // Update :
      if (updateMode == true) {
        final resp =
            await startupConnector.FetchBusinessPitch(startup_id: startup_id);
        await pitchStore.SetPitchParam(data: resp['data']['vision']);
      }

      // Get :
      final data = await pitchStore.GetPitch();
      inital_val = data;

      CloseCustomPageLoadingSpinner();
      return data;
    } catch (e) {
      print('Vision Fetchng error $e');

      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();

      Get.showSnackbar(MyCustSnackbar(
          width: snack_width, message: e, title: fetch_data_error_title));
      return '';
    }
  }

  /////////////////////////////////////
  // SET PAGE DEFAULT STATE :
  /////////////////////////////////////
  @override
  void initState() {
    if (Get.parameters.isNotEmpty) {
      pageParam = jsonDecode(Get.parameters['data']!);

      founder_id = pageParam['founder_id'];
      startup_id = pageParam['startup_id'];
      is_admin = pageParam['is_admin'];

      if (pageParam['type'] == 'update') {
        updateMode = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mile_cont_width = 0.70;

    mile_cont_height = 0.70;

    subhead_sec_width = 400;

    subhead_sec_height = 85;

    con_button_width = 150;

    con_button_height = 40;

    con_btn_top_margin = 30;

    mile_subhead_fontSize = 20;

    input_field_width = 0.30;

    input_field_fontSize = 13;

    input_field_top_margin = 0.08;

    subhead_con_width = 0.40;

    subhead_con_height = 0.20;

    subhead_con_top_margin = 0.03;

    subhead_fontSize = 14;

    // DEFAULT :
    if (context.width > 1700) {
      mile_cont_width = 0.70;

      mile_cont_height = 0.70;

      subhead_sec_width = 400;

      subhead_sec_height = 85;

      con_button_width = 150;

      con_button_height = 40;

      con_btn_top_margin = 30;

      mile_subhead_fontSize = 20;

      input_field_width = 0.30;

      input_field_fontSize = 13;

      input_field_top_margin = 0.08;

      subhead_con_width = 0.40;

      subhead_con_height = 0.20;

      subhead_con_top_margin = 0.03;

      subhead_fontSize = 14;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
        mile_cont_width = 0.70;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 20;

        input_field_width = 0.30;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.50;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.03;

        subhead_fontSize = 14;
      print('1500');
    }

    if (context.width < 1200) {
        mile_cont_width = 0.70;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 18;

        input_field_width = 0.45;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.50;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.03;

        subhead_fontSize = 14;
      print('1200');
    }

    if (context.width < 1000) {
        mile_cont_width = 0.80;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 18;

        input_field_width = 0.50;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.55;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.03;

        subhead_fontSize = 14;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        mile_cont_width = 0.80;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 17;

        input_field_width = 0.65;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.65;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.03;

        subhead_fontSize = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
        mile_cont_width = 0.90;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 16;

        input_field_width = 0.70;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.70;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.03;

        subhead_fontSize = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
        mile_cont_width = 0.80;

        mile_cont_height = 0.70;

        subhead_sec_width = 400;

        subhead_sec_height = 85;

        con_button_width = 150;

        con_button_height = 40;

        con_btn_top_margin = 30;

        mile_subhead_fontSize = 14;

        input_field_width = 0.90;

        input_field_fontSize = 13;

        input_field_top_margin = 0.08;

        subhead_con_width = 0.80;

        subhead_con_height = 0.20;

        subhead_con_top_margin = 0.04;

        subhead_fontSize = 13;
      print('480');
    }

    /////////////////////////////
    /// SET REQUIREMENTS :
    /////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading Vision Section');
          }

          if (snapshot.hasError) {
            return ErrorPage();
          }

          if (snapshot.hasData) {
            return MainMethod(
                context); // snapshot.data  :- get your object which is pass from your downloadData() function
          }

          inital_val = snapshot.data.toString();
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: context.width * mile_cont_width,
            height: context.height * mile_cont_height,
            child: Column(
              children: [
                // SUBHEADING SECTION :
                SubHeadingSection(context),
                // INPUT FIELD :
                PitchInputField(context),
              ],
            ),
          ),
          updateMode == true
              ? UpdateButton(context)
              : BusinessSlideNav(
                  slide: SlideType.pitch,
                  submitform: SubmitPitch,
                )
        ],
      ),
    );
  }

  Container PitchInputField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: context.height * input_field_top_margin),
      width: context.width * input_field_width,
      child: FormBuilder(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: FormBuilderTextField(
          keyboardType: TextInputType.url,
          initialValue: inital_val != "null" ? inital_val : '',
          name: 'pitch',
          style: GoogleFonts.robotoSlab(
              fontSize: input_field_fontSize, wordSpacing: 1.5, height: 1.5),
          validator: FormBuilderValidators.compose([
            // Remove Comment in  Production mode:
            FormBuilderValidators.minLength(context, 10,
                errorText: 'Enter valid url '),
          ]),
          scrollPadding: EdgeInsets.all(10),
          decoration: InputDecoration(
              hintText: "Paste Youtube video url ",
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

  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdatePitch();
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

  Column SubHeadingSection(BuildContext context) {
    return Column(
      children: [
        // Important note :
        Container(
          margin: EdgeInsets.only(top: context.height * 0.03),
          child: AutoSizeText.rich(
              TextSpan(style: context.textTheme.headline2, children: [
                TextSpan(
                    text: 'Submit Startup Pitch ( Youtube Video Url )',
                    style: TextStyle(
                        color: light_color_type3,
                        fontSize: mile_subhead_fontSize))
              ]),
              textAlign: TextAlign.center),
        ),

        SafeArea(
          child: Container(
              alignment: Alignment.topCenter,
              width: context.width * subhead_con_width,
              height: context.height * subhead_con_height,
              margin: EdgeInsets.only(
                  top: context.height * subhead_con_top_margin),
              padding: EdgeInsets.all(20),

              // Decoration:
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10))),
              
              child: SingleChildScrollView(
                child: AutoSizeText.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: pitch_subHeading_text,
                        style: TextStyle(
                            fontSize: subhead_fontSize,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ]),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ],
    );
  }
}
