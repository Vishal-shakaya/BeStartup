import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/FounderImage.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/RegistorFounderForm.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistorFounderBody extends StatefulWidget {
  const RegistorFounderBody({Key? key}) : super(key: key);

  @override
  State<RegistorFounderBody> createState() => _RegistorFounderBodyState();
}

class _RegistorFounderBodyState extends State<RegistorFounderBody> {
  var founderStore = Get.put(BusinessFounderStore(), tag: 'founder');
  var founderConnector = Get.put(FounderConnector(), tag: 'founder_connector');
  var updateStore = Get.put(StartupUpdater(), tag: 'update_store');
  final formKey = GlobalKey<FormBuilderState>();
  var my_context = Get.context;

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;

  /////////////////////////////////////////
  // CREATE FOUNDER  FORM :
  /////////////////////////////////////////
  SubmitFounderDetail() async {
    MyCustPageLoadingSpinner();

    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      final String founder_name = formKey.currentState!.value['founder_name'];
      final String founder_position =
          formKey.currentState!.value['founder_position'];
      final String phone_no = formKey.currentState!.value['phone_no'];
      final String email = formKey.currentState!.value['email'];
      final String other_contact = formKey.currentState!.value['other_info'];

      Map<String, dynamic> founder = {
        'name': founder_name,
        'position': founder_position,
        'phone_no': phone_no,
        'email': email,
        'other_contact': other_contact
      };
      final res = await founderStore.CreateFounder(founder);

      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        SmartDialog.dismiss();
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: res['message'],
            message: create_error_msg));
      } else {
        CloseCustomPageLoadingSpinner();
        SmartDialog.dismiss();
        formKey.currentState!.reset();
        // Redirect to team page:
        Get.toNamed(create_business_team);
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
      final String founder_position =
          formKey.currentState!.value['founder_position'];
      final String phone_no = formKey.currentState!.value['phone_no'];
      final String email = formKey.currentState!.value['email'];
      final String other_contact = formKey.currentState!.value['other_info'];

      Map<String, dynamic> founder = {
        'name': founder_name,
        'position': founder_position,
        'phone_no': phone_no,
        'email': email,
        'other_contact': other_contact
      };
      final res = await founderStore.CreateFounder(founder);
      final update_resp = await founderConnector.UpdateFounderDetail();

      if (res['response']) {
        // Update Success Handler :
        if (update_resp['response']) {
          CloseCustomPageLoadingSpinner();
          SmartDialog.dismiss();
          formKey.currentState!.reset();
          Get.toNamed(create_business_team);
        }

        // Update Error Handler :
        if (!update_resp['response']) {
          CloseCustomPageLoadingSpinner();
          SmartDialog.dismiss();
          Get.closeAllSnackbars();
          Get.showSnackbar(MyCustSnackbar(
              width: snack_width,
              type: MySnackbarType.error,
              title: res['message'],
              message: update_error_msg));
        }
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

/////////////////////////////////////
  /// SET PAGE DEFAULT STATE :
/////////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    pageParam = Get.parameters;
    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: context.height * 0.7,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  // UPLOAD FOUNDER IMAGE :
                  FounderImage(),

                  // REGISTRATION FORM :
                  RegistorFounderForm(
                    formKey: formKey,
                  )
                ],

                // BOTTOM NAVIGATION:
              ),
            )),
        updateMode == true
            ? UpdateButton(context)
            : TeamSlideNav(
                submitform: SubmitFounderDetail,
                slide: TeamSlideType.founder,
              )
      ],
    );
  }

  ////////////////////////////////////
  /// External Method :
  ////////////////////////////////////
  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdateFounderDetail();
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
              'Update',
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
