import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/StartupConnector.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Components/Widgets/BigLoadingSpinner.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class RegistorTeamBody extends StatefulWidget {
  const RegistorTeamBody({Key? key}) : super(key: key);

  @override
  State<RegistorTeamBody> createState() => _RegistorTeamBodyState();
}

class _RegistorTeamBodyState extends State<RegistorTeamBody> {
  double mem_dialog_width = 900;
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
  ShowDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              // title:  MileDialogHeading(context),
              content: SizedBox(
                width: mem_dialog_width,
                child: TeamMemberDialog(
                  form_type: MemberFormType.create,
                ),
              ),
            ));
  }

  AddMember(context) {
    ShowDialog(context);
  }

  // SHOW LOADING SPINNER :
  StartLoading() {
    var dialog = SmartDialog.showLoading(
        background: Colors.white,
        maskColorTemp: Color.fromARGB(146, 252, 250, 250),
        widget: BigLoadingSpinner());
    return dialog;
  }

// End Loading
  EndLoading() async {
    SmartDialog.dismiss();
  }

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

  // TEAM FORM :
  SubmitTeamMemberDetails() async {
    StartLoading();
    var resp = await memeberStore.PersistMembers();
    if (!resp['response']) {
      EndLoading();
      ErrorSnakbar();
      return;
    } else {

      // CATIGORY : 
      var resp = await startupConnector.CreateBusinessCatigory();
      print(resp);
      
      var resp2 = await startupConnector.CreateBusinessDetail();
      print(resp);

      var resp3 = await startupConnector.CreateBusinessMileStone();
      print(resp);

      var resp4 = await startupConnector.CreateBusinessProduct();
      print(resp);

      var resp5 = await startupConnector.CreateBusinessThumbnail();
      print(resp);

      var resp6 = await startupConnector.CreateBusinessVision();
      print(resp);
      
      var resp7 = await startupConnector.CreateUserContact();
      print(resp);
      
      var resp8 = await startupConnector.CreateUserDetail();
      print(resp);
      
      var resp9 = await startupConnector.CreateBusinessTeamMember();
      print(resp);

      EndLoading();
      print('member created');
      // START STORING ALL FOUNDER DETIAL TO FIREBASE :
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>?> member_list = memeberStore.GetMembers();

    return Column(
      children: [
        Container(
            height: context.height * 0.7,
            width: context.width * 0.7,
            /////////////////////////////////////////
            ///  BUSINESS SLIDE :
            ///  1. BUSINESS ICON :
            ///  2. INPUT FIELD TAKE BUSINESS NAME :
            /////////////////////////////////////////
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Container(
                        child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primary_light)),
                            onPressed: () {
                              AddMember(context);
                            },
                            icon: Icon(Icons.add),
                            label: Text('Add'))),
                  ],
                ),

                // MEMBER PROFILE LIST VIEW :
                // Image , name , position , email , then desc :
                Container(
                    height: context.height * 0.60,
                    width: context.width * 0.50,
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: member_list.length,
                          itemBuilder: (context, index) {
                            return MemberListView(
                              key: UniqueKey(),
                              member: member_list[index],
                              index: index,
                            );
                          });
                    }))
              ],
            )),
        TeamSlideNav(
            submitform: SubmitTeamMemberDetails, slide: TeamSlideType.team)
      ],
    );
  }
}
