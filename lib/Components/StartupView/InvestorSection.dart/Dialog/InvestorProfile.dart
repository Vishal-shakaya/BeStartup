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

  double image_cont_width = 150;
  double image_cont_height = 150;

  double card_radius = 85.0;
  double profile_radius = 70;

  double pod_btn_top_space = 100;
  double pod_btn_left_space = 100;

  double pos_btn_radius = 20;
  double btn_radius = 18;
  double pod_btn_fontSize = 19;

  double pod_btn_padd = 8;

  double image_elevation = 5; 

  var image_podition = AlignmentDirectional.topStart;

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
    image_cont_width = 150;
    image_cont_height = 150;

    card_radius = 85.0;
    profile_radius = 70;

    pod_btn_top_space = 100;
    pod_btn_left_space = 100;

    pos_btn_radius = 20;
    btn_radius = 18;
    pod_btn_fontSize = 19;
    pod_btn_padd = 8;
    
    image_elevation = 5; 
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1700) {
      image_cont_width = 150;
      image_cont_height = 150;

      card_radius = 85.0;
      profile_radius = 70;

      pod_btn_top_space = 100;
      pod_btn_left_space = 100;

      pos_btn_radius = 20;
      btn_radius = 18;
      pod_btn_fontSize = 19;

      pod_btn_padd = 8;
      image_elevation = 5; 
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1400) {
      image_cont_width = 150;
      image_cont_height = 150;

      card_radius = 85.0;
      profile_radius = 60;

      pod_btn_top_space = 85;
      pod_btn_left_space = 85;

      pos_btn_radius = 16;
      btn_radius = 16;
      pod_btn_fontSize = 18;
      pod_btn_padd = 8;
      print('1400');
    }

    if (context.width < 1300) {
      image_cont_width = 150;
      image_cont_height = 150;

      card_radius = 85.0;
      profile_radius = 58;

      pod_btn_top_space = 83;
      pod_btn_left_space = 83;

      pos_btn_radius = 16;
      btn_radius = 16;
      pod_btn_fontSize = 16;
      pod_btn_padd = 8;
      print('1300');
    }

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
      image_cont_width = 150;
      image_cont_height = 150;

      card_radius = 90.0;
      profile_radius = 55;

      pod_btn_top_space = 75;
      pod_btn_left_space = 80;

      pos_btn_radius = 16;
      btn_radius = 16;
      pod_btn_fontSize = 16;
      pod_btn_padd = 8;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      image_cont_width = 150;
      image_cont_height = 150;

      card_radius = 90.0;
      profile_radius = 55;

      pod_btn_top_space = 78;
      pod_btn_left_space = 78;

      pos_btn_radius = 16;
      btn_radius = 14;
      pod_btn_fontSize = 14;
      pod_btn_padd = 8;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      image_cont_width = 150;
      image_cont_height = 120;

      card_radius = 500.0;
      profile_radius = 65;

      pod_btn_top_space = 75;
      pod_btn_left_space = 100;

      pos_btn_radius = 16;
      btn_radius = 14;
      pod_btn_fontSize = 14;
      pod_btn_padd = 8;
      image_elevation = 0; 
      
      image_podition = AlignmentDirectional.topCenter;
      print('480');
    }

    return Container(
        width: image_cont_width,
        height: image_cont_height,
        // alignment: Alignment.center,
        child: Stack(
          alignment: image_podition,
          children: [
            Card(
              elevation: image_elevation,
                shadowColor: light_color_type3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(card_radius),
                ),
                child: upload_image_url != ''
                    ? CircleAvatar(
                        radius: profile_radius,
                        backgroundColor: Colors.blueGrey[100],
                        foregroundImage: NetworkImage(upload_image_url),
                      )
                    : CircleAvatar(
                        radius: profile_radius,
                        backgroundColor: Colors.blueGrey[100],
                        child: AutoSizeText(
                          'profile picture',
                          style: TextStyle(
                              fontSize: 14,
                              color: light_color_type3,
                              fontWeight: FontWeight.bold),
                        ))),

            //////////////////////////////
            // UPLOAD CAMERA ICON:
            ////////////////////////////////
            Positioned(
                top: pod_btn_top_space,
                left: pod_btn_left_space,
                child: Card(
                  shadowColor: primary_light,
                  // elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(pos_btn_radius)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: btn_radius,
                    child: is_uploading
                        // UPLOADING PROCESSS :
                        ? Container(
                            padding: EdgeInsets.all(pod_btn_padd),
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
                                size: pod_btn_fontSize, color: primary_light)),
                  ),
                )),
          ],
        ));
  }
}
