import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/StartupInvestor/CreateTeamStore.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/InvestorFormDetail.dart';

import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/InvestorInfoForm.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/InvestorProfile.dart';

import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Uint8List? image;
String filename = '';
String upload_image_url = '';
late UploadTask? upload_process;

class InvestorDialog extends StatefulWidget {
  InvestorFormType? form_type;
  var member;
  int? index;

  InvestorDialog({this.index, this.member, this.form_type, Key? key})
      : super(key: key);

  @override
  State<InvestorDialog> createState() => _TeamMemberDialogState();
}

class _TeamMemberDialogState extends State<InvestorDialog> {
  var startupInvestorStore = Get.put(StartupInvestorStore());

  var startupState = Get.put(
    StartupDetailViewState(),
  );

  final formKey = GlobalKey<FormBuilderState>();
  final formKey2 = GlobalKey<FormBuilderState>();
  var my_context = Get.context;

  int maxlines = 7;
  double con_button_width = 55;
  double con_button_height = 30;
  double con_btn_top_margin = 5;

  // double formsection_width = 0.35;
  // double formsection_height = 0.41;

//////////////////////////////////
  // SUBMIT  FORM :
  // HANDLE TWO FORMS :
  // 1. MEMBER INFO [ DESCRIPTION ]:
  // 2. MEMEBER DETAIL :
//////////////////////////////////
  SubmitMemberDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final startup_id = await startupState.GetStartupId();
    print('Startrup id $startup_id');

    // STARTING LOADING :
    formKey.currentState!.save();
    formKey2.currentState!.save();

    if (formKey.currentState!.validate() && formKey2.currentState!.validate()) {
      SmartDialog.showLoading(
          background: Colors.white,
          maskColorTemp: Color.fromARGB(146, 252, 250, 250),
          widget: const CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ));

      final name = formKey.currentState!.value['name'];
      final position = formKey.currentState!.value['position'];
      final email = formKey.currentState!.value['email'];
      // Info form values;
      final info = formKey2.currentState!.value['info'];

      // Testing
      print(name);
      print(position);
      print(email);
      print('second form : ${info}');

      Map<String, dynamic> temp_investor = {
        'name': name,
        'position': position,
        'email': email,
        'info': info,
      };

      var res;
      if (widget.form_type == InvestorFormType.edit) {}

      if (widget.form_type == InvestorFormType.create) {
        print('Create Investor');

        res = await startupInvestorStore.CreateInvestor(
            inv_obj: temp_investor, startup_id: startup_id);
      }

      print(res);
      if (res['response']) {
        formKey.currentState!.reset();
        formKey2.currentState!.reset();

        SmartDialog.dismiss();
        Navigator.of(context).pop();
      }

      if (!res['response']) {
        // CLOSE SNAKBAR :
        Get.closeAllSnackbars();
        Get.showSnackbar(
            MyCustSnackbar(type: MySnackbarType.error, width: snack_width));
      }
    } else {
      print('Invalid form');
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
          type: MySnackbarType.error,
          title: 'Invalid Form ',
          width: snack_width));
    }
  }

  // RESET FORM :
  ResetForm(field) {
    print(field);
    formKey.currentState!.fields[field]!.didChange('');
  }

  // CLOSE DIALOG :
  CloseDialog(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    /// RESPONSIVE BREAK  POINTS :
    /// DEFAULT 1500 :
    /// ///////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      con_button_width = 90;
      con_button_height = 38;
      con_btn_top_margin = 10;
      // formsection_width = 0.35;
      // formsection_height = 0.41;
      maxlines = 7;
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      maxlines = 6;
      con_btn_top_margin = 7;
      // formsection_height = 0.55;
      print('1500');
    }

    if (context.width < 1200) {
      // formsection_width = 0.35;
      // formsection_height = 0.50;
      maxlines = 5;
      con_button_width = 90;
      con_button_height = 34;
      con_btn_top_margin = 5;
      print('1200');
    }

    if (context.width < 1000) {
      // formsection_height = 0.70;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      maxlines = 4;
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      maxlines = 3;
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }
    ///////////////////////////////////////////////////////
    /// 1. MILESTONE DIALOG :
    /// 2. MILESTONE FORM : Take Title and Description:
    /////////////////////////////////////////////////////
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.60,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),

              // TEAM MEMEBER PROFILE IAMGE SECTION
              Container(
                  child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: widget.form_type == InvestorFormType.create
                          ? InvestorProfileImage()
                          : InvestorProfileImage(
                              member_image: widget.member['image'],
                              form_type: InvestorFormType.edit,
                            )),
                  Expanded(
                      flex: 5,
                      child: widget.form_type == InvestorFormType.create
                          ? InvestorDetialForm(
                              formkey: formKey,
                              ResetForm: ResetForm,
                            )
                          : InvestorDetialForm(
                              formkey: formKey,
                              ResetForm: ResetForm,
                              form_type: InvestorFormType.edit,
                              member: widget.member,
                            ))
                ],
              )),

              // MEMBER DETAIL SECTION :
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      widget.form_type == InvestorFormType.create
                          ? InvestorInfoForm(
                              formkey: formKey2,
                            )
                          : InvestorInfoForm(
                              formkey: formKey2,
                              form_type: InvestorFormType.edit,
                              member: widget.member,
                            ),
                    ],
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: con_btn_top_margin, bottom: 10),
                    child: InkWell(
                      highlightColor: primary_light_hover,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      onTap: () async {
                        await SubmitMemberDetail();
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: light_color_type3,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: con_button_width,
                          height: con_button_height,
                          decoration: BoxDecoration(
                              color: primary_light,
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20))),
                          child: Text(
                            widget.form_type == InvestorFormType.create
                                ? 'Done'
                                : 'Update',
                            style: const TextStyle(
                                letterSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
