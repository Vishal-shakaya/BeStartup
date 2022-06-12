import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessVisionStore.dart';
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
  var visionStore = Get.put(BusinessVisionStore(), tag: 'vision_store');





  SubmitVisionForm() async {
    // START LOADING :
    // SHOW LOADING SPINNER :
    Get.snackbar(
      '',
      '',
      shouldIconPulse: true,
      isDismissible: true,
      borderRadius: 4,
      showProgressIndicator: true,
      margin: EdgeInsets.only(top: 10),
      duration: Duration(minutes: 1),
      backgroundColor: Colors.green.shade50,
      titleText: MySnackbarTitle(title: 'Vision'),
      messageText: MySnackbarContent(),
      maxWidth: context.width * 0.50,
      padding: EdgeInsets.all(15),
    );

    // IF VISION NOT DEFINAE THEN :
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var vision = formKey.currentState!.value['vision'];
      var res = await visionStore.SetVision(visionText: vision);
      // RESPONSE HANDLING :
      // 1. SUCCESS RESPONSE THEN REDIRECT TO NEXT SLIDE :
      // 2. IF FORM IS NOT VALID OR NULL SHOW ERROR :
      if (res['response']) {
        Get.closeAllSnackbars();
        updateMode==true 
        ? Get.toNamed(vision_page_url)
        : Get.toNamed(create_business_catigory_url);
      }

      // FORM STORAGE ERROR :
      if (!res['response']) {
        Get.closeAllSnackbars();
        // Error Alert :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Error accured'),
          messageText: MySnackbarContent(message: res['message']),
          maxWidth: context.width * 0.50,
        );
      }
    }

    // INVALID FORM :
    else {
      Get.closeAllSnackbars();
      // Error Alert :
      Get.snackbar(
        '',
        '',
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Error accured'),
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: context.width * 0.50,
      );
    }
  }


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

// INITILIZE DEFAULT STATE :
// GET IMAGE IF HAS IS LOCAL STORAGE :
    Future<String?> GetLocalStorageData() async {
      try {
        final data = await visionStore.GetVision();
        inital_val = data;
        return data;
      } catch (e) {
        return '';
      }
    }

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

  // MAIN METHOD SECTION :
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
        updateMode==true
        ? UpdateButton(context)
        : BusinessSlideNav(
          slide: SlideType.vision,
          submitform: SubmitVisionForm,
        )
      ],
    );
  }

  Container VisionInputField(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: context.height * 0.04),
              height: maxlines * 24.0,
              child: FormBuilder(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: FormBuilderTextField(
                  initialValue: inital_val!="null" ? inital_val: '',
                  name: 'vision',
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
                      hintText: "your vision",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey.shade200,
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1.5, color: Colors.blueGrey.shade200)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(width: 2, color: primary_light)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
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
          await SubmitVisionForm();
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
