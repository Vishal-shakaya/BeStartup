import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Components/StartupSlides/BusinessDetailSlide/BusinessForm.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:be_startup/Components/StartupSlides/BusinessDetailSlide/BusinessIcon.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BusinessBody extends StatefulWidget {
  const BusinessBody({Key? key}) : super(key: key);

  @override
  State<BusinessBody> createState() => _BusinessBodyState();
}

class _BusinessBodyState extends State<BusinessBody> {
  var detailStore = Get.put(BusinessDetailStore(), tag: 'business_store');
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  var pageParam;
  bool? updateMode;

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;


  // SET DEFAULT STATE :
  Future<String?> SetVal() async {
    await Future.delayed(Duration(seconds: 5));
    var data = await detailStore.GetBusinessName();
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
    return Container(
        height: context.height * 0.80,
        /////////////////////////////////////////
        ///  BUSINESS SLIDE :
        ///  1. BUSINESS ICON :
        ///  2. INPUT FIELD TAKE BUSINESS NAME :
        /////////////////////////////////////////
        child: SingleChildScrollView(
          child: Column(
            children: [
              BusinessIcon(),
              BusinessForm(
                formKey: formKey,
              ),

              updateMode == true
              ? UpdateButton(context)
              : BusinessSlideNav(
                key: UniqueKey(),
                submitform: SubmitBusinessDetail,
                slide: SlideType.detail,
              )
            ],
          ),
        ));
  }

  StartLoading() {
    // SHOW LOADING SPINNER :
    Get.snackbar(
      '',
      '',
      shouldIconPulse: true,
      isDismissible: true,
      borderRadius: 4,
      showProgressIndicator: true,
      margin: EdgeInsets.only(top: 10),
      duration: Duration(minutes: 5),
      backgroundColor: Colors.green.shade50,
      titleText: MySnackbarTitle(title: 'Details'),
      messageText: MySnackbarContent(message: 'processs...'),
      maxWidth: context.width * 0.50,
      padding: EdgeInsets.all(15),
    );
  }

///////////////////////////////////////////////////
  /// HANDLE SUBMIT FORM :
  /// 1. IF SUCCESS THEN REDIRECT TO ANOTHER SLIDE :
  /// 2. ELSE SHOW ERRO RALERT :
///////////////////////////////////////////////////
  SubmitBusinessDetail() async {
    formKey.currentState!.save();
    StartLoading();
    if (formKey.currentState!.validate()) {
      var business_name = formKey.currentState!.value['startup_name'];
      // HANDLING RESPONSE :
      var res = await detailStore.SetBusinessName(business_name);

      // RESPONSE HANDLING :
      // 1. SUCCESS RESPONSE THEN REDIRECT TO NEXT SLIDE :
      // 2. IF FORM IS NOT VALID OR NULL SHOW ERROR :
      if (res['response']) {
        Get.closeAllSnackbars();
        updateMode ==true
        ? Get.toNamed(startup_view_url)
        : Get.toNamed(create_business_thumbnail_url);
      }

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

      // formKey.currentState!.reset();
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        '',
        '',
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Error  accure'),
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: context.width * 0.50,
      );
    }
  }

  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await SubmitBusinessDetail();
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
