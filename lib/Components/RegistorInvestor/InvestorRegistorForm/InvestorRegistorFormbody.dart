import 'dart:convert';

import 'package:be_startup/Backend/Users/Investor/InvestorDetailStore.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/InvestorImage.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/RegistorInvForm.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InvestorRegistorFormBody extends StatefulWidget {
  InvestorRegistorFormBody({Key? key}) : super(key: key);

  @override
  State<InvestorRegistorFormBody> createState() =>
      _InvestorRegistorFormBodyState();
}

class _InvestorRegistorFormBodyState extends State<InvestorRegistorFormBody> {
  final investorStore = Get.put(InvestorDetailStore());
  final formKey = GlobalKey<FormBuilderState>();
  var my_context = Get.context;

  final authUser = FirebaseAuth.instance.currentUser;

  double done_btn_width = 150;

  double done_btn_height = 40;

  double con_button_width = 150;

  double con_button_height = 40;

  double con_btn_top_margin = 30;

  var pageHeight = 0.6;

  var pageParam;

  bool? updateMode = false;

  var user_id;

  var previousPath;

  var updatePicture;

  var updateData; 


  //////////////////////////////////////////////
  // CREATE INVESTOR FORM :
  //////////////////////////////////////////////
  SubmitInvestorDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    formKey.currentState!.save();
    MyCustPageLoadingSpinner();

    if (formKey.currentState!.validate()) {
      String name = formKey.currentState!.value['investor_name'];
      String phoneNo = formKey.currentState!.value['phone_no'];
      String email = formKey.currentState!.value['email'];
      String other_contact = formKey.currentState!.value['other_info'];

      final id = authUser?.uid;
      final mail = authUser?.email;
      var res = await investorStore.CreateInvestor(
          id: id,
          mail: mail,
          primaryMail: email,
          name: name,
          phoneNo: phoneNo,
          otherContact: other_contact);

      // Success Handler :
      if (res['response']) {
        formKey.currentState!.reset();
        CloseCustomPageLoadingSpinner();
        Get.toNamed(select_investor_choise, preventDuplicates: false);
      }

      // Error Handler :
      if (!res['response']) {
        Get.closeAllSnackbars();
        CloseCustomPageLoadingSpinner();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: create_error_title,
            message: create_error_msg));
      }
    }

    // Form Validatiaon Error :
    else {
      Get.closeAllSnackbars();
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  //////////////////////////////////
  // UPDATE INVESTOR FORM :
  //////////////////////////////////
  UpdateInvestorDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    formKey.currentState!.save();
    MyCustPageLoadingSpinner();

    if (formKey.currentState!.validate()) {
      String name = formKey.currentState!.value['investor_name'];
      String phoneNo = formKey.currentState!.value['phone_no'];
      String email = formKey.currentState!.value['email'];
      String other_contact = formKey.currentState!.value['other_info'];

      final id = authUser?.uid;
      final mail = authUser?.email;

      var update_resp = await investorStore.UpdateInvestorDetail(
          user_id: id??'',
          name: name??'',
          phone_no: phoneNo??'',
          other_contact: other_contact??'',
          email: email??'');

      // Success Handler :
      if (update_resp['response']) {
        // Update Success Hndler :
        if (update_resp['response']) {
          formKey.currentState!.reset();
          CloseCustomPageLoadingSpinner();
          Get.toNamed(homeProfessionalImage);
        }

        // Update Error handler :
        if (!update_resp['response']) {
          Get.closeAllSnackbars();
          CloseCustomPageLoadingSpinner();
          Get.showSnackbar(MyCustSnackbar(
              width: snack_width,
              type: MySnackbarType.error,
              title: update_resp['message'],
              message: update_error_msg));

          print('Error Investor Created');
        }
      }
    }

    // Form Validatiaon Error :
    else {
      Get.closeAllSnackbars();
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1700) {
      pageHeight = 0.6;
      print('greator then 1700');
    }

    if (context.width < 1700) {
      pageHeight = 0.7;
      print('1700');
    }
    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1400) {
      print('1400');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading User Detail ',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

//////////////////////////////////////
// GET REQUIREMENTS :
//////////////////////////////////////
  GetLocalStorageData() async {
    if (Get.parameters.isNotEmpty) {
      pageParam = jsonDecode(Get.parameters['data']!);
      user_id = pageParam['user_id'];
      if (pageParam['type'] == 'update') {
        updateMode = true;

        try {
          final resp = await investorStore.FetchInvestorDetailandContact(
              user_id: user_id);

          final picture = resp['data']['picture'] ?? temp_avtar_image;
          final name = resp['data']['name'] ?? '';
          final phone_no = resp['data']['phone_no'] ?? '';
          final primary_mail = resp['data']['email'] ?? '';
          final other_contact = resp['data']['other_contact'] ?? '';
          previousPath = resp['data']['path'] ?? '';

          updatePicture = picture;
          investorStore.SetImagePath(image_path: previousPath);
          investorStore.SetImageUrl(url: picture);
          // print('upload picture $updatePicture');
          Map<String, String> data = {
            'picture': picture,
            'name': name,
            // 'position': position,
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

  Column MainMethod(BuildContext context) {
    return Column(
      children: [
        Container(
            height: context.height * pageHeight,
            /////////////////////////////////////////
            ///  BUSINESS SLIDE :
            ///  1. BUSINESS ICON :
            ///  2. INPUT FIELD TAKE BUSINESS NAME :
            /////////////////////////////////////////
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // UPLOAD FOUNDER IMAGE :
                  InvestorImage(picture: updatePicture,),

                  // REGISTRATION FORM :
                  RegistorInvForm(
                    formKey: formKey,
                    data: updateData,
                  )
                ],

                // BOTTOM NAVIGATION:
              ),
            )),
        updateMode == true
            ? DoneButton(done_btn_width, done_btn_height, UpdateInvestorDetail)
            : DoneButton(done_btn_width, done_btn_height, SubmitInvestorDetail)
      ],
    );
  }

//////////////////////////////////
  /// EXTERNAL METHODS;
//////////////////////////////////

  Container DoneButton(
      double done_btn_width, double done_btn_height, Function SubmitDetail) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await SubmitDetail();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: done_btn_width,
            height: done_btn_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Done',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
