import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Components/Slides/BusinessProduct/ProductSection.dart';
import 'package:be_startup/Components/Slides/BusinessProduct/SocialLinkDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:file_picker/file_picker.dart';

class ProductImage extends StatefulWidget {
  BuildContext? context;
  Function setProductImage;
  ProductImage({
    Key? key,
    required this.setProductImage,
    this.context,
  }) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;

  double image_cont_width = 0.5;
  double image_cont_height = 0.38;

  double image_sec_height = 0.30;
  double image_sec_width = 0.50;

  double upload_btn_top = 0.32;
  double upload_btn_left = 0.16;

  double upload_btn_width = 40;
  double upload_btn_height = 40;

  String youtube_link = '';
  String web_link = '';

  Color suffix_icon_color = Colors.blueGrey.shade300;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  TextEditingController social_medialink_controller = TextEditingController();

  //////////////////////////////
  /// IMAGE BOX HEIGHT WIDTH:
  /// ///////////////////////////
  double image_top_margin = 0.05;

  /////////////////////////////////////////
  // PICKED IMAGE AND STORE IN  FILE :
  /////////////////////////////////////////
  Future UploadImage() async {
    if (image == null) return;

    // UPLOAD FILE LOCAION IN FIREBASE :
    final destination = 'user_profile/profile_image/$filename';
    upload_process = FileStorage.UploadFileBytes(destination, image!);
    // ERROR ACCURE
    if (upload_process == null) return;

    final snapshot = await upload_process!.whenComplete(() {
      print('PROFILE UPLOADED');
    });

    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      upload_image_url = urlDownload;
    });

    widget.setProductImage(upload_image_url);
  }

  // CALL FUNCTION TO UPLOAD IMAGE :
  // THEN CALL UPLOD IMAGE FOR UPLOAD IMAGE IN BACKGROUND :
  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if rsult null then return :
    if (result == null) return;

    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;
      await UploadImage();
    }
  }

////////////////////////////////////////////////////
  /// SOCAIL MEDIA LINK SUBMIT FORM :
  ///  1. GET YOUTUBE LINK :
  ///  2. OR OTHER WEB LINK :
  ///  VALIDATE LINK : IF NOT NULL :
  ///  STORE IN VAR THEN  BACKEND :
  ///  CLEAR TEXT FIELD AFTER SUCCESSFUL SUBMISSION:
  /// //////////////////////////////////////////////////
  SubmitLink(LinkType link) {
    final text = social_medialink_controller.text;

    // YOUTUBE SECTION:
    if (link == LinkType.youtube) {
      setState(() {
        youtube_link = text;
      });
      Navigator.of(context).pop();
      FocusManager.instance.primaryFocus?.unfocus();
      social_medialink_controller.clear();
    }

    // WEB LINK :
    if (link == LinkType.web) {
      setState(() {
        web_link = text;
      });
      Navigator.of(context).pop();
      FocusManager.instance.primaryFocus?.unfocus();
      social_medialink_controller.clear();
    }
  }

