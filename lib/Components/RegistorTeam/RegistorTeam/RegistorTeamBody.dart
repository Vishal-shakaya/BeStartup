import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Components/Widgets/BigLoadingSpinner.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RegistorTeamBody extends StatefulWidget {
  const RegistorTeamBody({Key? key}) : super(key: key);

  @override
  State<RegistorTeamBody> createState() => _RegistorTeamBodyState();
}

class _RegistorTeamBodyState extends State<RegistorTeamBody> {
  double mem_dialog_width = 900;
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
  var userStore = Get.put(UserStore(), tag: 'user_store');

  ShowDialog(context) {
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
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Colors.blueGrey.shade800,
                    )),
              ),
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

  CreateStartup() async {
    var startup = await StartupModel(
        user_id: await getUserId,
        email: await getuserEmail,
        startup_name: await getStartupName,
        desire_amount: await getDesireAmount);

    final resp = await userStore.UpdateUserPlanAndStartup(
        field: 'startups', val: startup);
    if (!resp['response']) {
      print('Error Creating Startup model ${resp["message"]}');
    } else {
      print("**** Startup Model Created ****");
    }
  }

  /////////////////////////////////////////////////////
  // START STORING ALL FOUNDER DETIAL TO FIREBASE :
  /////////////////////////////////////////////////////
  SendDataToFireStore() async {
    var resp = await startupConnector.CreateBusinessCatigory();
    if (resp['response']) {
      print(
          '********* CreateBusinessCatigory Stored Succefully ${resp} *******');
    }

    var resp2 = await startupConnector.CreateBusinessDetail();
    if (resp2['response']) {
      print(
          '********* CreateBusinessDetail Stored Succefully ${resp2} *******');
    }

    var resp3 = await startupConnector.CreateBusinessMileStone();
    if (resp3['response']) {
      print(
          '********* CreateBusinessMileStone Stored Succefully ${resp3} *******');
    }

    var resp4 = await startupConnector.CreateBusinessProduct();
    if (resp4['response']) {
      print(
          '********* CreateBusinessProduct Stored Succefully ${resp4} *******');
    }

    var resp5 = await startupConnector.CreateBusinessThumbnail();
    if (resp5['response']) {
      print(
          '********* CreateBusinessThumbnail Stored Succefully ${resp5} *******');
    }

    var resp6 = await startupConnector.CreateBusinessVision();
    if (resp6['response']) {
      print(
          '********* CreateBusinessVision Stored Succefully ${resp6} *******');
    }

    var resp7 = await startupConnector.CreateUserContact();
    if (resp7['response']) {
      print('********* CreateUserContact Stored Succefully ${resp7} *******');
    }

    var resp8 = await startupConnector.CreateUserDetail();
    if (resp8['response']) {
      print('********* CreateUserDetail Stored Succefully ${resp8} *******');
    }

    var resp9 = await startupConnector.CreateBusinessTeamMember();
    if (resp9['response']) {
      print(
          '********* CreateBusinessTeamMember Stored Succefully ${resp9} *******');
    }
    await CreateStartup();
    return true;
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
      // Send data for firebase:
      var resp = await SendDataToFireStore();
      print('Create Startup ${resp}');

      EndLoading();
      print('Upload Detail Successfull');
      Get.toNamed(startup_view_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        // await Future.delayed(Duration(seconds: 5));
        final data = await memeberStore.GetMembers();
        return data;
      } catch (e) {
        return '';
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading Member List ');
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data);
          }
          return MainMethod(context, snapshot.data);
        });
  }

  Column MainMethod(BuildContext context, member_list) {
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
