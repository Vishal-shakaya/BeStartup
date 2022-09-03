import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/DialogComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MileStoneDialog extends StatefulWidget {
  var context;
  var formKey;
  Function? ResetMileForm;
  Function? SubmitMileForm;
  Function? CloseMilestoneDialog;
  String? milestone_title = '';
  String? milestone_description = '';
  bool? is_editable = false;
  bool? info_dialog = false;

  MileStoneDialog(
      {this.context,
      this.formKey,
      this.ResetMileForm,
      this.SubmitMileForm,
      this.CloseMilestoneDialog,
      this.milestone_title,
      this.milestone_description,
      this.is_editable,
      this.info_dialog,
      Key? key})
      : super(key: key);

  @override
  State<MileStoneDialog> createState() => _MileStoneDialogState();
}

class _MileStoneDialogState extends State<MileStoneDialog> {
  int maxlines = 7;
  double con_button_width = 90;

  double con_button_height = 38;
  double con_btn_top_margin = 10;

  double formsection_width = 0.35;
  double formsection_height = 0.41;

  double mile_width_fraction = 0.55;
  double mile_height_fraction = 0.45;

  double submit_btn_fontSize = 16;

  double mile_dialog_titile_fontSize = 18; 
  double mile_dialog_desc_fontSize = 16; 
  
  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    /// RESPONSIVE BREAK  POINTS :
    /// DEFAULT 1500 :
    /// ///////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      mile_dialog_titile_fontSize = 18; 
      mile_dialog_desc_fontSize = 16; 

      mile_width_fraction = 0.55;
      mile_height_fraction = 0.60;

      con_button_width = 90;
      con_button_height = 38;
      con_btn_top_margin = 10;

      formsection_width = 0.40;
      formsection_height = 0.41;
      maxlines = 7;
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      mile_dialog_titile_fontSize = 16; 
      mile_dialog_desc_fontSize = 14; 

      maxlines = 6;
      con_btn_top_margin = 7;
      formsection_height = 0.55;

      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;
      print('1500');
    }

    if (context.width < 1200) {
      mile_dialog_titile_fontSize = 16; 
      mile_dialog_desc_fontSize = 14;
      formsection_width = 0.45;
      formsection_height = 0.41;
      maxlines = 7;

      con_button_width = 90;
      con_button_height = 34;
      con_btn_top_margin = 5;

      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;
      print('1200');
    }

    if (context.width < 1000) {
      formsection_width = 0.49;
      formsection_height = 0.45;
      mile_dialog_titile_fontSize = 16; 
      mile_dialog_desc_fontSize = 14;

      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;
      maxlines = 7;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      mile_dialog_titile_fontSize = 15; 
      mile_dialog_desc_fontSize = 13;
      
      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;
      maxlines = 8;
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      mile_dialog_titile_fontSize = 15; 
      mile_dialog_desc_fontSize = 12;

      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;

      formsection_width = 0.55;
      formsection_height = 0.45;
      maxlines = 6;
    }

    // PHONE:
    if (context.width < 480) {
      mile_dialog_titile_fontSize = 15; 
      mile_dialog_desc_fontSize = 12;

      formsection_width = 0.55;
      formsection_height = 0.45;

      mile_width_fraction = 0.99;
      mile_height_fraction = 0.65;
      maxlines = 6;

      con_button_width = 80;
      con_button_height = 38;
      con_btn_top_margin = 15;

      submit_btn_fontSize = 14;
      print('480');
    }
    ///////////////////////////////////////////////////////
    /// 1. MILESTONE DIALOG :
    /// 2. MILESTONE FORM : Take Title and Description:
    /////////////////////////////////////////////////////
    return FractionallySizedBox(
      widthFactor: mile_width_fraction,
      heightFactor: mile_height_fraction,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.transparent),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // ADD MILESTONE FORM :
                  FormBuilder(
                      key: widget.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Container(
                        width: context.width * formsection_width,
                        height: context.height * formsection_height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // SPACER :
                              const SizedBox(
                                height: 20,
                              ),

                              /// MILESTONE TAG INPUT FIELD
                              MilestoneTagInput(
                                  context: context,
                                  ResetMileForm: widget.ResetMileForm,
                                  default_title: widget.milestone_title,
                                  mile_dialog_titile_fontSize: mile_dialog_titile_fontSize,
                                  info_dialog: widget.info_dialog),

                              // SPACER :
                              const SizedBox(
                                height: 40,
                              ),

                              // DESCRIPTION INPUT FIELD
                              MilestoneDescInput(
                                  context: context,
                                  maxlines: maxlines,
                                  mile_dialog_desc_fontSize: mile_dialog_desc_fontSize,
                                  default_description:widget.milestone_description,
                                  info_dialog: widget.info_dialog),

                              /// SUBMIT BUTTON
                              MilestoneDialogSubmitButton(
                                  SubmitMileForm: widget.SubmitMileForm,
                                  con_btn_top_margin: con_btn_top_margin,
                                  con_button_height: con_button_height,
                                  
                                  submit_btn_fontSize: submit_btn_fontSize,
                                  con_button_width: con_button_width)
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
