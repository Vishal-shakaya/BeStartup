import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberInfoForm.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDetailForm.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberProfileImage.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/DialogComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

Uint8List? image;
String filename = '';
String upload_image_url = '';
late UploadTask? upload_process;

class TeamMemberDialog extends StatefulWidget {
  var context;

  bool? is_editable = false;
  bool? info_dialog = false;

  TeamMemberDialog({this.context, this.is_editable, this.info_dialog, Key? key})
      : super(key: key);

  @override
  State<TeamMemberDialog> createState() => _TeamMemberDialogState();
}

class _TeamMemberDialogState extends State<TeamMemberDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  final formKey2 = GlobalKey<FormBuilderState>();
  int maxlines = 7;
  double con_button_width = 90;
  double con_button_height = 38;
  double con_btn_top_margin = 10;
  // double formsection_width = 0.35;
  // double formsection_height = 0.41;

//////////////////////////////////
  // SUBMIT  FORM :
  // HANDLE TWO FORMS : 
  // 1. MEMBER INFO [ DESCRIPTION ]: 
  // 2. MEMEBER DETAIL : 
//////////////////////////////////
  SubmitMemberDetail() async {
    formKey.currentState!.save();
    formKey2.currentState!.save();
    if (formKey.currentState!.validate() && formKey.currentState!.validate()) {
      String name = formKey.currentState!.value['name'];
      String position = formKey.currentState!.value['position'];
      String email = formKey.currentState!.value['email'];

      // Info form values;
      String meminfo = formKey2.currentState!.value['meminfo'];

      // Testing
      print(name);
      print(position);
      print(email);
      print('second form : ${meminfo}');

      formKey.currentState!.reset();
      formKey2.currentState!.reset();
    } else {
      print('error found');
    }
  }

  ResetForm() {
    formKey.currentState!.reset();
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
      widthFactor: 0.8,
      heightFactor: 0.55,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),

              // HEADING :
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: AutoSizeText.rich(TextSpan(
                          style: Get.theme.textTheme.headline2,
                          children: [TextSpan(text: 'Define Milestone')])),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        // CloseMilestoneDialog();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.blueGrey.shade800,
                      ))
                ],
              ),

              // TEAM MEMEBER PROFILE IAMGE SECTION
              Container(
                  child: Row(
                children: [
                  Expanded(flex: 5, child: TeamMemberProfileImage()),
                  Expanded(
                      flex: 5,
                      child: TeamMemberDetailForm(
                        formkey: formKey,
                        ResetForm: ResetForm,
                      ))
                ],
              )),

              // MEMBER DETAIL SECTION :
              Container(
                  child: Row(
                children: [
                  MemberInfoForm(
                    formkey: formKey2,
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
