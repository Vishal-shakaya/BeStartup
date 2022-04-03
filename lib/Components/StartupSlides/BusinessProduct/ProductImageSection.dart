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

  final prodStore = Get.put(BusinessProductStore(), tag: 'product_store');

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
      var resp =
          await prodStore.UploadProductImage(logo: image, filename: filename);

      if (resp['response']) {
        String logo_url = resp['data'];

        // Upldate UI :
        setState(() {
          upload_image_url = logo_url;
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // IMAGE BLOCK:
    return Container(
      width: context.width * 0.20,
      height: context.height * 0.38,
      child: Stack(
        children: [
          upload_image_url == ''
              ? ImagePreviewContainer(context)
              :
                // IMAGE BLOCK :
                ImageContainer(context),

                // Upload Button :
                UploadButton(context)
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                padding: EdgeInsets.all(5),
                width: upload_btn_width,
                height: upload_btn_height,
                child:
                    Icon(Icons.cloud_upload, color: Colors.white, size: 30),
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
                left: Radius.circular(20),
                right: Radius.circular(20)),
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
              TextSpan(
                  style: Get.textTheme.headline3,
                  children: [
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
