import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/User.dart';

import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/HomeView/SettingsView/DeleteStartupsDialogCont.dart';
import 'package:be_startup/Components/HomeView/SettingsView/ReauthenticateDialog.dart';

import 'package:be_startup/Components/Widgets/PhoneNoVerification.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettings extends StatefulWidget {
  var usertype;
  UserSettings({this.usertype, Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  var auth = Get.put(MyAuthentication(), tag: 'my_auth');
  var userState = Get.put(UserState());
  FirebaseAuth fireInstance = FirebaseAuth.instance;

  final updateEmailFeild = TextEditingController();
  final updateAchiveAmount = TextEditingController();
  final founderConnector = Get.put(FounderConnector());
  final userStore = Get.put(UserStore());
  final homeViewState = Get.put(UserState());
  final socialAuth = Get.put(MySocialAuth(), tag: 'social_auth');
  final my_context = Get.context;

  double mem_dialog_width = 900;
  var is_update_mail = false;
  var is_update_achive_amount = false;
  var user_phone_no;

  var user_id;
  var startup_id;
  var is_admin;
  var usertype;

  double page_width = 0.45;
  double page_height = 0.45;

  double page_elevation = 10;

  double con_width = 0.20;
  double con_height = 0.30;

  double con_left_margin = 0.03;
  double con_top_margin = 0.05;

  double dialog_width = 200;

  double dialog_heading_fonSize = 14;

  double auth_dialog_width = 0.20;
  double auth_dialog_height = 0.30;

  double item_iconSize = 20;
  double item_fontSize = 15;

  double title_cont_width = 0.06;
  double title_font_size = 15;
  double info_iconSize = 18;

  double trail_width = 200;
  double trail_height = 30;

  double trail_row_width = 90;
  double trail_row_height = 30;

  double trail_icon_fontSize = 15;

  double phone_no_cont_width = 110;
  double phone_no_height = 30;

  double take_email_iconSize = 22;

  double update_btn_text = 16;

  double rounded_btn_fontSize = 15;
  double rounded_btn_width = 28;
  double rounded_btn_height = 28; 

  //////////////////////////////////////////////////////
  // Password Reset Links Send Succfull Dialog :
  //////////////////////////////////////////////////////
  ResultDialog(context) async {
    CoolAlert.show(
        context: context,
        width: dialog_width,
        title: 'Successful',
        type: CoolAlertType.success,
        widget: Text(
          'Rest password link send to registor email',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: dialog_heading_fonSize,
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade500),
        ));
  }

/////////////////////////////////////////////
// Ask user for password reset if yes
//then send link to registor eamil address :
/////////////////////////////////////////////
  AskForPasswordRestDialot(context) async {
    CoolAlert.show(
        context: context,
        width: dialog_width,
        title: 'Confirm Reset',
        type: CoolAlertType.confirm,
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        },
        onConfirmBtnTap: () async {
          final resp = await auth.ResetPasswordWithEmail();
          if (resp['response']) {
            Navigator.of(context).pop();
            await ResultDialog(context);
          }
        },
        widget: Text(
          'The password reset link send you your registor mail address ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: dialog_heading_fonSize,
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade500),
        ));
  }

///////////////////////////////////////////
  /// Showing a dialog box with two buttons,
  /// one is cancel and another is confirm.
///////////////////////////////////////////
  AskBeforeRemoveUserProfile(context) async {
    CoolAlert.show(
        context: context,
        width: dialog_width,
        title: 'Confirm',
        type: CoolAlertType.confirm,
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        },
        onConfirmBtnTap: () async {
          final resp = await auth.ResetPasswordWithEmail();
          if (resp['response']) {
            Navigator.of(context).pop();
            await ReauthenticateDialog(
              task: ReautheticateTask.deleteProfile,
            );
          }
        },
        widget: Text(
          'After confirm your Profile and Statups will remove completely',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: dialog_heading_fonSize,
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade500),
        ));
  }

  /////////////////////////////////////////////////
  /// Reaunthenticate user Before Update Mail :
  /////////////////////////////////////////////////
  ReauthenticateDialog({task, updateMail}) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                width: context.width * auth_dialog_width,
                height: context.height * auth_dialog_height,
                child: ReauthenticateWidget(
                  task: task,
                  updateMail: updateMail,
                ),
              ));
        });
  }

  //////////////////////////////////////////////
  /// Verify Phoneno :
  ///////////////////////////////////////////////
  PhoneNoVerificationDialog({task, updateMail}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                  width: context.width * auth_dialog_width,
                  height: context.height * auth_dialog_height,
                  child: PhoneNoVerifyDialogAlert(
                      noOperation: NumberOperation.update, key: UniqueKey())));
        });
  }

  //////////////////////////////////////////////
  /// DeleteStartups Dialog
  ///////////////////////////////////////////////
  DeleteStartupDialog(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.cancel_outlined,
                          color: Colors.blueGrey.shade300, size: 20))),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                width: context.width * auth_dialog_width,
                height: context.height * auth_dialog_height,
                child: DeleteStartupDialogCont(),
              ));
        });
  }

