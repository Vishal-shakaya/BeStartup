import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessMileStoneStore.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/MileStoneDialog.dart';
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
  var my_context = Get.context;
  Color mil_default_text_color = Colors.black;
  Color mil_activate_text_color = Colors.teal.shade300;
  Color mil_deactivate_text_color = Colors.black;

  final formKey = GlobalKey<FormBuilderState>();
  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');

  double milestone_width = 900;
  double milestone_height = 900;

  double milestone_tile_width = 0.70;
  double mile_fontSize = 18;

  double mile_icon_fontSize = 20;

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    /// RESPONSIVE BREAK  POINTS :
    /// DEFAULT 1500 :
    /// ///////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      print('greator then 1500');
      milestone_width = 900;
      milestone_tile_width = 0.70;
      mile_fontSize = 18;
      mile_icon_fontSize = 20;
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      mile_fontSize = 17;
      mile_icon_fontSize = 18;
      print('1200');
    }

    if (context.width < 1000) {
      mile_fontSize = 17;
      mile_icon_fontSize = 17;
      milestone_width = 1100;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
      milestone_width = 1200;
      mile_fontSize = 16;
      mile_icon_fontSize = 16;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      milestone_width = 1400;
      mile_fontSize = 15;
      mile_icon_fontSize = 15;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      mile_fontSize = 14;
      mile_icon_fontSize = 15;
      milestone_width = 1400;
      print('480');
    }

    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.symmetric(vertical: 10),

      // Decoration:
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.horizontal(
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
            // MileStoneInfo();
          },
          shape: const RoundedRectangleBorder(
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
              child: AutoSizeText(
                '${widget.milestone!['title']}',
                  style: GoogleFonts.robotoSlab(
                    color: mil_default_text_color,
                    fontSize: mile_fontSize,
                    
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true, 
                  )),

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
          size: mile_icon_fontSize,
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
          size: mile_icon_fontSize,
        ),
      ),
    );
  }

  /////////////////////////////////////////////
  // Show Mile Stone info in dialog box :
  /////////////////////////////////////////////

  ShowMileStoneDialog({info_dialog}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              title: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close))),
              content: SizedBox(
                  width: milestone_width,
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
                      info_dialog: info_dialog)),
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
  ErrorSnakbar() {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      margin: EdgeInsets.only(top: 10),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.shade50,
      titleText: MySnackbarTitle(title: 'Error'),
      messageText: MySnackbarContent(message: 'Something went wrong'),
      maxWidth: context.width * 0.50,
    );
  }

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
      }
      // Show error dialog :
      if (!res['response']) {
        ErrorSnakbar();
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
          title: Text('successfull'),
          controller: DialogController());
    }
    if (alert_type == AlertType.error) {
      dialog = StylishDialog(
          context: context,
          alertType: StylishDialogType.ERROR,
          title: Text('Error'),
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
}
