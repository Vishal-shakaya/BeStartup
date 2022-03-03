
import 'package:be_startup/Backend/Startup/MileStoneStore.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/MileStoneDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

enum AlertType {
  error,
  success,
}

/////////////////////////////////
/// ADD MILE STONE :
/////////////////////////////////
class AddMileButton extends StatefulWidget {
  AddMileButton({Key? key}) : super(key: key);

  @override
  State<AddMileButton> createState() => _AddMileButtonState();
}

class _AddMileButtonState extends State<AddMileButton> {
  final formKey = GlobalKey<FormBuilderState>();
  Color suffix_icon_color = Colors.blueGrey.shade300;
  int maxlines = 7;
  double addbtn_top_margin = 0.05;

  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');


  ////////////////////////////////////
  /// ADD MILE STONE :
  /// 1.Tag filed  max char 50 allow:
  /// 2.Description filed :
  ////////////////////////////////////
  AddMileStone() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        // title:  MileDialogHeading(context),
        content: SizedBox(
          width: 900, 
          child: MileStoneDialog(
            key:UniqueKey(),
            context: context,
            formKey: formKey, 
            ResetMileForm: ResetMileForm,
            SubmitMileForm: SubmitMileForm,
            CloseMilestoneDialog:CloseMilestoneDialog, 
            info_dialog: false,
            is_editable: false,

          )),
      ));
  }

  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////
  SubmitMileForm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      print('form submited');
      final mile_tag = formKey.currentState!.value['mile_tag'];
      final mile_desc = formKey.currentState!.value['mile_desc'];

      // Add Milestone :
      var res = mileStore.AddMileStone(title: mile_tag, description: mile_desc);
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


// MAIN METHOD :
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.height * addbtn_top_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(flex: 1, child: Container()),
          Container(
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(primary_light)),
                  onPressed: () {
                    AddMileStone();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add')))
        ],
      ),
    );
  }

}
