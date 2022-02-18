import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
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
  bool is_notice_visible = true;
  double notice_block_padding = 20;

///////////////////////////////////
  /// RESPONSIVE DEFAULT SETTINGS;
  /// ///////////////////////////
  double body_cont_width = 0.5;
  double body_height = 0.8;

  double image_cont_width = 0.5;
  double image_cont_height = 0.4;
  double image_hint_text_size = 22;

  double imgage_sec_height = 0.3;

  double upload_btn_top = 0.27;
  double upload_btn_left = 0.4;

  double upload_btn_width = 50;
  double upload_btn_height = 50;

  double notice_cont_width = 0.20;
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
  }

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

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////
    /// RESPONSIVE BREAK POINTS :
    /// //////////////////////////////

    // PC:
    if (context.width > 1200) {
      body_cont_width = 0.5;
      body_height = 0.8;

      image_cont_width = 0.5;
      image_cont_height = 0.4;

      imgage_sec_height = 0.3;

      upload_btn_top = 0.27;
      upload_btn_left = 0.4;

      upload_btn_width = 50;
      upload_btn_height = 50;
      notice_cont_width = 0.19;
      image_hint_text_size = 22;
    }

    // SMALL PC 1000
    if (context.width < 1200) {
      body_cont_width = 0.8;
      image_cont_width = 0.8;
      upload_btn_left = 0.6;
      notice_cont_width = 0.24;
      image_hint_text_size = 20;
    }

    // TABLET :
    if (context.width < 800) {
      body_cont_width = 0.9;
      image_cont_width = 0.9;
      notice_cont_width = 0.35;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      notice_cont_width = 0.45;
    }

    // PHONE:
    if (context.width < 480) {
      notice_cont_width = 0.45;
    }

    return SingleChildScrollView(
      child: Container(
          width: context.width * body_cont_width,
          height: context.height * body_height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                width: context.width * image_cont_width,
                height: context.height * image_cont_height,
                child: Stack(
                  children: [
                    upload_image_url== ''
                        ? Container(
                            height: context.height * imgage_sec_height,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20)),
                                border: Border.all(
                                  width:2,
                                  color:Colors.black54 )),
                            child: AutoSizeText.rich(TextSpan(
                                style: Get.textTheme.headline3,
                                children: [
                                  TextSpan(
                                      text: thumbnail_slide_subheading,
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade200,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ])),
                          )
                        : Container(
                            padding: EdgeInsets.all(2),
                            height: context.height * imgage_sec_height,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20)),
                              border: Border.all(
                                width: 2,
                                color:Colors.black54 )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(19),
                                right: Radius.circular(19),
                              ),
                              child: Image.network(
                                upload_image_url,
                              width: context.width * image_cont_width,
                              height: context.height * image_cont_height,
                                fit:BoxFit.cover ),
                            )),

                    Positioned(
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: upload_btn_width,
                            height: upload_btn_height,
                            child: Icon(Icons.cloud_upload,
                                color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              ///////////////////////////////
              /// IMPORTANT SECTION:
              ///////////////////////////////
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              is_notice_visible = !is_notice_visible;
                              is_notice_visible
                                  ? notice_block_padding = 20
                                  : notice_block_padding = 0;
                            });
                          },
                          child: AutoSizeText('Why thumbnail Important!',
                              style: Get.textTheme.headline2),
                        ),
                        Icon(Icons.arrow_downward_rounded)
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(notice_block_padding),
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade50,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10))),
                      child: Visibility(
                          visible: is_notice_visible,
                          child: Container(
                              width: context.width * notice_cont_width,
                              child: AutoSizeText.rich(TextSpan(
                                  style: TextStyle(
                                      wordSpacing: 5, color: Colors.black),
                                  children: [
                                    TextSpan(text: thumbnail_important_text)
                                  ])))),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
