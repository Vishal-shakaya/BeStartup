import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/MileStoneStore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/MileStoneDialog.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

enum AlertType {
  error,
  success,
}

class MileStoneTag extends StatefulWidget {
  Map<String, dynamic>? milestone;
  int? index;
  MileStoneTag({this.index, this.milestone, Key? key}) : super(key: key);

  @override
  State<MileStoneTag> createState() => _MileStoneTagState();
}

class _MileStoneTagState extends State<MileStoneTag> {
  Color mil_default_text_color = Colors.black;
  Color mil_activate_text_color = Colors.teal.shade300;
  Color mil_deactivate_text_color = Colors.black;
  final formKey = GlobalKey<FormBuilderState>();

  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');
  /////////////////////////////////////////////
  // Show Mile Stone info in dialog box :
  /////////////////////////////////////////////

  ShowMileStoneDialog({info_dialog}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          alignment: Alignment.center,
          // title:  MileDialogHeading(context),
          content: SizedBox(
              width: 900,
              child: MileStoneDialog(
                key: UniqueKey(),
                context: context,
                formKey: formKey,
                ResetMileForm: ResetMileForm,
                SubmitMileForm: SubmitMileForm,
                CloseMilestoneDialog: CloseMilestoneDialog,
                milestone_title: widget.milestone!['title'],
                milestone_description: widget.milestone!['description'],
                is_editable: true,
                info_dialog:info_dialog
              )),
        ));
  }

  ////////////////////////////////////
  ///   EDIT MILE STONE DIALOG : 
  /// //////////////////////////////////
  EditMileStoneDialog() {
    ShowMileStoneDialog(info_dialog: false);
  }

  //////////////////////////////////////
  ///  SHOW INFO DIALOG OF MILE STONE : 
  /// //////////////////////////////////
    MileStoneInfo() {
      ShowMileStoneDialog(info_dialog: true);
    }

  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////
  SubmitMileForm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      final mile_tag = formKey.currentState!.value['mile_tag'];
      final mile_desc = formKey.currentState!.value['mile_desc'];

      // Add Milestone :
      var res = mileStore.EditMileStone(
          index: widget.index, title: mile_tag, description: mile_desc);
      // Show success dialog :
      if (res['response']) {
        formKey.currentState!.reset();
        Navigator.of(context).pop();
        ResultAlert(AlertType.success);
      }
      // Show error dialog :
      if (!res['response']) {
        ResultAlert(AlertType.error);
      }
    }
  }

  /// RESET FORM :
  ResetMileForm() {
    formKey.currentState!.reset();
  }

  // Close dialog :
  CloseMilestoneDialog() {
    Navigator.of(context).pop();
  }


  // RESULT ALERT AFTER OPERATION COMPLETE ;
  // 1 ADD OR DELET
  ResultAlert(alert_type) async {
    var dialog;
    if (alert_type == AlertType.success) {
      dialog = StylishDialog(
          context: context,
          alertType: StylishDialogType.SUCCESS,
          titleText: 'successfull',
          controller: DialogController());
    }
    if (alert_type == AlertType.error) {
      dialog = StylishDialog(
          context: context,
          alertType: StylishDialogType.ERROR,
          titleText: 'Error',
          controller: DialogController());
    }

    dialog.show();
    await Future.delayed(Duration(seconds: 1));
    dialog.dismiss();
  }

  /////////////////////////////////////////////
  // Delete Mile Stone
  /////////////////////////////////////////////
  DeleteMileStone(id) {
    final res = mileStore.DeleteMileStone(id);
    if (res['response']) {
      print('successs');
    }
    if (!res['response']) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.symmetric(vertical: 10),

      // Decoration:
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          )),
      child: MouseRegion(
        onHover: (_) {
          setState(() {
            mil_default_text_color = mil_activate_text_color;
          });
        },
        onExit: (_) {
          setState(() {
            mil_default_text_color = mil_deactivate_text_color;
          });
        },
        child: ListTile(
          key: UniqueKey(),
          onTap: () {
            MileStoneInfo();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          )),
          selectedColor: Colors.blue.shade50,
          hoverColor: Colors.blue.shade50,
          focusColor: Colors.teal.shade50,
          selectedTileColor: Colors.teal.shade50,

          // Tile Style :
          style: ListTileStyle.drawer,

          // Heading text:
          title: Container(
              padding: EdgeInsets.all(10),
              child: AutoSizeText('${widget.milestone!['title']}',
                  style: GoogleFonts.robotoSlab(
                    color: mil_default_text_color,
                  ))),

          // Edit and Delte Button :
          trailing: Wrap(
            children: [
              // EDIT ICION :
              EditMileStoneButton(),
              DeleteMileStoneButton()
            ],
          ),
        ),
      ),
    );
  }

  InkWell DeleteMileStoneButton() {
    return InkWell(
      onTap: () {
        DeleteMileStone(widget.milestone!['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.cancel,
          color: Colors.red.shade400,
          size: 20,
        ),
      ),
    );
  }

  InkWell EditMileStoneButton() {
    return InkWell(
      onTap: () {
        EditMileStoneDialog();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.edit,
          color: Colors.blue.shade400,
          size: 20,
        ),
      ),
    );
  }
}