// DISPOSE ;
// 1 SOCIAL MEDIA TEXT CONTROLLER :
  @override
  void dispose() {
    // TODO: implement dispose
    social_medialink_controller.clear();
    social_medialink_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// DEFAULT CONFIG:
    if (context.width > 1500) {
      image_cont_width = 0.5;
      image_cont_height = 0.37;

      image_sec_height = 0.30;
      image_sec_width = 0.50;

      upload_btn_top = 0.32;
      upload_btn_left = 0.16;

      upload_btn_width = 40;
      upload_btn_height = 40;
      image_top_margin = 0.05;
    }

    if (context.width < 1500) {
      image_top_margin = 0.07;
      upload_btn_top = 0.33;
      upload_btn_left = 0.15;
    }

    // PC:
    if (context.width < 1200) {
      image_cont_width = 0.5;
      image_cont_height = 0.40;
      upload_btn_top = 0.33;

      image_sec_height = 0.30;
      image_sec_width = 0.50;

      upload_btn_top = 0.34;
      upload_btn_left = 0.16;

      upload_btn_width = 40;
      upload_btn_height = 40;
      image_top_margin = 0.08;
    }

    if (context.width < 1000) {
      upload_btn_top = 0.35;
      upload_btn_left = 0.40;
      image_cont_height = 0.41;
    }

    // TABLET :
    if (context.width < 800) {
      image_cont_width = 0.7;
      image_cont_height = 0.41;
      upload_btn_top = 0.35;
      upload_btn_left = 0.60;
    }
    // SMALL TABLET:
    if (context.width < 640) {}

    // PHONE:
    if (context.width < 480) {}

    return Column(
      children: [
        Container(
          height: context.height * image_cont_height,
          width: context.width * image_cont_width,
          child: Stack(
            children: [
              upload_image_url == ''
                  // UPLOAD IMGE BOX:
                  ? ImageBox(context)

                  // IF IMAGE UPLOADED THEN SHOW IMAGE IN CONTAINER :
                  : ImageContainer(context),

              // UPLOAD BUTTTON :
              UploadButton(context)
            ],
          ),
        ),

        /// YOUTUBE BUTTON TO UPLAOD LINK :
        SocialLinks(context)
      ],
    );
  }

  //////////////////////////////////////////////////////
  // UPLOAD IMAGE BOX :
  //////////////////////////////////////////////////////
  Container ImageBox(BuildContext context) {
    return Container(
      height: context.height * image_sec_height,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: context.height * image_top_margin),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20)),
          border: Border.all(width: 2, color: Colors.black54)),
      child:
          AutoSizeText.rich(TextSpan(style: Get.textTheme.headline3, children: [
        TextSpan(
            text: product_image_subhead,
            style: TextStyle(
                color: Colors.blueGrey.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 15))
      ])),
    );
  }

//////////////////////////////////////////////////////
// SHOW IMAGE IF SUCCESSFULLY UPLOADED :
// HEIGHT : __
// WIDHT : __
//////////////////////////////////////////////////////
  Column ImageContainer(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(2),
            height: context.height * image_sec_height,
            margin: EdgeInsets.only(top: 29),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)),
                border: Border.all(width: 2, color: Colors.grey.shade200)),
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(19),
                right: Radius.circular(19),
              ),
              child: Image.network(upload_image_url,
                  width: context.width * image_cont_width,
                  height: context.height * image_cont_height,
                  fit: BoxFit.cover),
            )),
      ],
    );
  }

  /////////////////////////////////////////
  /// YOUTUBE BUTTON TO UPLAOD LINK :
  /// 1 ADD  YOUTUBE LINK :
  /// 2 ADD WEB LINK :
  /// 3 SET ICON COLOR ACTIVE IF LINK
  /// HAS SOME STRING VALUE ex: link!=''
  //////////////////////////////////////////
  Container SocialLinks(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 20, ),
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              SocialMediaLinkDialog(
                  link: LinkType.youtube,
                  context: context,
                  social_medialink_controller: social_medialink_controller,
                  submitLink: SubmitLink);
            },
            child: Icon(
              Icons.play_circle_fill_outlined,
              color: youtube_link == ''
                  ? Colors.red.shade200
                  : Colors.red.shade400,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              SocialMediaLinkDialog(
                  link: LinkType.web,
                  context: context,
                  social_medialink_controller: social_medialink_controller,
                  submitLink: SubmitLink);
            },
            child: Icon(
              Icons.link_outlined,
              color:
                  web_link == '' ? Colors.blue.shade200 : Colors.blue.shade400,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////
  ///  START IMAGE UPLOADING PROCESS :
  ////////////////////////////////////////
  Positioned UploadButton(BuildContext context) {
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
            padding: EdgeInsets.all(5),
            width: upload_btn_width,
            height: upload_btn_height,
            child: Icon(Icons.cloud_upload, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
