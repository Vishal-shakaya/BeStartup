import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
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
    return Container(
        margin: EdgeInsets.only(top: context.height * 0.05),
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
                    radius: 85,
                    backgroundColor: Colors.blueGrey[100],
                    foregroundImage: NetworkImage(upload_image_url),
                  )
                : CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.blueGrey[100],
                    child: AutoSizeText(
                      'Startup Logo', 
                       style:TextStyle(
                         color:light_color_type3,
                         fontWeight: FontWeight.bold
                          )
                         ,)
                      )
                      ),

            //////////////////////////////
            // UPLOAD CAMERA ICON:
            ////////////////////////////////
            Positioned(
                top: 129,
                left: 129,
                child: Card(
                  shadowColor: primary_light,
                  // elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 18,
                    child: IconButton(
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
