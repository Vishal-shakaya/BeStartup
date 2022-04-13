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
      print(res);
      // RESPONSE HANDLING :
      // 1. SUCCESS RESPONSE THEN REDIRECT TO NEXT SLIDE :
      // 2. IF FORM IS NOT VALID OR NULL SHOW ERROR :
      if (res['response']) {
        Get.closeAllSnackbars();
        // formKey.currentState!.reset();
        Get.toNamed(create_business_catigory_url);
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

  ResetVisionForm() {}

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
              VisionInputField(context),
            ],
          ),
        ),

        // BOTTOM NAVIGATION:
        BusinessSlideNav(
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
}
