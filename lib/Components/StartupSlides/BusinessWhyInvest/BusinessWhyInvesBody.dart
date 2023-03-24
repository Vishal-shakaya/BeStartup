import 'dart:convert';

import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessWhyInvestStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessWhyInvestBody extends StatefulWidget {
  BusinessWhyInvestBody({Key? key}) : super(key: key);

  @override
  State<BusinessWhyInvestBody> createState() => _BusinessWhyInvestBodyState();
}

class _BusinessWhyInvestBodyState extends State<BusinessWhyInvestBody> {
  var whyInvestStore = Get.put(BusinessWhyInvestStore());
  var startupConnector = Get.put(StartupViewConnector());
  var startupUpdater = Get.put(StartupUpdater());

  final authUser = FirebaseAuth.instance.currentUser;

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
  double vision_subheading_text = 17;
  int maxlines = 15;
  String? inital_val = '';

  // update params:
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  var user_id;
  var startup_id;
  var is_admin;
  bool? updateMode = false;



  BackButtonRoute(){
       var urlParam = {
        'user_id':user_id,
        'is_admin':is_admin,  
      };
      Get.toNamed(invest_page_url , parameters: {'data':jsonEncode(urlParam)});
  }
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
        Get.toNamed(create_business_pitcht_url);
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
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    MyCustPageLoadingSpinner();

    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var whyInvest = formKey.currentState!.value['whyinvest'];
      var resp = await startupUpdater.UpdatehBusinessWhy(
          user_id: user_id, why_text: whyInvest.toString().trim());
      final urlParam = jsonEncode({
        'user_id': user_id,
        'is_admin': is_admin,
      });

      if (resp['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.toNamed(invest_page_url, parameters: {'data': urlParam});
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

    // Invalid Form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  ///////////////////////////////
  // GET REQUIREMENTS
  ///////////////////////////////
  GetLocalStorageData() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var data;
    try {
      if (Get.parameters.isNotEmpty) {
        pageParam = jsonDecode(Get.parameters['data']!);
        user_id = pageParam['user_id'];
        is_admin = pageParam['is_admin'];

        if (pageParam['type'] == 'update') {
          updateMode = true;
          final resp =
              await startupConnector.FetchBusinessWhy(user_id: user_id);
          final temp_why = resp['data']['why_text'];
          inital_val = temp_why;
          data = inital_val;
        }
      } else {
        data = await whyInvestStore.GetWhyInvest();
        inital_val = data;
      }

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

  @override
  Widget build(BuildContext context) {
    if (context.width > 1200) {
      maxlines = 15;
      vision_subheading_text = 17;
      vision_cont_width = 0.50;
      vision_cont_height = 0.70;
    }

    // PC:
    if (context.width < 1200) {
      maxlines = 15;
      vision_subheading_text = 17;
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
      maxlines = 10;
      vision_cont_width = 0.90;
      vision_cont_height = 0.70;
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
  Stack MainMethod(BuildContext context,data,) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Column(
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
          ),
        ),

            updateMode==true?
            Positioned(
                bottom: 25,
                right: 0,
                child: InkWell(
                  onTap: () {
                    BackButtonRoute();
                  },
                  child: Card(
                    color: Colors.blueGrey.shade500,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
             : Container() 
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
            FormBuilderValidators.maxLength(2000,
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
        ]),
        textAlign: TextAlign.center,
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
