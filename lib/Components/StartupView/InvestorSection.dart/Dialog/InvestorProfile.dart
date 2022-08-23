import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/StartupInvestor/StartupInvestorStore.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class InvestorProfileImage extends StatefulWidget {
  String? member_image = '';
  InvestorFormType? form_type;
  InvestorProfileImage({this.form_type, this.member_image, Key? key})
      : super(key: key);

  @override
  State<InvestorProfileImage> createState() => _InvestorProfileImage();
}

class _InvestorProfileImage extends State<InvestorProfileImage> {
  var startupInvestorStore = Get.put(StartupInvestorStore());
  var my_context = Get.context;

  Uint8List? image;
  String filename = '';

  String upload_image_url = '';
  bool is_uploading = false;
  late UploadTask? upload_process;

//////////////////////////////////////////
// UPLOADING IMAGE :
//////////////////////////////////////////
  Future<void> PickImage() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
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
      var resp = await startupInvestorStore.UploadInvestorProfile(
          image: image, filename: filename);

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
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(type: MySnackbarType.error, width: snack_width));

        // Set spinner off :
        setState(() {
          is_uploading = false;
        });
      }
    }
  }

  @override
  void initState() {

    if (widget.form_type == InvestorFormType.edit) {
      upload_image_url = widget.member_image.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 160,
        // alignment: Alignment.center,
        child: Stack(
          children: [
            Card(
                shadowColor: light_color_type3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(85.0),
                ),
                child: upload_image_url != ''
                    ? CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blueGrey[100],
                        foregroundImage: NetworkImage(upload_image_url),
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blueGrey[100],
                        child: AutoSizeText(
                          'profile picture',
                          style: TextStyle(
                              color: light_color_type3,
                              fontWeight: FontWeight.bold),
                        ))),

            //////////////////////////////
            // UPLOAD CAMERA ICON:
            ////////////////////////////////
            Positioned(
                top: 100,
                left: 100,
                child: Card(
                  shadowColor: primary_light,
                  // elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 18,
                    child: is_uploading
                        // UPLOADING PROCESSS :
                        ? Container(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              color: primary_light,
                              strokeWidth: 4,
                            ),
                          )
                        :
                        // SHOW UPLOAD BUTTON IF IMAG NOT UPLOADING :
                        IconButton(
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
