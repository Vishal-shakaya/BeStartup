import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/ThumbnailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shimmer/shimmer.dart';

class ThumbnailSection extends StatefulWidget {
  ThumbnailSection({Key? key}) : super(key: key);

  @override
  State<ThumbnailSection> createState() => _ThumbnailSectionState();
}

class _ThumbnailSectionState extends State<ThumbnailSection> {
  final thumbStore = Get.put(ThumbnailStore(), tag: 'thumb_store');
  final startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');
  final authUser = FirebaseAuth.instance.currentUser;

  Uint8List? image;
  String filename = '';
  String upload_image_url = '';

  late UploadTask? upload_process;
  double image_hint_text_size = 22;
  bool is_loading = false;

  /// RESPONSIVE DEFAULT SETTINGS;
  double imgage_sec_height = 0.3;

  double upload_btn_top = 0.27;
  double upload_btn_left = 0.4;

  double image_cont_width = 0.5;
  double image_cont_height = 0.4;

  double upload_btn_width = 50;
  double upload_btn_height = 50;

  double upload_icon_size = 35;

  double hint_text_font_size = 20;

  var pageParam;
  var is_admin;
  var user_id;
  var startup_id;

  bool? updateMode = false;

///////////////////////////////////////////////////////
// CALL FUNCTION TO UPLOAD IMAGE :
// THEN CALL UPLOD IMAGE FOR UPLOAD IMAGE IN BACKGROUND
///////////////////////////////////////////////////////
  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    setState(() {
      is_loading = true;
    });

    // if rsult null then return :
    if (result == null) return;

    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;

      var resp =
          await thumbStore.SetThumbnail(thumbnail: image, filename: filename);

      if (!resp['response']) {
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(type: MySnackbarType.error, width: snack_width));
        return;
      }

      setState(() {
        upload_image_url = resp['data'];
        is_loading = false;
      });
    }
  }

  ////////////////////////////////////////////////
  /// GET REQUIREMENTS :
  ////////////////////////////////////////////////
  GetLocalStorageData() async {
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    try {

      // Handle Update View : 
      if (Get.parameters.isNotEmpty) {
        pageParam = jsonDecode(Get.parameters['data']!);
        is_admin = pageParam['is_admin'];
        user_id = pageParam['user_id'];

        if (pageParam['type'] == 'update') {
          final resp = await startupConnector.FetchThumbnail(user_id: user_id);
          final temp_thumb = resp['data']['thumbnail'];
         upload_image_url = temp_thumb;
        }
      }

      // Fetch Thumbnail and update : 
      final data = await thumbStore.GetThumbnail();
      upload_image_url = data;
      return upload_image_url;
    } catch (e) {
      return '';
    }
  }

  ////////////////////////////////////////////
  /// SET PAGE DEFAULT STATE
  ////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hint_text_font_size = 20;
    var spinner = MyCustomButtonSpinner(color: Colors.white);
    ////////////////////////////////////
    /// RESPONSIVE BREAK POINTS :
    /// //////////////////////////////

    // PC:
    if (context.width > 1200) {
      image_cont_width = 0.5;
      image_cont_height = 0.4;

      imgage_sec_height = 0.3;

      upload_btn_top = 0.27;
      upload_btn_left = 0.4;

      upload_btn_width = 50;
      upload_btn_height = 50;

      upload_icon_size = 35;
    }

    // SMALL PC 1000
    if (context.width < 1200) {
      image_cont_width = 0.8;

      upload_btn_left = 0.6;

      upload_icon_size = 35;
      upload_btn_width = 45;
      upload_btn_height = 45;
    }

    // TABLET :
    if (context.width < 800) {
      hint_text_font_size = 18;
      image_cont_width = 0.9;

      upload_icon_size = 30;
      upload_btn_width = 40;
      upload_btn_height = 40;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      hint_text_font_size = 16;
      upload_icon_size = 25;
      upload_btn_width = 35;
      upload_btn_height = 35;
    }

    // PHONE:
    if (context.width < 480) {
      upload_icon_size = 25;
      hint_text_font_size = 14;

      upload_icon_size = 20;
      upload_btn_width = 30;
      upload_btn_height = 30;
    }

    ////////////////////////////////////////////////
    /// SET REQUIREMENTS :
    ////////////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: MainMethod(context, spinner, snapshot.data),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, spinner, snapshot.data);
          }
          return MainMethod(context, spinner, snapshot.data);
        });
  }

//////////////////////////////////////
  // MAIN WIDGET SECTION :
  // 1. Thumbnal Image section:
  // 2. Thumbnail upload button :
  // 3. Thumbnail Container :
//////////////////////////////////////
  Container MainMethod(BuildContext context, Container spinner, data) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      width: context.width * image_cont_width,
      height: context.height * image_cont_height,
      child: Stack(
        children: [
          upload_image_url == ''
              /////////////////////////////////////////////////////////
              // UPLOAD THUMBNAIL SECTION  :
              // SHOW UPLOAD CONTAIENR IF THERE IS NO IMAGE :
              // IF THERE IS IMAGE THEN SHOW IMAG WITH CONTAINER :
              ////////////////////////////////////////////////////////////
              ? ThumbnailContainer(context)
              : ThumbnailImageContainer(context),
          // UPLOAD THUMBNAIL BUTTON :
          ThumbnailUploadBUtton(context, spinner, is_loading)
        ],
      ),
    );
  }

  Positioned ThumbnailUploadBUtton(BuildContext context, spinner, is_loading) {
    return Positioned(
      top: context.height * upload_btn_top,
      left: context.width * upload_btn_left,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          PickImage();
        },
        child: Card(
          color: Colors.orange,
          shadowColor: Colors.orangeAccent.shade400,
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: upload_btn_width,
            height: upload_btn_height,
            child: is_loading
                ? spinner
                : Icon(Icons.cloud_upload,
                    color: Colors.white, size: upload_icon_size),
          ),
        ),
      ),
    );
  }

  Container ThumbnailImageContainer(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: context.height * imgage_sec_height,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(width: 2, color: Colors.black54)),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(upload_image_url,
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.fitWidth),
        ));
  }

  Container ThumbnailContainer(BuildContext context) {
    return Container(
      height: context.height * imgage_sec_height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20)),
          border: Border.all(width: 2, color: Colors.black54)),
      child: AutoSizeText.rich(
        TextSpan(style: Get.textTheme.headline3, children: [
          TextSpan(
              text: thumbnail_slide_subheading,
              style: TextStyle(
                  color: Colors.blueGrey.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: hint_text_font_size))
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
