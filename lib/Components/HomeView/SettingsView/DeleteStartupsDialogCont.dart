import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/DeleteStartup.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/enums.dart';

import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteStartupDialogCont extends StatelessWidget {
  DeleteStartupDialogCont({Key? key}) : super(key: key);

  var removeStartupStore = Get.put(RemoveStartup());
  var homeViewConnector = Get.put(HomeViewConnector());
  var userStore = Get.put(UserState());

  var startup_ids = [];
  var startup_name = [];

///////////////////////////////////////////////////////
  /// The function takes in an id, and then calls
  /// the DeleteStartups function in the
  /// removeStartupStore.dart file
  ///
  /// Args:
  ///   id: The id of the startup that you want to delete.
///////////////////////////////////////////////////////
  DeleteStartup({required context, required id}) async {
  var snack_width = MediaQuery.of(context).size.width * 0.50;
    MyCustPageLoadingSpinner();

    try {
      final resp =
          await removeStartupStore.DeleteStartups(final_startup_id: id);

      if (resp['response']) {
       
        CloseCustomPageLoadingSpinner();
        Navigator.of(context).pop();
      }

      if (!resp['response']) {
       
        CloseCustomPageLoadingSpinner();
       
        Get.showSnackbar(
          MyCustSnackbar(
            type: MySnackbarType.error,
            title: delete_error_title,
            message: delete_error_msg,
            width: snack_width));
      }
    } 
    
    catch (e) {
      CloseCustomPageLoadingSpinner();
    
      Get.showSnackbar(
        MyCustSnackbar(
          type: MySnackbarType.error,
          title: delete_error_title,
          message: delete_error_msg,
          width: snack_width));
    
      print('Delete Startup Error $e');
    }
  }



  /// A function that is called when the user clicks on the delete button.
  AskBeforeDeleteStartup(context, id) async {
    CoolAlert.show(
        context: context,
        width: 200,
        title: 'Confirm',
        type: CoolAlertType.confirm,
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        },
        onConfirmBtnTap: () async {
          // Delete Startup:
          Navigator.of(context).pop();
          await DeleteStartup(context: context, id: id);
        },
        widget: Text(
          'After confirm Statups will remove completely',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade500),
        ));
  }

  ///////////////////////////////////////////
  /// Get Required parameters:
  ///////////////////////////////////////////
  GetLocalStorageData() async {
    try {
      final user_id = await userStore.GetUserId();
      final startups_resp =
          await homeViewConnector.FetchUserStartups(user_id: user_id);
      // print('startup response $startups_resp');
      startup_ids = startups_resp['data']['startup_ids'];
      startup_name = startups_resp['data']['startup_name'];
    } catch (e) {
      print('Fetch Startup Error $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////////
    /// Set Required parameters:
    ///////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading SUP',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

/////////////////////////////////////////////
  /// Main Method :
/////////////////////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Container(
        width: context.width * 0.20,
        height: context.height * 0.30,
        child: ListView.builder(
            itemCount: startup_ids.length,
            itemBuilder: (context, index) {
              return Container(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                    tileColor: Colors.grey.shade100,
                    focusColor: Colors.grey.shade300,
                    hoverColor: Colors.grey.shade300,
                    selectedTileColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),

                    // Title :
                    title: AutoSizeText.rich(TextSpan(
                        text: '${startup_name[index]}',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17,
                        ))),

                    // Delete Dialog Button :
                    trailing: IconButton(
                        onPressed: () async {
                          await AskBeforeDeleteStartup(
                              context, startup_ids[index]);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade300,
                          size: 22,
                        ))),
              ));
            }),
      )),
    );
  }
}
