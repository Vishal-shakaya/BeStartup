import 'dart:html';

import 'package:be_startup/Backend/Startup/BusinessProductStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/BusinessDetailStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

enum ProductUrlType { youtube, content }

class ProductImageSection extends StatefulWidget {
  const ProductImageSection({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;
  bool is_uploading = false;
  final prodStore = Get.put(BusinessProductStore(), tag: 'product_store');

  // Upload Button Position Ration
  // 1 Top and righ :
  double upload_btn_top_pod = 0.31;
  double upload_btn_right_pod = 0.15;

  // Upload Button size : width and height:
  double upload_btn_width = 50;
  double upload_btn_height = 50;

  // Image width and height :
  double image_cont_width = 0.20;
  double image_cont_height = 0.34;

  bool prod_url_sec_visible = false;

  Color active_youtube_icon_color = Colors.red.shade400;
  Color youtube_icon_color = Colors.red.shade200;

  Color active_content_icon_color = Colors.blue.shade400;
  Color content_icon_color = Colors.blue.shade200;

  var product_url_controller = TextEditingController();
  late ProductUrlType url_type;

  SetProductYoutubeUrl() {
    setState(() {
      print('hello');
      prod_url_sec_visible = true;
      url_type = ProductUrlType.youtube;
    });
  }

  SetProductContentUrl() {
    setState(() {
      prod_url_sec_visible = true;
      url_type = ProductUrlType.content;
      // content_icon_color = active_content_icon_color;
    });
  }

//////////////////////////////////////////////////////
  /// 1. Check if url is null then not update url :
  /// 2. If Success then Update url :
  /// 3. Hide url Input Filed :
  /// ///////////////////////////////////
  SubmitProductUrl() {
    var url_val = product_url_controller.text;

    if (url_val == '' || url_val == null) {
      return;
    }

    if (url_type == ProductUrlType.youtube) {
      setState(() {
        youtube_icon_color = active_youtube_icon_color;
      });
    }

    if (url_type == ProductUrlType.content) {
      setState(() {
        content_icon_color = active_content_icon_color;
      });
    }

    // hide input field :
    setState(() {
      prod_url_sec_visible = false;
    });
    // Clear input field : 
    product_url_controller.clear();
  }

// UPLOADING IMAGE :
  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if rsult null then return :
    if (result == null) return;

    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;

      // IF TRUE THE UPDATE LOGO ELSE SHOW ERROR :
      // 1. Start Loading spinner :
      // 2. If success then stop and show cloud icon :
      // 3. If error then show cloud icon and alert :
      setState(() {
        is_uploading = true;
      });
      var resp =
          await prodStore.UploadProductImage(logo: image, filename: filename);

      if (resp['response']) {
        String logo_url = resp['data'];

        // Upldate UI :
        setState(() {
          upload_image_url = logo_url;
          is_uploading = false;
        });
      }

      if (!resp['response']) {
        // show error snakbar :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Error'),
          messageText: MySnackbarContent(message: 'Something went wrong'),
          maxWidth: context.width * 0.50,
        );

        // Set spinner off :
        setState(() {
          is_uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // IMAGE BLOCK:
    return Container(
      width: context.width * 0.20,
      height: context.height * 0.45,
      child: Stack(
        children: [
          upload_image_url == ''
              ? ImagePreviewContainer(context)
              : // IMAGE BLOCK :
              ImageContainer(context),
          // Upload Button :
          UploadButton(context),

          Container(
              child: Positioned(
            top: context.height * 0.35,
            left: context.width * 0.07,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    SetProductYoutubeUrl();
                  },
                  child: Tooltip(
                    message: 'Add youtube video link',
                    child: Icon(
                      Icons.video_library_rounded,
                      color: youtube_icon_color,
                      size: 25,
                    ),
                  ),
                ),
                // Spacing
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    SetProductContentUrl();
                  },
                  child: Tooltip(
                    message: 'Add content supportive Link',
                    child: Icon(
                      Icons.link_outlined,
                      color: content_icon_color,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          )),

          // Take Content Link :
          Visibility(
            visible: prod_url_sec_visible,
            child: Positioned(
              top: context.height * 0.39,
              left: context.width * 0.01,
              child: Container(
                width: context.width * 0.30,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: product_url_controller,
                        decoration: InputDecoration(hintText: 'paste url'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 25, left: 15),
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                              onPressed: () {
                                SubmitProductUrl();
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.blue.shade300,
                              ))),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Positioned UploadButton(BuildContext context) {
    return Positioned(
      top: context.height * upload_btn_top_pod,
      left: context.width * upload_btn_right_pod,
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
            child: is_uploading
                ? Container(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  )
                : Icon(Icons.cloud_upload, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

  Container ImageContainer(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(width: 2, color: Colors.grey)),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(upload_image_url,
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.cover),
        ));
  }

  Container ImagePreviewContainer(BuildContext context) {
    return Container(
        width: context.width * image_cont_width,
        height: context.height * image_cont_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 2, color: Colors.grey)),
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline3, children: [
              TextSpan(
                  text: product_image_subhead,
                  style: TextStyle(
                      color: Colors.blueGrey.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))
            ]),
          ),
        ));
  }
}
