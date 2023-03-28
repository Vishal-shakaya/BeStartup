import 'dart:convert';
import 'dart:typed_data';

import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/ThumbnailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Components/StartupSlides/BusinessThumbnail/NoticeSection.dart';
import 'package:be_startup/Components/StartupSlides/BusinessThumbnail/ThumbnailSection.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ThumbnailBody extends StatefulWidget {
  ThumbnailBody({Key? key}) : super(key: key);

  @override
  State<ThumbnailBody> createState() => _ThumbnailBodyState();
}

class _ThumbnailBodyState extends State<ThumbnailBody> {
  var thumbnailStore = Get.put(
    ThumbnailStore(),
  );

  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;

  var my_context = Get.context;

  // Update params :
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  var is_admin;
  var user_id;
  var startup_id;

  bool? updateMode = false;

  ///////////////////////////////////
  /// RESPONSIVE DEFAULT SETTINGS;
  /// ///////////////////////////
  double body_cont_width = 0.5;
  double body_height = 0.70;
  double image_hint_text_size = 22;

  BackButtonRoute() {
    var urlParam = {
      'user_id': user_id,
      'is_admin': is_admin,
    };
    Get.toNamed(startup_view_url, parameters: {'data': jsonEncode(urlParam)});
  }

/////////////////////////////////////////////
  /// UPDATE THUMBNAIL :
  /// The function is called when the user clicks on the "Update" button. The function then calls the
  /// "UpdateThumbnail" function in the "updateStore" class. The "UpdateThumbnail" function then returns a
  /// response object. The response object is then used to determine whether the update was successful or
  /// not. If the update was successful, the user is redirected to the "startup_view_url" page. If the
  /// update was not successful, a snackbar is displayed to the user
/////////////////////////////////////////////
  UpdateThumbnail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final resp = await thumbnailStore.UpdateThumbnail(user_id: user_id);

    // Update Success Handler :
    if (resp['response']) {
      final previousPath = await thumbnailStore.GetPreviousPath();
      final deleteResp = await DeleteFileFromStorage(previousPath);
      print(resp);
      
      var param = jsonEncode({
        'user_id': user_id,
        'is_admin': is_admin,
      });
      Get.toNamed(startup_view_url, parameters: {'data': param});
    }

    // Update Error Handler :
    if (!resp['response']) {
      Get.showSnackbar(MyCustSnackbar(
          type: MySnackbarType.error,
          width: snack_width,
          message: resp['message']));
    }
  }

  ////////////////////////////////////////////
  /// SET PAGE DEFAULT STATE
  ////////////////////////////////////////////
  @override
  void initState() {
    if (Get.parameters.isNotEmpty) {
      pageParam = jsonDecode(Get.parameters['data']!);
      is_admin = pageParam['is_admin'];
      user_id = pageParam['user_id'];

      if (pageParam['type'] == 'update') {
        updateMode = true;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: context.width * body_cont_width,
                  height: context.height * body_height,
                  alignment: Alignment.center,
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
        ),
        updateMode == true
            ? Positioned(
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

///////////////////////////////////////////
  /// EXTERNAL METHODS :
///////////////////////////////////////////

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
