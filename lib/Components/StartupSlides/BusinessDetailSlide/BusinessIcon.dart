import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class BusinessIcon extends StatefulWidget {
  BusinessIcon({Key? key}) : super(key: key);

  @override
  State<BusinessIcon> createState() => _BusinessIconState();
}

class _BusinessIconState extends State<BusinessIcon> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;

  // STORAGE :
  final detailStore = Get.put(BusinessDetailStore(), tag: 'startup_deatil');

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
    var resp = await detailStore.SetBusinessLogo(logo: image, filename: filename);

    if (resp['response']) {
      String logo_url = resp['data'];

        // Upldate UI :
        setState(() {
          upload_image_url = logo_url;
        });

      // successful snakbar :
      Get.snackbar(
        '',
        '',
            margin: EdgeInsets.only(top:10),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green.shade50,
            titleText: MySnackbarTitle(title:'Successfuly Operation'),
            messageText:  MySnackbarContent(message:'Business Logo Uploaded  Successfully'),
            maxWidth: context.width*0.50, 
          );
    }

    if (!resp['response']) {
      // show error snakbar :
        Get.snackbar(
          '',
          '',
              margin: EdgeInsets.only(top:10),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red.shade50,
              titleText: MySnackbarTitle(title:'Error'),
              messageText:  MySnackbarContent(message:'Something went wrong'),
              maxWidth: context.width*0.50, 
            );

    }
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
                          style: TextStyle(
                              color: light_color_type3,
                              fontWeight: FontWeight.bold),
                        ))),

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
                          PickImage(
                          );
                        },
                        icon: Icon(Icons.camera_alt_rounded,
                            size: 19, color: primary_light)),
                  ),
                )),
          ],
        ));
  }
}
