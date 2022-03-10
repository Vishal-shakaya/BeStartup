import 'package:be_startup/Backend/Startup/StartupDetailStore.dart';
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
  var snakbar_head = 'Uploading Details';
  var snakbar_msg = 'processs... ';

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
                businessDetailForm: SubmitBusinessDetail,
                slide: SlideType.detail,
              )
            ],
          ),
        ));
  }


  SubmitBusinessDetail() async {
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
      titleText: MySnackbarTitle(title: snakbar_head),
      messageText: MySnackbarContent(message: snakbar_msg),
      maxWidth: context.width * 0.50,
      padding: EdgeInsets.all(15),
    );

    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      String business_name = formKey.currentState!.value['startup_name'];

      // HANDLING RESPONSE :
      var res = await detailStore.SetBusinessName(business_name);
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
          titleText: MySnackbarTitle(title: 'Error  accure'),
          messageText: MySnackbarContent(message: 'Something went wrong'),
          maxWidth: context.width * 0.50,
        );
      }

      formKey.currentState!.reset();
    } else {
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
