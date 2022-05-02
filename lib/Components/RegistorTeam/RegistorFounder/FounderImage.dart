import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/Team/CreateFounderStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class FounderImage extends StatefulWidget {
  FounderImage({Key? key}) : super(key: key);

  @override
  State<FounderImage> createState() => _FounderImageState();
}

class _FounderImageState extends State<FounderImage> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;
  bool is_uploading = false;

  double image_radius = 85;
  double upload_icon_position_top = 129;
  double upload_icon_position_left = 129;

  var founderStore = Get.put(BusinessFounderStore(), tag: 'founder');

  @override
  Widget build(BuildContext context) {
    var spinner = Container(
      padding: EdgeInsets.all(8),
      child: CircularProgressIndicator(
        color: dartk_color_type3,
        strokeWidth: 4,
      ),
    );

    ErrorSnakbar() {
      Get.closeAllSnackbars();
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

    /////////////////////////////////////////
    // PICKED IMAGE AND STORE IN  FILE :
    /////////////////////////////////////////
    Future<void> PickImage() async {
      // Pick only one file :
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      setState(() {
        is_uploading = true; 
      });

      // if rsult null then return :
      if (result == null) return;

      // if file single then gets ist path :
      if (result != null && result.files.isNotEmpty) {
        image = result.files.first.bytes;
        filename = result.files.first.name;

        var resp = await founderStore.UploadFounderImage(
            image: image, filename: filename);

        if (!resp['response']) {
          ErrorSnakbar();
          return;
        }
        setState(() {
          upload_image_url = resp['data'];
           is_uploading = false; 
        });
      }
    }

    // DEFAULT :
    if (context.width > 1500) {
      image_radius = 85;
      upload_icon_position_top = 129;
      upload_icon_position_left = 129;
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      upload_icon_position_top = 129;
      upload_icon_position_left = 129;
      image_radius = 85;
      print('1500');
    }

    if (context.width < 1200) {
      upload_icon_position_top = 105;
      upload_icon_position_left = 118;
      image_radius = 75;
      print('1200');
    }

    if (context.width < 1000) {
      upload_icon_position_top = 105;
      upload_icon_position_left = 118;
      image_radius = 75;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      upload_icon_position_top = 100;
      upload_icon_position_left = 108;
      image_radius = 70;
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      upload_icon_position_top = 90;
      upload_icon_position_left = 90;
      image_radius = 65;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      upload_icon_position_top = 90;
      upload_icon_position_left = 90;
      image_radius = 65;
      print('480');
    }

    return Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Card(
                shadowColor: light_color_type3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(85.0),
                ),
                child: upload_image_url != ''
                    ? CircleAvatar(
                        radius: image_radius,
                        backgroundColor: Colors.blueGrey[100],
                        foregroundImage: NetworkImage(upload_image_url),
                      )
                    : CircleAvatar(
                        radius: image_radius,
                        backgroundColor: Colors.blueGrey[100],
                        child: AutoSizeText(
                          'Startup Logo',
                          style: TextStyle(
                              color: light_color_type3,
                              fontWeight: FontWeight.bold),
                        ))),

            //////////////////////////////
            // UPLOAD CAMERA ICON:
            ////////////////////////////////
            Positioned(
                top: upload_icon_position_top,
                left: upload_icon_position_left,
                child: Card(
                  shadowColor: primary_light,
                  // elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 18,
                    child: is_uploading
                        ? spinner
                        : IconButton(
                            onPressed: () {
                              PickImage();
                            },
                            icon: Icon(Icons.camera_alt_rounded,
                                size: 19, color: primary_light)),
                  ),
                )),
          ],
        ));
  }
}
