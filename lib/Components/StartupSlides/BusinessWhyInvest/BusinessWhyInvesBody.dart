import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessWhyInvestStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class BusinessWhyInvestBody extends StatefulWidget {
  BusinessWhyInvestBody({Key? key}) : super(key: key);

  @override
  State<BusinessWhyInvestBody> createState() => _BusinessWhyInvestBodyState();
}

class _BusinessWhyInvestBodyState extends State<BusinessWhyInvestBody> {
  var whyInvestStore =
      Get.put(BusinessWhyInvestStore(), tag: 'whyinvest_store');
  var startupConnector =
      Get.put(StartupViewConnector(), tag: "startup_connector");
  var startupUpdater = Get.put(StartupUpdater(), tag: 'update_startup');

  final formKey = GlobalKey<FormBuilderState>();
  var my_context = Get.context;

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
  String? inital_val = '';

  // update params:
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;
  var pageParam;
  bool? updateMode = false;

  /////////////////////////////////
  // SUBMIT FORM :
  /////////////////////////////////
  SubmitWhyInvestForm() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var whyInvest = formKey.currentState!.value['whyinvest'];
      var res = await whyInvestStore.SetWhyInvest(visionText: whyInvest);

      // Success Handler :
      if (res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.toNamed(create_business_milestone_url);
      }

      // Error Handler :
      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
      }
    }

    // Invalid Form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  //////////////////////////////
  /// UPDATE FORM :
  //////////////////////////////
  UpdateWhyInvest() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var whyInvest = formKey.currentState!.value['whyinvest'];
      var res = await whyInvestStore.SetWhyInvest(visionText: whyInvest);
      var resp = await startupUpdater.UpdatehBusinessWhy();
      // Success Handler Cached data :
      if (res['response']) {
        // Update Success Handler :
        if (resp['response']) {
          CloseCustomPageLoadingSpinner();
          Get.closeAllSnackbars();
          Get.toNamed(create_business_milestone_url);
        }
        // Update Error Handler :
        if (!resp['response']) {
          CloseCustomPageLoadingSpinner();
          Get.closeAllSnackbars();
          Get.showSnackbar(MyCustSnackbar(
              width: snack_width,
              type: MySnackbarType.error,
              title: update_error_title,
              message: update_error_msg));
        }
      }

      // Error Handler Cached data :
      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
      }
    }

    // Invalid Form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  //////////////////////////////////
  // SET PAGE DEFAULT STATE :
  //////////////////////////////////
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
    var snack_width = MediaQuery.of(context).size.width * 0.50;

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

    ///////////////////////////////
    // GET REQUIREMENTS
    ///////////////////////////////
    GetLocalStorageData() async {
      try {
        final resp = await startupConnector.FetchBusinessWhy();
        final data = await whyInvestStore.GetWhyInvest();
        inital_val = data;
        return data;
        
      } catch (e) {
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.error,
          message: e,
          title: fetch_data_error_title,
        ));

        return '';
      }
    }

    /////////////////////////////
    /// SET REQUIREMTNS :
    /////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Why section',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
              context,
              snapshot.data,
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
          inital_val = snapshot.data.toString();
          return MainMethod(context, snapshot.data);
        });
  }

///////////////////////////////
  // MAIN METHOD SECTION :
///////////////////////////////
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
              VisionInputField(context)
            ],
          ),
        ),

        // BOTTOM NAVIGATION:
        updateMode == true
            ? UpdateButton(context)
            : BusinessSlideNav(
                slide: SlideType.whyInvest,
                submitform: SubmitWhyInvestForm,
              )
      ],
    );
  }

  //////////////////////////////////////////////
  /// EXTERNAL METHODS :
  /// 1. VisonText
  /// 2. SubHeadingText
  /// 3. UploadButton
  //////////////////////////////////////////////
  Container VisionInputField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.04),
      height: maxlines * 24.0,
      child: FormBuilder(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: FormBuilderTextField(
          initialValue: inital_val != "null" ? inital_val : '',
          name: 'whyinvest',
          maxLength: 2000,
          style: GoogleFonts.robotoSlab(
            fontSize: 16,
          ),
          validator: FormBuilderValidators.compose([
            // Remove Comment in  Production mode:
            // FormBuilderValidators.minLength(context, 200,
            //     errorText: 'At least 200 required'),
            FormBuilderValidators.maxLength(context, 2000,
                errorText: 'Maximum 2000 char allow ')
          ]),
          scrollPadding: EdgeInsets.all(10),
          maxLines: maxlines,
          decoration: InputDecoration(
              helperText: 'min allow 200 ',
              hintText: "why invest  in you",
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
            text: business_why_sub_text,
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
          await UpdateWhyInvest();
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
