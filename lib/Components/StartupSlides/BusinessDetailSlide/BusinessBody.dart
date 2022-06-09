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

  // SET DEFAULT STATE :
  Future<String?> SetVal() async {
    await Future.delayed(Duration(seconds: 5));
    var data = await detailStore.GetBusinessName();
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
              BusinessSlideNav(
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
        Get.toNamed(create_business_thumbnail_url);
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
}
