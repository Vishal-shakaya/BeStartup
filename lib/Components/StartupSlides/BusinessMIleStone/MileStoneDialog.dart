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
        formsection_width = 0.35;
        formsection_height = 0.41;
        maxlines = 7; 
      print('greator then 1500');
  
    }

    // PC:
    if (context.width < 1500) {
      maxlines = 6; 
      con_btn_top_margin = 7;
      formsection_height = 0.55; 
      print('1500');
    }

    if (context.width < 1200) {
      formsection_width = 0.35;
      formsection_height = 0.50; 
      maxlines = 5; 
      con_button_width = 90;
      con_button_height = 34;
      con_btn_top_margin = 5;
      print('1200');}

    if (context.width < 1000) {
        formsection_height = 0.70; 
      print('1000');}

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
    if (context.width < 480) {print('480');}
    ///////////////////////////////////////////////////////
    /// 1. MILESTONE DIALOG :
    /// 2. MILESTONE FORM : Take Title and Description:
    /////////////////////////////////////////////////////
    return FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.55,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
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
                                  info_dialog: widget.info_dialog),

                              // SPACER :
                              const SizedBox(
                                height: 40,
                              ),

                              // DESCRIPTION INPUT FIELD
                              MilestoneDescInput(
                                  context: context,
                                  maxlines: maxlines,
                                  default_description:
                                      widget.milestone_description,
                                  info_dialog: widget.info_dialog),

                              /// SUBMIT BUTTON
                              MilestoneDialogSubmitButton(
                                  SubmitMileForm: widget.SubmitMileForm,
                                  con_btn_top_margin: con_btn_top_margin,
                                  con_button_height: con_button_height,
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
