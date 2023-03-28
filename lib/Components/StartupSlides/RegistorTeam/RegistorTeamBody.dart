import 'dart:convert';

import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';

import 'package:be_startup/Backend/Users/UserStore.dart';

import 'package:be_startup/Components/StartupSlides/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/StartupSlides/RegistorTeam/TeamMemberDialog.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RegistorTeamBody extends StatefulWidget {
  const RegistorTeamBody({Key? key}) : super(key: key);

  @override
  State<RegistorTeamBody> createState() => _RegistorTeamBodyState();
}

class _RegistorTeamBodyState extends State<RegistorTeamBody> {
  var memeberStore = Get.put(BusinessTeamMemberStore());
  var startupConnector = Get.put(StartupConnector());
  var startupviewConnector = Get.put(StartupViewConnector());
  var investorConnector = Get.put(InvestorConnector());

  var userStore = Get.put(UserStore(), tag: 'user_store');
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  var my_context = Get.context;

  double con_button_width = 150;
  double con_button_height = 40;

  double con_btn_top_margin = 30;
  double mem_dialog_width = 900;

  double member_section_height = 0.60;
  double member_section_width = 0.50;

  var pageParam;
  var startup_id;
  var user_id;
  var is_admin;

  bool? updateMode = false;

  BackButtonRoute() {
    var param = jsonEncode({
      'user_id': user_id,
      'is_admin': is_admin,
    });

    CloseCustomPageLoadingSpinner();
    Get.toNamed(team_page_url, parameters: {'data': param});
  }

/////////////////////////////////////////////
  /// ADD TEAM MEMBER DIALOG WIDGET :
/////////////////////////////////////////////
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
                      Icons.cancel_rounded,
                      color: cancel_btn_color,
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

  // MAIN MODEL :
  AddMember(context) {
    ShowDialog(context);
  }

  ////////////////////////////////////////////////////////
  // SUBMIT TEAM FORM :
  // 1. Create Team member :
  // 2. Create Startup upload detail to firestore :
  //////////////////////////////////////////////////////////
  SubmitTeamMemberDetails() async {
    MyCustPageLoadingSpinner();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    var resp = await memeberStore.PersistMembers();

    // Success Handler :
    if (resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.toNamed(select_plan_url);
      // await IsPlanWithoutStartup();
    }

    // Error Handler :
    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
      return;
    }
  }

/////////////////////////////////////////
// Update Team form :
/////////////////////////////////////////
  UpdateTeamMemberDetails() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var upload_resp;

    MyCustPageLoadingSpinner();
    upload_resp = await updateStore.UpdateBusinessTeamMember(user_id: user_id);
    final deleteMemberPath = await memeberStore.GetDeleteMemeberPath();

    if (upload_resp['response']) {
      for (var i = 0; i < deleteMemberPath.length; i++) {
        print('path ${deleteMemberPath[i]}');
        await DeleteFileFromStorage(deleteMemberPath[i]);
      }

      var param = jsonEncode({
        'user_id': user_id,
        'is_admin': is_admin,
      });

      CloseCustomPageLoadingSpinner();
      Get.toNamed(team_page_url, parameters: {'data': param});
    }

    // Upload Error Response
    if (!upload_resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.error,
          title: update_error_title,
          message: update_error_msg));
    }
  }

//////////////////////////////////////////
  /// GET REQUIREMENTS DATA :
//////////////////////////////////////////
  GetLocalStorageData() async {
    var error_resp;
    var data = [];
    try {
      if (Get.parameters.isNotEmpty) {
        pageParam = jsonDecode(Get.parameters['data']!);
        user_id = pageParam['user_id'];
        is_admin = pageParam['is_admin'];

        // Update Members :
        if (pageParam['type'] == 'update') {
          updateMode = true;
          final fetch_resp = await startupviewConnector.FetchBusinessTeamMember(
              user_id: user_id);

          if (fetch_resp['response']) {
            data = await memeberStore.UpdateMemberList(
                update_memebers: fetch_resp['data']['members']);
          }

          if (!fetch_resp['response']) {
            print('Fetch Team Member Error $fetch_resp');
          }
        }
      }

      // Set Default member List :
      else {
        data = await memeberStore.GetMembers();
      }
      error_resp = data;
      return data;
    } catch (e) {
      return error_resp;
    }
  }

  @override
  Widget build(BuildContext context) {
    member_section_height = 0.60;
    member_section_width = 0.50;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      member_section_height = 0.60;
      member_section_width = 0.55;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      member_section_height = 0.60;
      member_section_width = 0.60;
      print('1500');
    }

    if (context.width < 1200) {
      member_section_height = 0.60;
      member_section_width = 0.60;
      print('1200');
    }

    if (context.width < 1300) {
      member_section_width = 0.65;
      member_section_height = 0.60;
      print('1200');
    }

    if (context.width < 1000) {
      member_section_width = 0.90;
      member_section_height = 0.60;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      member_section_width = 0.90;
      member_section_height = 0.60;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      member_section_width = 0.90;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      member_section_width = 0.90;
      print('480');
    }

    //////////////////////////////////////////
    /// SET REQUIREMENTS DATA :
    //////////////////////////////////////////
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

  /////////////////////////////////////////
  /// MAIN METHOD :
  /////////////////////////////////////////
  Container MainMethod(BuildContext context, member_list) {
    return Container(
      width: context.width * 1,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Column(
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
                                            MaterialStateProperty.all(
                                                primary_light)),
                                    onPressed: () {
                                      AddMember(context);
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add'))),
                          ],
                        ),

                        // MEMBER PROFILE LIST VIEW :
                        // Image , name , position , email , then desc :
                        Container(
                            height: context.height * member_section_height,
                            width: context.width * member_section_width,
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
                updateMode == true
                    ? SubmitAndUpdateButton(context, UpdateTeamMemberDetails)
                    : SubmitAndUpdateButton(context, SubmitTeamMemberDetails)
              ],
            ),
          ),
          updateMode == true
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      BackButtonRoute();
                    },
                    child: Card(
                      color: Colors.blueGrey.shade500,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }

///////////////////////////////////
  /// EXTERNAL METHODS :
  /// 1. Update buttopn :
///////////////////////////////////
  Container SubmitAndUpdateButton(BuildContext context, fun) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await fun();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Update',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
