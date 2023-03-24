import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
  bool is_uploading = false;

  double profile_radius = 85;
  double upload_icon_radius = 18;

  double upload_icon_top_pos = 126;
  double upload_icon_left_pos = 126;

  // STORAGE :
  final detailStore = Get.put(BusinessDetailStore(), tag: 'business_store');
  final startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');

  // IMAGE PICKER :
  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if rsult null then return :
    if (result == null) return;
    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;

      setState(() {
        is_uploading = true;
      });
      // IF TRUE THE UPDATE LOGO ELSE SHOW ERROR :
      var resp =
          await detailStore.SetBusinessLogo(logo: image, filename: filename);

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
        // ignore: use_build_context_synchronously
        MyCustSnackbar(
            type: MySnackbarType.error,
            context: context,
            title: fetch_data_error_title,
            message: fetch_data_error_msg,
            width: context.width * 0.50);
      }
    }
  }

  //////////////////////////////////////////////////////
  /// 1. FETCH DATA ETHIER LOCALY CACHED OR DATABASE
  //  2. INITILIZE DEFAULT STATE :
  //  3. GET IMAGE IF HAS IS LOCAL STORAGE :
  ///////////////////////////////////////////////////////
  FetchData(context) async {
    var snack_width = MediaQuery.of(context).size.width * 0.50;

    // var pageParam = Get.parameters.values;
    // print('')

    var mySnack = MyCustSnackbar(
        type: MySnackbarType.error,
        title: fetch_data_error_title,
        message: fetch_data_error_msg,
        width: snack_width);

    try {

      final is_update = await detailStore.IsUpdate();
      if (is_update) {
        final data = await detailStore.GetUpdateDetail();
        upload_image_url = data['logo'];
      }
      else{
        final logo = await detailStore.GetBusinessLogo();
        upload_image_url = logo;
      }
      return upload_image_url;
    } catch (e) {
      return upload_image_url;
    }
  }

  @override
  Widget build(BuildContext context) {
    profile_radius = 85;
    // DEFAULT :
    if (context.width > 1500) {
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
      profile_radius = 80;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      profile_radius = 75;
      upload_icon_left_pos = 110;
      upload_icon_top_pos = 120;
      upload_icon_radius = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      profile_radius = 70;
      upload_icon_left_pos = 110;
      upload_icon_top_pos = 105;
      upload_icon_radius = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      profile_radius = 70;
      print('480');
    }

    var spinner = MyCustomButtonSpinner();

    return FutureBuilder(
        future: FetchData(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: MainMethod(context, spinner, snapshot.data),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
                context,
                spinner,
                snapshot
                    .data); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
          return MainMethod(context, spinner, snapshot.data);
        });
  }

/////////////////////////////////////
  /// MAIN METHOD :
/////////////////////////////////////
  Container MainMethod(BuildContext context, Container spinner, data) {
    return Container(
        margin: EdgeInsets.only(top: context.height * 0.05),
        alignment: Alignment.center,
        child: Stack(
          children: [
            BusinessLogo(),
            UploadButton(spinner),
          ],
        ));
  }

/////////////////////////////////
  /// EXTERNAL METHODS :
  /// 1. Logo card :
  /// 2. Upload button :
/////////////////////////////////
  Card BusinessLogo() {
    return Card(
        shadowColor: light_color_type3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(85.0),
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
                  'Startup Logo',
                  style: TextStyle(
                      color: light_color_type3, fontWeight: FontWeight.bold),
                )));
  }

  Positioned UploadButton(Container spinner) {
    return Positioned(
        top: upload_icon_top_pos,
        left: upload_icon_left_pos,
        child: Card(
          shadowColor: primary_light,
          // elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: upload_icon_radius,
            child: is_uploading
                ? spinner
                : IconButton(
                    onPressed: () {
                      PickImage();
                    },
                    icon: Icon(Icons.camera_alt_rounded,
                        size: upload_icon_radius, color: primary_light)),
          ),
        ));
  }
}
