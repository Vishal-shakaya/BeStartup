import 'dart:io';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadUserProfileWidget extends StatefulWidget {
  UploadUserProfileWidget({Key? key}) : super(key: key);

  @override
  State<UploadUserProfileWidget> createState() => _SignupViewState();
}

class _SignupViewState extends State<UploadUserProfileWidget> {
  XFile? profile_image;
  File? circular_profile;
  String profile_image_path = '';
  UploadTask? upload_process;

//////////////////////////////////////////////////////////////////////
// CROPE IMAGE :
/// The function takes a file as an argument, crops it, and 
/// then uploads it to firebase storage
/// 
/// Args:
///   profile_image: The image file that you want to crop.
//////////////////////////////////////////////////////////////////////
  Future<void> CorpImage(profile_image) async {
    CroppedFile? cropImage = await ImageCropper().cropImage(
        sourcePath: profile_image!.path,
        uiSettings:[
           AndroidUiSettings(
            toolbarColor: primary_light,
            toolbarTitle: 'upload profile picture',
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original),
        ],
        aspectRatioPresets: [CropAspectRatioPreset.square],

        compressFormat: ImageCompressFormat.png,
        cropStyle: CropStyle.circle);

    // UPDATE PROFILE IMAGE IN UI :
    setState(() {
      circular_profile = File(cropImage!.path);
    });

  var file = await  File(cropImage!.path);
    // STORE FILE IN FIREBASE STORAGE :
    String filename = DateTime.now().toString();
    String destination = 'user_profile/profile_image/$filename';
    upload_process = FileStorage.UploadFile(destination,file) ;
    final snapshot = await upload_process!.whenComplete(() => {});
    final download_url = await snapshot.ref.getData();
    print(download_url);
  }



// CLEAR IMAGE :
  ClearImage() {
    setState(() {
      profile_image = null;
    });
  }




//////////////////////////////////////////////////////////////
// PICKED IMAGE AND STORE IN  FILE :
/// It allows the user to pick an image from the gallery or camera.
/// 
/// Args:
///   source (ImageSource): The source of the image.
/////////////////////////////////////////////////////////
  Future<void> PickImage(ImageSource source) async {
    try {
      XFile? new_image = await ImagePicker().pickImage(source: source);
      CorpImage(new_image);
      ClearImage();
    } catch (e) {
      print('** Unable to upload profile picture ***');
    }
  }





  @override
  Widget build(BuildContext context) {

    // BOTTOM SHEET TO SHOW UPLOAD OPTION:
    BottomSheet() {
      Get.bottomSheet(
        FractionallySizedBox(
          heightFactor: 0.30,
          child: ListView(
            children: [
              
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  await PickImage(ImageSource.gallery);
              
                },
                tileColor: Colors.grey.shade200,
                leading: Icon(Icons.phone_android_outlined,
                    color: light_color_type3),
                title: Text('Gallery', style: Get.theme.textTheme.headline5),
              ),
              
              
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  await PickImage(ImageSource.camera);
                },
              
                tileColor: Colors.grey.shade200,
                leading: Icon(Icons.camera_alt_sharp, color: light_color_type3),
                title: Text('Camera', style: Get.theme.textTheme.headline5),
              ),
            ],
          ),
        ),
       
       
        backgroundColor: Colors.grey.shade200,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      );
    }




    return Container(
        margin: EdgeInsets.only(top: context.height * 0.02),
        alignment: Alignment.center,
        child: Stack(
          children: [
            circular_profile != null
                ? CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.blueGrey[100],
                    foregroundImage: FileImage(circular_profile!),
                  )
                : CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.blueGrey[100],
                    child:
                        Icon(Icons.person, size: 70, color: light_color_type3)),

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
                        onPressed: BottomSheet,
                        icon: Icon(Icons.camera_alt_rounded,
                            size: 19, color: primary_light)),
                  ),
                )),
          ],
        ));
  }
}
