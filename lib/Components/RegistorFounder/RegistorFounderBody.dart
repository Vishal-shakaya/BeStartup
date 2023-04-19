import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Components/RegistorFounder/FounderImage.dart';
import 'package:be_startup/Components/RegistorFounder/RegistorFounderForm.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shimmer/shimmer.dart';

class RegistorFounderBody extends StatefulWidget {
  const RegistorFounderBody({Key? key}) : super(key: key);

  @override
  State<RegistorFounderBody> createState() => _RegistorFounderBodyState();
}

class _RegistorFounderBodyState extends State<RegistorFounderBody> {
  var founderStore = Get.put(FounderStore());
  var updateStore = Get.put(StartupUpdater());
  final formKey = GlobalKey<FormBuilderState>();
  var my_context = Get.context;
  var updatePicture = '';
  var updateData = {
    'name': '',
    'phone_no': '',
    'primary_mail': '',
    'other_contact': ''
  };

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  double page_height = 0.65;
  double? fontSize = 40;

  double heading_height = 0.15;

  var pageParam;
  var user_id;
  bool? updateMode = false;
  var previousPath = '';

  /////////////////////////////////////////
  // CREATE FOUNDER  FORM :
  /////////////////////////////////////////
  SubmitFounderDetail() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var authUser = FirebaseAuth.instance.currentUser;

    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      final String name = formKey.currentState!.value['founder_name'];
      final String phone_no = formKey.currentState!.value['phone_no'];
      final String email = formKey.currentState!.value['email'];
      final String other_contact = formKey.currentState!.value['other_info'];

      final res = await founderStore.CachedCreateFounder(
          user_id: authUser?.uid,
          name: name,
          email: authUser?.email,
          phone_no: phone_no,
          primary_mail: email,
          other_contact: other_contact);

      // Success Handler :
      if (res['response']) {
        CloseCustomPageLoadingSpinner();
        SmartDialog.dismiss();
        formKey.currentState!.reset();
        Get.toNamed(create_business_detail_url);
      }

      // Error Handler :
      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        SmartDialog.dismiss();
        Get.closeAllSnackbars();

        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: res['message'],
            message: create_error_msg));
      }
    }

    // Form Error :
    else {
      SmartDialog.dismiss();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
        type: MySnackbarType.error,
      ));
    }
  }

///////////////////////////////////////////
// UPDATE FOUNDER FORM  :
///////////////////////////////////////////
  UpdateFounderDetail() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      final String founder_name = formKey.currentState!.value['founder_name'];
      final String phone_no = formKey.currentState!.value['phone_no'];
      final String email = formKey.currentState!.value['email'];
      final String other_contact = formKey.currentState!.value['other_info'];

      Map<String, dynamic> founder = {
        'name': founder_name,
        // 'position': founder_position,
        'phone_no': phone_no,
        'primary_mail': email,
        'other_contact': other_contact
      };

      final update_resp = await founderStore.UpdateFounderDetail(
          user_id: user_id, data: founder);

      // Update Success Handler :
      if (update_resp['response']) {
        CloseCustomPageLoadingSpinner();
        await DeleteFileFromStorage(previousPath);

        SmartDialog.dismiss();
        formKey.currentState!.reset();
        Get.toNamed(home_page_url);
      }

      // Update Error Handler :
      if (!update_resp['response']) {
        CloseCustomPageLoadingSpinner();
        SmartDialog.dismiss();
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: update_error_title,
            message: update_error_msg));
      }
    }

    // Form Error :
    else {
      CloseCustomPageLoadingSpinner();
      SmartDialog.dismiss();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
        type: MySnackbarType.error,
      ));
    }
  }


//////////////////////////////////////////////////////////////
/// This function retrieves data from local 
/// storage and sets variables based on the retrieved data.
//////////////////////////////////////////////////////////////
  GetLocalStorageData() async {

    if (Get.parameters.isNotEmpty) {
        pageParam = jsonDecode(Get.parameters['data']!);
        user_id = pageParam['user_id'];

        if (pageParam['type'] == 'update') {
          updateMode = true;
  
          try {
            final resp = await founderStore.FetchFounderDetailandContact(user_id: user_id);

            final picture = resp['data']['picture'] ?? temp_avtar_image;
            
            final name = resp['data']['name'] ?? '';
            
            final phone_no = resp['data']['phone_no'] ?? '';
            
            final primary_mail = resp['data']['primary_mail'] ?? '';
            
            final other_contact = resp['data']['other_contact'] ?? '';
            
            previousPath = resp['data']['path'] ?? '';

            founderStore.SetImagePath(image_path: previousPath);
           
            founderStore.SetImageUrl(url: picture);

            updatePicture = picture;


            Map<String, String> data = {
              'picture': picture,
              'name': name,
              'phone_no': phone_no,
              'primary_mail': primary_mail,
              'other_contact': other_contact,
            };


            updateData = data;

          } catch (e) {
            print('Fetching erro Founder detail $e');
          }
        }
      }
  }



  @override
  Widget build(BuildContext context) {
    fontSize = 40;
    page_height = 0.65;
    heading_height = 0.15;

    // DEFAULT :
    if (context.width > 1500) {
      fontSize = 40;
      page_height = 0.7;
      heading_height = 0.12;
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      heading_height = 0.12;
      print('1200');
    }

    if (context.width < 1000) {
      fontSize = 35;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      fontSize = 30;
      heading_height = 0.10;
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      fontSize = 25;
      page_height = 0.68;
      heading_height = 0.06;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      page_height = 0.70;
      print('480');
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading User Detail',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Stack MainMethod(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: context.height * heading_height,
              margin: EdgeInsets.only(top: context.height * 0.02),
              child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline2, children: [
                  TextSpan(
                      text: 'Founder',
                      style: TextStyle(
                          fontSize: fontSize, color: slide_header_color
                          //  fontSize: 35
                          ))
                ]),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                height: context.height * page_height,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      // UPLOAD FOUNDER IMAGE :
                      FounderImage(
                        picture: updatePicture,
                      ),

                      // REGISTRATION FORM :
                      RegistorFounderForm(
                        formKey: formKey,
                        data: updateData,
                      )
                    ],

                    // BOTTOM NAVIGATION:
                  ),
                )),
            updateMode == true
                ? CreateOrUpdateFounderButton(context, UpdateFounderDetail)
                : CreateOrUpdateFounderButton(context, SubmitFounderDetail)
          ],
        ),
        updateMode == true
            ? Positioned(
                bottom: 25,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(home_page_url);
                  },
                  child: Card(
                    color: Colors.blueGrey.shade500,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
            : Container()
      ],
    );
  }

  ////////////////////////////////////
  /// External Method :
  ////////////////////////////////////
  Container CreateOrUpdateFounderButton(
    BuildContext context,
    fun,
  ) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await fun();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Submit',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
