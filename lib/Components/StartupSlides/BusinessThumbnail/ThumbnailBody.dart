import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Components/StartupSlides/BusinessThumbnail/NoticeSection.dart';
import 'package:be_startup/Components/StartupSlides/BusinessThumbnail/ThumbnailSection.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ThumbnailBody extends StatefulWidget {
  ThumbnailBody({Key? key}) : super(key: key);

  @override
  State<ThumbnailBody> createState() => _ThumbnailBodyState();
}

class _ThumbnailBodyState extends State<ThumbnailBody> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;

  // Update params : 
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;

  ///////////////////////////////////
  /// RESPONSIVE DEFAULT SETTINGS;
  /// ///////////////////////////
  double body_cont_width = 0.5;
  double body_height = 0.70;
  double image_hint_text_size = 22;

  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');

  UpdateThumbnail() async {
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    final resp = await updateStore.UpdateThumbnail();
    if (resp['response']) {
      Get.toNamed(startup_view_url);
    }
    if (!resp['response']) {
      Get.showSnackbar(
        MyCustSnackbar(
        width: snack_width,
        message: resp['message']));
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
    ////////////////////////////////////
    /// RESPONSIVE BREAK POINTS :
    /// //////////////////////////////

    // PC:
    if (context.width > 1500) {
      body_cont_width = 0.5;
      body_height = 0.70;
      image_hint_text_size = 22;
    }

    // SMALL PC 1000
    if (context.width < 1200) {
      body_cont_width = 0.8;
      image_hint_text_size = 20;
    }

    // TABLET :
    if (context.width < 800) {
      body_cont_width = 0.9;
    }
    // SMALL TABLET:
    if (context.width < 640) {}

    // PHONE:
    if (context.width < 480) {}

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: context.width * body_cont_width,
              height: context.height * body_height,
              child: Column(
                children: [
                  // THUMBNAIL UPLOAD SECTION:
                  ThumbnailSection(),

                  // NOTICE  SECTION:
                  NoticeSection(),
                ],
              )),

          // NAVIGATION:
          updateMode == true
              ? UpdateButton(context)
              : BusinessSlideNav(
                  slide: SlideType.thumbnail,
                )
        ],
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
          await UpdateThumbnail();
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
