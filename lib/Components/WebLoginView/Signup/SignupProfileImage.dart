import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:get/get.dart';

class SignupProfileImage extends StatefulWidget {
  const SignupProfileImage({
    Key? key,
  }) : super(key: key);


  @override
  State<SignupProfileImage> createState() => _SignupProfileImageState();
}

class _SignupProfileImageState extends State<SignupProfileImage> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;
  bool is_uploading = false;
 var myAuth = Get.put(MyAuthentication(), tag: 'signup_user');

    Future<void> PickImage(context) async {
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
          await myAuth.UploadProfileImage(image: image, filename: filename);

  if (resp['response']) {
        String profile_image = resp['data'];

        // Upldate UI :
        setState(() {
          upload_image_url = profile_image;
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
  var spinner = Container(
    padding: EdgeInsets.all(8),
    child: CircularProgressIndicator(
      color: dartk_color_type3,
      strokeWidth: 4,
    ),
    );

    return Container(
      margin: EdgeInsets.only(top: context.height * 0.02),
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
                backgroundColor:
                    Colors.blueGrey[100],
                foregroundImage:
                    NetworkImage(upload_image_url),
              )
            : CircleAvatar(
                radius: 85,
                backgroundColor:
                    Colors.blueGrey[100],
                child: Icon(Icons.person,
                    size: 70,
                    color: light_color_type3))),

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
                    borderRadius:
                        BorderRadius.circular(20)),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 18,
                  child: is_uploading? spinner: 
                      IconButton(
                      onPressed: () async {
                        await PickImage(context);
                      },
                      icon: Icon(Icons.camera_alt_rounded,
                          size: 19,
                          color: primary_light)),
                ),
              )),
        ],
      ),
    );
  }
}
