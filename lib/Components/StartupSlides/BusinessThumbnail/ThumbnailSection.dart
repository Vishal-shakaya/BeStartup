import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class ThumbnailSection extends StatefulWidget {
  ThumbnailSection({Key? key}) : super(key: key);

  @override
  State<ThumbnailSection> createState() => _ThumbnailSectionState();
}

class _ThumbnailSectionState extends State<ThumbnailSection> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;
  double image_hint_text_size = 22;

///////////////////////////////////
  /// RESPONSIVE DEFAULT SETTINGS;
  /// ///////////////////////////
  double imgage_sec_height = 0.3;
  
  double upload_btn_top = 0.27;
  double upload_btn_left = 0.4;

  double image_cont_width = 0.5;
  double image_cont_height = 0.4;
  
  double upload_btn_width = 50;
  double upload_btn_height = 50;



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


  // CALL FUNCTION TO UPLOAD IMAGE : 
  // THEN CALL UPLOD IMAGE FOR UPLOAD IMAGE IN BACKGROUND
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

      image_cont_width = 0.5;
      image_cont_height = 0.4;

      imgage_sec_height = 0.3;

      upload_btn_top = 0.27;
      upload_btn_left = 0.4;

      upload_btn_width = 50;
      upload_btn_height = 50;
    }

    // SMALL PC 1000
    if (context.width < 1200) {
      image_cont_width = 0.8;
      upload_btn_left = 0.6;

    }

    // TABLET :
    if (context.width < 800) {
      image_cont_width = 0.9;

    }
    // SMALL TABLET:
    if (context.width < 640) {

    }

    // PHONE:
    if (context.width < 480) {

    }
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      width: context.width * image_cont_width,
      height: context.height * image_cont_height,
      child: Stack(
          children: [
            upload_image_url== ''
          /////////////////////////////////////////////////////////
            // UPLOAD THUMBNAIL SECTION  :
            // SHOW UPLOAD CONTAIENR IF THERE IS NO IMAGE : 
            // IF THERE IS IMAGE THEN SHOW IMAG WITH CONTAINER :  
          ////////////////////////////////////////////////////////////
                ? ThumbnailContainer(context)
                : ThumbnailImageContainer(context),
               // UPLOAD THUMBNAIL BUTTON :    
                 ThumbnailUploadBUtton(context)
          ],
        ),
    );
  }

  Positioned ThumbnailUploadBUtton(BuildContext context) {
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
      );
  }

  Container ThumbnailImageContainer(BuildContext context) {
    return Container(
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
          ));
  }

  Container ThumbnailContainer(BuildContext context) {
    return Container(
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
        );
  }
}