import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/StartupInvestor/StartupInvestorStore.dart';
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
  double con_button_width = 100;
  double con_button_height = 30;

  double con_btn_top_margin = 5;
  double con_btn_btttom_margin = 10;
  double cont_btn_radius = 20;
  double cont_btn_elevation = 10;
  double cont_btn_fontSize = 16; 
  double cont_btn_letterSpace= 2.5; 

  double width_factor = 0.9;
  double height_factor = 0.65;

  double dialog_padd = 15;

  double top_spacer = 10;

  int image_flex = 5;
  int desc_flex = 5;

  // double formsection_width = 0.35;
  // double formsection_height = 0.41;

/////////////////////////////////////////////////////
  // SUBMIT  FORM :
  // HANDLE TWO FORMS :
  // 1. MEMBER INFO [ DESCRIPTION ]:
  // 2. MEMEBER DETAIL :
/////////////////////////////////////////////////////
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
      if (widget.form_type == InvestorFormType.edit) {
        await startupInvestorStore.SetProfileImage(
            image: widget.member['image'] ?? '');

        res = await startupInvestorStore.UpdateInvestor(
            inv_obj: temp_investor, inv_id: widget.member['id']);
      }

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

     maxlines = 7;
     con_button_width = 100;
     con_button_height = 33;

     con_btn_top_margin = 5;
     con_btn_btttom_margin = 10;
     cont_btn_radius = 20;
     cont_btn_elevation = 10;
     cont_btn_fontSize = 16; 
     cont_btn_letterSpace= 2.5; 

     width_factor = 0.9;
     height_factor = 0.65;

     dialog_padd = 15;

     top_spacer = 10;

     image_flex = 5;
     desc_flex = 5;


		// DEFAULT :
    if (context.width > 1700) {
        maxlines = 7;
        con_button_width = 100;
        con_button_height = 33;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 16; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 0.9;
        height_factor = 0.65;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 5;
        desc_flex = 5;
        print('Greator then 1700');
      }
  
    if (context.width < 1700) {
        maxlines = 7;
        con_button_width = 100;
        con_button_height = 33;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 16; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 0.9;
        height_factor = 0.65;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 5;
        desc_flex = 5;
      print('1700');
      }
  
    if (context.width < 1600) {
      print('1600');
      }

    // PC:
    if (context.width < 1500) {
        maxlines = 7;
        con_button_width = 100;
        con_button_height = 33;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 16; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 0.9;
        height_factor = 0.65;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 5;
        desc_flex = 5;
      print('1500');
      }

    if (context.width < 1200) {
      print('1200');
      }
    
    if (context.width < 1000) {
        maxlines = 7;
        con_button_width = 100;
        con_button_height = 33;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 16; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 0.9;
        height_factor = 0.65;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 4;
        desc_flex = 5;
      print('1000');
      }

    // TABLET :
    if (context.width < 800) {
      print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
        maxlines = 7;
        con_button_width = 90;
        con_button_height = 30;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 14; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 0.9;
        height_factor = 0.57;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 4;
        desc_flex = 5;
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
        maxlines = 7;
        con_button_width = 90;
        con_button_height = 30;

        con_btn_top_margin = 5;
        con_btn_btttom_margin = 10;
        cont_btn_radius = 20;
        cont_btn_elevation = 10;
        cont_btn_fontSize = 14; 
        cont_btn_letterSpace= 2.5; 

        width_factor = 1;
        height_factor = 0.80;

        dialog_padd = 15;

        top_spacer = 10;

        image_flex = 4;
        desc_flex = 5;
      print('480');
      }

  Widget mainHeaderForm =  Row(
                children: [
                  // IMAGE SECTION :
                  Expanded(
                      flex: image_flex,
                      child: widget.form_type == InvestorFormType.create
                          ? InvestorProfileImage()
                          : InvestorProfileImage(
                              member_image: widget.member['image'],
                              form_type: InvestorFormType.edit,
                            )),

                  // DETAIL SECTION :
                  Expanded(
                      flex: desc_flex,
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
              ); 
  Widget phoneHeaderForm =  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IMAGE SECTION :
                  widget.form_type == InvestorFormType.create
                      ? InvestorProfileImage()
                      : InvestorProfileImage(
                          member_image: widget.member['image'],
                          form_type: InvestorFormType.edit,
                        ),

                  // DETAIL SECTION :
                  widget.form_type == InvestorFormType.create
                      ? InvestorDetialForm(
                          formkey: formKey,
                          ResetForm: ResetForm,
                        )
                      : InvestorDetialForm(
                          formkey: formKey,
                          ResetForm: ResetForm,
                          form_type: InvestorFormType.edit,
                          member: widget.member,
                        )
                ],
              ); 



  if (context.width < 480) {
      mainHeaderForm = phoneHeaderForm; 
      print('480');
      }
    ///////////////////////////////////////////////////////
    /// 1. MILESTONE DIALOG :
    /// 2. MILESTONE FORM : Take Title and Description:
    /////////////////////////////////////////////////////
    return FractionallySizedBox(
      widthFactor: width_factor,
      heightFactor: height_factor,
      
      child: Container(
        padding: EdgeInsets.all(dialog_padd),
        decoration:  BoxDecoration(
          color: my_theme_container_color,
        ),
      
        child: Scaffold(
          backgroundColor: my_theme_container_color,
          body: SingleChildScrollView(
            
            child: Column(children: [
           
              SizedBox(
                height: top_spacer,
              ),

           
              // TEAM MEMEBER PROFILE IAMGE SECTION
              Container(
                  child:mainHeaderForm
              ),

           
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

                  // CONTINUE BUTTON :
                  Container(
                    margin: EdgeInsets.only(
                        top: con_btn_top_margin, bottom: con_btn_btttom_margin),
                    child: InkWell(
                      highlightColor: primary_light_hover,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(cont_btn_radius),
                          right: Radius.circular(cont_btn_radius)),
                      onTap: () async {
                        await SubmitMemberDetail();
                      },
                      child: Card(
                        elevation: cont_btn_elevation,
                        shadowColor: light_color_type3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(cont_btn_radius))),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: con_button_width,
                          height: con_button_height,
                          decoration: BoxDecoration(
                              color: primary_light,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(cont_btn_radius),
                                  right: Radius.circular(cont_btn_radius))),
                          child: Text(
                            widget.form_type == InvestorFormType.create
                                ? 'Done'
                                : 'Update',
                          
                            style:  TextStyle(
                                letterSpacing: cont_btn_letterSpace,
                                color: Colors.white,
                                fontSize: cont_btn_fontSize,
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
