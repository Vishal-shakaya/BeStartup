import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberInfoForm.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDetailForm.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberProfileImage.dart';
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

class TeamMemberDialog extends StatefulWidget {
  MemberFormType? form_type;
  var member;
  int? index;

  TeamMemberDialog({this.index, this.member, this.form_type, Key? key})
      : super(key: key);

  @override
  State<TeamMemberDialog> createState() => _TeamMemberDialogState();
}

class _TeamMemberDialogState extends State<TeamMemberDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  final formKey2 = GlobalKey<FormBuilderState>();
  int maxlines = 7;
  double con_button_width = 55;
  double con_button_height = 30;
  double con_btn_top_margin = 10;
  // double formsection_width = 0.35;
  // double formsection_height = 0.41;

  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');

//////////////////////////////////
  // SUBMIT  FORM :
  // HANDLE TWO FORMS :
  // 1. MEMBER INFO [ DESCRIPTION ]:
  // 2. MEMEBER DETAIL :
//////////////////////////////////
  SubmitMemberDetail() async {
    // STARTING LOADING :
    formKey.currentState!.save();
    formKey2.currentState!.save();

    if (formKey.currentState!.validate() && formKey2.currentState!.validate()) {
      SmartDialog.showLoading(
          background: Colors.white,
          maskColorTemp: Color.fromARGB(146, 252, 250, 250),
          widget: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ));

      String name = formKey.currentState!.value['name'];
      String position = formKey.currentState!.value['position'];
      String email = formKey.currentState!.value['email'];

      // Info form values;
      String meminfo = formKey2.currentState!.value['meminfo'];

      // Testing
      // print(name);
      // print(position);
      // print(email);
      // print('second form : ${meminfo}');
      Map<String, dynamic> member = {
        'name': name,
        'position': position,
        'email': email,
        'meminfo': meminfo,
      };

      var res;
      if (widget.form_type == MemberFormType.edit) {
        print('update member profile index ${widget.index}');
        res = await memeberStore.UpdateTeamMember(member, widget.index);
      } else {
        res = await memeberStore.CreateTeamMember(member);
      }

      if (!res['response']) {
        // CLOSE SNAKBAR :
        Get.closeAllSnackbars();
        // Error Alert :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Error  accure'),
          messageText: MySnackbarContent(message: 'Something went wrong'),
          maxWidth: context.width * 0.50,
        );
      }

      formKey.currentState!.reset();
      formKey2.currentState!.reset();

      SmartDialog.dismiss();
      Navigator.of(context).pop();
    } else {
      // CLOSE SNAKBAR :
      Get.closeAllSnackbars();
      // Error Alert :
      Get.snackbar(
        '',
        '',
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Form Validation Error'),
        messageText: MySnackbarContent(message: 'Check required field'),
        maxWidth: context.width * 0.50,
      );
    }
  }

  // RESET FORM :
  ResetForm() {
    formKey.currentState!.reset();
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
      widthFactor: 0.8,
      heightFactor: 0.60,
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
                        CloseDialog(context);
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
                  Expanded(
                      flex: 5,
                      child: widget.form_type== MemberFormType.create?
                       TeamMemberProfileImage()
                    
                      : TeamMemberProfileImage(
                        member_image:widget.member['image'],
                        form_type: MemberFormType.edit,
                      )),

                  Expanded(
                      flex: 5,
                      child: widget.form_type== MemberFormType.create?  
                      TeamMemberDetailForm(
                        formkey: formKey,
                        ResetForm: ResetForm,
                      )
                      :TeamMemberDetailForm(
                        formkey: formKey,
                        ResetForm: ResetForm,
                        form_type: MemberFormType.edit,
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
                      widget.form_type== MemberFormType.create?
                      MemberInfoForm(
                        formkey: formKey2,
                      )
                      
                      : MemberInfoForm(
                        formkey: formKey2,
                        form_type: MemberFormType.edit,
                        member: widget.member,
                      ),
                    ],
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
                    child: InkWell(
                      highlightColor: primary_light_hover,
                      borderRadius: BorderRadius.horizontal(
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
                          child: const Text(
                            'Done',
                            style: TextStyle(
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
