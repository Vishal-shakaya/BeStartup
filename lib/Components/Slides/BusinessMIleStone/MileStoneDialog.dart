import 'package:be_startup/Components/Slides/BusinessMIleStone/DialogComponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MileStoneDialog extends StatefulWidget {
  var context;
  var formKey;
  Function? ResetMileForm;
  Function? SubmitMileForm;
  Function? CloseMilestoneDialog;
  String? milestone_title='';
  String? milestone_description='';
  bool? is_editable=false; 
  bool? info_dialog=false; 

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

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  // HEADING :
                  MileDialogHeading(context, widget.CloseMilestoneDialog),

                  // ADD MILESTONE FORM :
                  FormBuilder(
                      key: widget.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Container(
                        width: context.width * 0.35,
                        height: context.height * 0.41,
                        child: Column(
                          children: [
                            // SPACER :
                            SizedBox(
                              height: 20,
                            ),

                            /// MILESTONE TAG INPUT FIELD
                            MilestoneTagInput(
                              context:context, 
                              ResetMileForm:widget.ResetMileForm,
                              default_title:widget.milestone_title, 
                             info_dialog:widget.info_dialog),

                            // SPACER :
                            SizedBox(
                              height: 40,
                            ),

                            // DESCRIPTION INPUT FIELD
                            MilestoneDescInput(
                              context:context, 
                              maxlines:maxlines,
                              default_description: widget.milestone_description ,
                              info_dialog:widget.info_dialog ),

                            /// SUBMIT BUTTON
                            MilestoneDialogSubmitButton(
                                SubmitMileForm: widget.SubmitMileForm,
                                con_btn_top_margin: con_btn_top_margin,
                                con_button_height: con_button_height,
                                con_button_width: con_button_width)
                          ],
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