//////////////////////////////////
  /// HANDLERS :
//////////////////////////////////
  // Reset Password Handler :
  ResetPassword() async {
    await AskForPasswordRestDialot(my_context);
  }

  // Update Email Handler :
  UpdateEmail() async {
    var email = updateEmailFeild.text;
    ReauthenticateDialog(
        task: ReautheticateTask.updateEmail, updateMail: email);
  }

  // Update Achived amount :
  UpdateAchivedAmount() async {
    var amount = updateAchiveAmount.text;
    print(amount);
  }

  // Two Factor Auth :
  SecondFactAuth() async {
    print('SecondFactAuth ');
  }

  // Edit Profile Link :
  EditProfile() async {
    var param = jsonEncode({
      'type': 'update',
      'user_id': user_id,
    });

    if (usertype == UserType.investor) {
      Get.toNamed(investor_registration_form, parameters: {'data': param});
    }

    if (usertype == UserType.founder) {
      Get.toNamed(create_founder, parameters: {'data': param});
    }
  }

  // Delete User Handler :
  DeleteUser() async {
    await AskBeforeRemoveUserProfile(my_context);
  }

  // Delete Startups :
  DeleteStartup() async {}

  // Verify Phone no :
  VerifyPhoneno() async {
    PhoneNoVerificationDialog();
  }

  // Switch Investor to Founder :
  SwitchInvestorToFounder() async {
    try {
      final resp1 = await userStore.UpdateUserDatabaseField(
        val: true,
        field: 'is_founder',
      );

      final resp2 = await userStore.UpdateUserDatabaseField(
        val: false,
        field: 'is_investor',
      );

      await socialAuth.Logout();
    } catch (e) {
      var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(type: MySnackbarType.error, width: snack_width));
    }
  }

  @override
  Widget build(BuildContext context) {
    page_width = 0.45;
    page_height = 0.45;

    page_elevation = 10;

    con_width = 0.20;
    con_height = 0.30;

    con_left_margin = 0.03;
    con_top_margin = 0.05;

    dialog_width = 200;

    dialog_heading_fonSize = 14;

    auth_dialog_width = 0.20;
    auth_dialog_height = 0.30;

    item_iconSize = 20;
    item_fontSize = 15;

    title_cont_width = 0.06;
    title_font_size = 15;
    info_iconSize = 18;

    trail_width = 200;
    trail_height = 30;

    trail_row_width = 90;
    trail_row_height = 30;

    trail_icon_fontSize = 15;

    phone_no_cont_width = 110;
    phone_no_height = 30;

    take_email_iconSize = 22;

    update_btn_text = 16;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      page_width = 0.45;
      page_height = 0.45;

      page_elevation = 10;

      con_width = 0.20;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 20;
      item_fontSize = 15;

      title_cont_width = 0.06;
      title_font_size = 15;
      info_iconSize = 18;

      trail_width = 200;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 22;

      update_btn_text = 16;

      rounded_btn_fontSize = 15;
      rounded_btn_width = 28;
      rounded_btn_height = 28; 
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      page_width = 0.60;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.20;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 20;
      item_fontSize = 15;

      title_cont_width = 0.06;
      title_font_size = 15;
      info_iconSize = 18;

      trail_width = 200;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 22;

      update_btn_text = 16;
      print('1500');
    }

    if (context.width < 1200) {
      page_width = 0.65;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.20;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 20;
      item_fontSize = 15;

      title_cont_width = 0.06;
      title_font_size = 15;
      info_iconSize = 18;

      trail_width = 200;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 22;

      update_btn_text = 16;
      print('1200');
    }

    if (context.width < 1000) {
      page_width = 0.75;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.20;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 20;
      item_fontSize = 15;

      title_cont_width = 0.06;
      title_font_size = 15;
      info_iconSize = 18;

      trail_width = 200;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 22;

      update_btn_text = 16;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      page_width = 0.90;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.40;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 17;
      item_fontSize = 14;

      title_cont_width = 0.06;
      title_font_size = 14;
      info_iconSize = 16;

      trail_width = 120;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 20;

      update_btn_text = 16;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      page_width = 0.90;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.40;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 17;
      item_fontSize = 14;

      title_cont_width = 0.06;
      title_font_size = 14;
      info_iconSize = 16;

      trail_width = 110;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 20;

      update_btn_text = 16;

      rounded_btn_fontSize = 15;
      rounded_btn_width = 28;
      rounded_btn_height = 28; 
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      page_width = 0.95;
      page_height = 0.60;

      page_elevation = 10;

      con_width = 0.40;
      con_height = 0.30;

      con_left_margin = 0.03;
      con_top_margin = 0.05;

      dialog_width = 200;

      dialog_heading_fonSize = 14;

      auth_dialog_width = 0.20;
      auth_dialog_height = 0.30;

      item_iconSize = 17;
      item_fontSize = 12;

      title_cont_width = 0.06;
      title_font_size = 12;
      
      info_iconSize = 14;

      trail_width = 110;
      trail_height = 30;

      trail_row_width = 90;
      trail_row_height = 30;

      trail_icon_fontSize = 15;

      phone_no_cont_width = 110;
      phone_no_height = 30;

      take_email_iconSize = 16;

      update_btn_text = 12;

      rounded_btn_fontSize = 12;
      rounded_btn_width = 22;
      rounded_btn_height = 22; 
      print('480');
    }

    ////////////////////////////////////////////
    /// GET REQUIREMENTS :
    ////////////////////////////////////////////
    GetLocalStorageData() async {
      user_id = await homeViewState.GetUserId();
      usertype = await homeViewState.GetUserType();

      if (fireInstance.currentUser?.phoneNumber != null) {
        user_phone_no = fireInstance.currentUser?.phoneNumber;
      } else {
        user_phone_no = await userState.GetPhoneNo();
      }
    }

    ////////////////////////////////////
    /// SET REQUIREMENTS :
    ////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Settings ',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
              context,
            );
          }
          return MainMethod(
            context,
          );
        });
  }

  Container MainMethod(BuildContext context) {
    return Container(
        width: context.width * page_width,
        height: context.height * page_height,
        color: home_profile_cont_color,
        child: Card(
            elevation: page_elevation,
            shadowColor: Colors.blueGrey,
            color: home_profile_cont_color,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                width: context.width * con_width,
                height: context.height * con_height,
                margin: EdgeInsets.only(
                    left: context.width * con_left_margin,
                    top: context.height * con_top_margin),
                child: ListView(
                  children: [
                    // Edit Profile :
                    SettingItem(
                      title: 'Edit Profile',
                      icon: Icons.person,
                      fun: EditProfile,
                    ),

                    // Resting password
                    SettingItem(
                      title: 'Rest Pasword',
                      icon: Icons.lock,
                      fun: ResetPassword,
                    ),

                    // SettingItem(
                    //   title: '2 Factor Auth',
                    //   icon: Icons.verified_rounded,
                    //   fun: SecondFactAuth,
                    // ),

                    // Edit Mail field :
                    is_update_mail
                        ? TakeEmailAddress(fun: UpdateEmail)
                        : EditEmailItem(
                            title: fireInstance.currentUser?.email,
                            icon: Icons.email,
                            fun: () {},
                          ),

                    // Edit phoneno Field :
                    EditPhoneNo(
                        title: user_phone_no,
                        icon: Icons.phone,
                        fun: VerifyPhoneno),

                    // // Update Achived Amount :
                    // is_update_achive_amount
                    //     ? TakeAchiveAmount(fun: UpdateAchivedAmount)
                    //     : EditAchivedAmount(
                    //         title: 'Achived Amount',
                    //         icon: Icons.currency_rupee_sharp,
                    //         amount: '  ${30000}',
                    //         fun: () {},
                    //       ),

                    // Switch user type;
                    widget.usertype == UserType.investor
                        ? SettingItem(
                            title: 'Switch to founder',
                            icon: Icons.refresh_rounded,
                            fun: SwitchInvestorToFounder,
                          )
                        : Container(),

                    // Delete or Remove user field :
                    WarningItem(
                        context: context,
                        title: 'Delete Startup',
                        icon: Icons.home_max_outlined,
                        fun: DeleteStartupDialog),

                    // Delete or Remove user field :
                    WarningItem(
                        context: context,
                        title: 'Delete Account',
                        icon: Icons.delete_rounded,
                        fun: DeleteUser),
                  ],
                ))));
  }

  //////////////////////////////////////////////
  /// EXTERNAL METHOD :
  //////////////////////////////////////////////
  Container SettingItem({title, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          fun();
        },
        autofocus: true,
        leading: Icon(icon, size: item_iconSize, color: edit_btn_color),
        title: AutoSizeText.rich(
          TextSpan(text: title),
          style: TextStyle(fontSize: item_fontSize, color: input_text_color),
        ),
      ),
    );
  }




  Container EditEmailItem({title, icon, fun, simpleEditButton}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          style: ListTileStyle.drawer,
          hoverColor: home_setting_tile_hover_color,
          selected: true,
          mouseCursor: MouseCursor.defer,
          onTap: () {},
          autofocus: true,
          leading: Icon(icon, size: item_iconSize, color: edit_btn_color),
          title: Container(
            width: context.width * title_cont_width,
            child: Row(
              children: [
                AutoSizeText.rich(
                  TextSpan(text: title),
                  style: TextStyle(
                      fontSize: title_font_size, color: input_text_color),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.verified_outlined,
                    size: info_iconSize,
                    color: primary_light,
                  ),
                )
              ],
            ),
          ),
          trailing: context.width < 640
              ?

              // Rounded Edit Button :
              Tooltip(
                  message: 'edit',
                  
                  child: Container(
                    width: rounded_btn_width,
                    height: rounded_btn_height,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey.shade300),
                        borderRadius: BorderRadius.circular(50)),
                  
                    child: IconButton(
                        padding: EdgeInsets.all(4),
                        onPressed: () {},

                        icon: Icon(
                          Icons.edit,
                          size: rounded_btn_fontSize,
                          color: edit_btn_color,
                        )),
                  ),
                )
              :


              // Simple Edit Button :
              Container(
                  width: trail_width,
                  height: trail_height,
                  child: Row(
                    children: [
                      Container(
                        width: trail_row_width,
                        height: trail_row_height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Colors.blueGrey.shade300)),
                        child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                is_update_mail
                                    ? is_update_mail = false
                                    : is_update_mail = true;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              size: trail_icon_fontSize,
                              color: edit_btn_color,
                            ),

                            label: Text('update',
                            style: TextStyle(
                              color: edit_btn_color
                            ),)),
                      ),
                    ],
                  ),
                )),
    );
  }

  Container EditAchivedAmount({title, amount, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {},
        autofocus: true,
        leading: Icon(icon, size: item_iconSize, color: light_color_type2),
        title: Container(
          width: context.width * title_cont_width,
          child: Row(
            children: [
              AutoSizeText.rich(
                TextSpan(text: title, children: [
                  TextSpan(
                    text: amount,
                    style: TextStyle(
                        fontSize: title_font_size, color: input_text_color),
                  )
                ]),
                style: TextStyle(
                    fontSize: title_font_size, color: input_text_color),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: trail_width,
          height: trail_height,
          child: Row(
            children: [
              Container(
                width: trail_row_width,
                height: trail_row_height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey.shade300)),
                child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        is_update_achive_amount
                            ? is_update_achive_amount = false
                            : is_update_achive_amount = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      size: trail_icon_fontSize,
                      color: edit_btn_color,
                    ),
                    label: Text('update',style: TextStyle(color: edit_btn_color),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container EditPhoneNo({title, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {},
        autofocus: true,
        leading: Icon(icon, size: item_iconSize, color: edit_btn_color),
        title: Container(
          width: context.width * title_cont_width,
          child: Row(
            children: [
              AutoSizeText.rich(
                TextSpan(text: title),
                style: TextStyle(
                    fontSize: title_font_size, color: input_text_color),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: fireInstance.currentUser?.phoneNumber != null
                    ? Icon(
                        Icons.verified_outlined,
                        size: info_iconSize,
                        color: primary_light,
                      )
                    : Container(),
              )
            ],
          ),
        ),
        trailing: Container(
          width: trail_width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              fireInstance.currentUser?.phoneNumber != null
                  ? context.width < 640
                      ?

                      // Rounded Button :
                      Tooltip(
                          message: 'edit',
                          child: Container(
                            width: rounded_btn_width,
                            height: rounded_btn_height,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blueGrey.shade300),
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                padding: EdgeInsets.all(4),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  size: rounded_btn_fontSize,
                                  color: edit_btn_color,
                                )),
                          ),
                        )
                      :
                      // Simple Phone no Update Button  :
                      Container(
                          width: trail_row_width,
                          height: trail_row_height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.blueGrey.shade300)),
                          child: TextButton.icon(
                              icon: Icon(
                                Icons.edit,
                                size: trail_icon_fontSize,
                                color: edit_btn_color,
                              ),
                              onPressed: () async {
                                await fun();
                              },
                              label:  Text(
                                'update',
                                style: TextStyle(color: edit_btn_color),
                              )),
                        )
                  : fireInstance.currentUser?.phoneNumber == null
                      ? context.width < 640
                          ?
                          // Rounded Button :
                          Container(
                              margin:
                                  EdgeInsets.only(left: context.width * 0.14),
                              child: Tooltip(
                                message: 'verify',
                                child: Container(
                                  width: rounded_btn_width,
                                  height: rounded_btn_height,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blueGrey.shade300),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                      padding: EdgeInsets.all(4),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.check,
                                        size: rounded_btn_fontSize,
                                        color: edit_btn_color,
                                      )),
                                ),
                              ),
                            )
                          :

                          // Simple Phone no Verify Button :
                          Container(
                              width: phone_no_cont_width,
                              height: phone_no_height,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.blueGrey.shade300)),
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.check,
                                    size: trail_icon_fontSize,
                                    color: edit_btn_color,
                                  ),
                                  onPressed: () async {
                                    await fun();
                                  },
                                  label: Text('verify now',
                                  style: TextStyle(color:edit_btn_color ),)),
                            )
                      : Container()
            ],
          ),
        ),
      ),
    );
  }



  Container TakeEmailAddress({title, icon, fun}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4),
      
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          // fun();
        },
        autofocus: true,

        // Icon : 
        leading: Icon(icon, size: item_iconSize, color: edit_btn_color),
       
      // Input Mail Section : 
        title: Container(
          child: TextField(
              controller: updateEmailFeild,
              decoration:  InputDecoration(
                  hintText: 'Enter mail',
                
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade800),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),
        ),


        // Done Button : 
        trailing: Container(
          width: trail_width,
          height: trail_height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: trail_row_width,
                height: trail_row_height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey)),
                child: TextButton(
                    onPressed: () async {
                      await fun();
                      setState(() {
                        is_update_mail = false;
                      });
                    },
                    child: Text('Done',style: TextStyle(color: edit_btn_color),)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        is_update_mail = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: take_email_iconSize,
                      color: edit_btn_color,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }





  Container TakeAchiveAmount({title, icon, fun}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          // fun();
        },
        autofocus: true,
        leading: Icon(icon, size: item_iconSize, color: light_color_type2),
        title: Container(
          child: TextField(
              controller: updateAchiveAmount,
              decoration: const InputDecoration(
                  hintText: 'enter amount',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),
        ),
        trailing: Container(
          width: trail_width,
          height: trail_height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: trail_row_width,
                height: trail_row_height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey)),
                child: TextButton(
                    onPressed: () async {
                      await fun();
                      setState(() {
                        is_update_achive_amount = false;
                      });
                    },
                    child: Text('Done',style: TextStyle(color: edit_btn_color),)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        is_update_achive_amount = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: take_email_iconSize,
                      color: edit_btn_color,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }





  Container WarningItem({context, title, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: home_setting_tile_hover_color,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () async {
          await fun(context);
        },
        autofocus: true,
        leading: Icon(icon, size: item_iconSize, color: Colors.red.shade300),
        title: AutoSizeText.rich(TextSpan(text: title),
            style: TextStyle(
              fontSize: title_font_size,
              color: Colors.red,
            )),
      ),
    );
  }
}
