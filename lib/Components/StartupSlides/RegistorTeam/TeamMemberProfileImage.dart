import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/StartupSlides/RegistorTeam/MemberListView.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class TeamMemberProfileImage extends StatefulWidget {
  String? member_image = '';
  MemberFormType? form_type;
  TeamMemberProfileImage({this.form_type, this.member_image, Key? key})
      : super(key: key);

  @override
  State<TeamMemberProfileImage> createState() => _TeamMemberProfileImageState();
}

class _TeamMemberProfileImageState extends State<TeamMemberProfileImage> {
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  bool is_uploading = false;
  late UploadTask? upload_process;

  double image_width = 150;
  double image_height = 150;

  double upload_btn_top_pos = 100;
  double upload_btn_left_pos = 100;
  double upload_icon_size = 19;

  double hint_text_size = 13;
  var size; 

  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
//////////////////////////////////////////
  // UPLOADING IMAGE :
//////////////////////////////////////////
  Future<void> PickImage() async {
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: 'PROFILE',
      type: FileType.image);


    if (result == null) return;

    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;
      size = result.files.first.size / (1024 * 1024);
      size = size.toString().split('.')[0];
      size = int.parse(size);

      // if image size greater then 10 mb then show max size message:
      if (size > 10) {
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.info,
            title: 'Image size must be less then 10 mb',
            ));

        return;
      }

      setState(() {
        is_uploading = true;
      });

      var resp = await memeberStore.UploadProductImage(
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
  void initState() {
    // TODO: implement initState
    if (widget.form_type == MemberFormType.edit) {
      upload_image_url = widget.member_image.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    image_width = 150;
    image_height = 150;

    upload_btn_top_pos = 100;
    upload_btn_left_pos = 100;
    upload_icon_size = 19;

    hint_text_size = 13;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      image_width = 150;
      image_height = 150;

      upload_btn_top_pos = 100;
      upload_btn_left_pos = 100;
      upload_icon_size = 19;

      hint_text_size = 13;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      hint_text_size = 13;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      upload_btn_top_pos = 100;
      upload_btn_left_pos = 100;
      upload_icon_size = 19;

      hint_text_size = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      upload_icon_size = 19;

      image_width = 140;
      image_height = 140;

      hint_text_size = 11;
      print('480');
    }

    return Container(
        width: image_width,
        height: image_width,
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
                              fontSize: hint_text_size,
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
