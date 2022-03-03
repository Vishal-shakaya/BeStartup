import 'package:stylish_dialog/stylish_dialog.dart';
 enum AlertType {
  error,
  success,
}

 
  // RESULT ALERT AFTER OPERATION COMPLETE ; 
  // 1 ADD OR DELETE MILESTONE: 
  ResultAlert(alert_type,context) async {
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
    await Future.delayed(Duration(seconds: 2));
    dialog.dismiss();
  }
