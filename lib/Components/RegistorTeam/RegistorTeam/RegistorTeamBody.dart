import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Startup/Connector/CreateStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Components/Widgets/BigLoadingSpinner.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
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
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  var startupConnector = Get.put(StartupConnector(), tag: 'startup_connector');
  var founderConnector = Get.put(FounderConnector(), tag: 'founder_connector');
  var startupviewConnector =
      Get.put(StartupViewConnector(), tag: 'startup_view_connector');
  var investorConnector =
      Get.put(InvestorConnector(), tag: 'investor_connector');

  var userStore = Get.put(UserStore(), tag: 'user_store');
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  var my_context = Get.context;

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;
  double mem_dialog_width = 900;

  var pageParam;
  var startup_id;
  var founder_id;
  var is_admin;

  bool? updateMode = false;

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
    upload_resp =
        await updateStore.UpdateBusinessTeamMember(startup_id: startup_id);

    // Upload Succes response :
    if (upload_resp['response']) {
      var param = jsonEncode({
        'founder_id': founder_id,
        'startup_id': startup_id,
        'is_admin': is_admin,
      });

      CloseCustomPageLoadingSpinner();
      Get.toNamed(team_page_url);
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

//////////////////////////////////////
// SET PAGE DEFAULT STATE :
//////////////////////////////////////
  @override
  void initState() {
    pageParam = jsonDecode(Get.parameters['data']!);
    startup_id = pageParam['startup_id'];
    founder_id = pageParam['founder_id'];
    is_admin   = pageParam['is_admin'];

    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
  }

//////////////////////////////////////////
  /// GET REQUIREMENTS DATA :
//////////////////////////////////////////
  GetLocalStorageData() async {
    var error_resp;
    try {
      //////////////////////////////////////////
      /// UPDATE TEAM MEMBERS :
      //////////////////////////////////////////
      if (updateMode == true) {
        final fetch_resp = await startupviewConnector.FetchBusinessTeamMember(
            startup_id: startup_id);

        if (fetch_resp['response']) {
          await memeberStore.SetTeamMembers(
              list: fetch_resp['data']['members']);
        }

        if (!fetch_resp['response']) {
          print('Fetch Team Member Error $fetch_resp');
        }
      }

      //////////////////////////////////////////
      /// GET TEAM MEMEMBERS :
      /// 1. Localy :
      /// 2. Globaly :
      //////////////////////////////////////////
      final data = await memeberStore.GetMembers();
      error_resp = data;
      return data;
    } catch (e) {
      return error_resp;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        updateMode == true
            ? UpdateButton(context)
            : TeamSlideNav(
                submitform: SubmitTeamMemberDetails, slide: TeamSlideType.team)
      ],
    );
  }

///////////////////////////////////
  /// EXTERNAL METHODS :
  /// 1. Update buttopn :
///////////////////////////////////
  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdateTeamMemberDetails();
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
