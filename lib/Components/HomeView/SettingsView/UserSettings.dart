import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
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

  //////////////////////////////////////////////////////
  // Password Reset Links Send Succfull Dialog :
  //////////////////////////////////////////////////////
  ResultDialog(context) async {
    CoolAlert.show(
        context: context,
        width: 200,
        title: 'Successful',
        type: CoolAlertType.success,
        widget: Text(
          'Rest password link send to registor email',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
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
        width: 200,
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
              fontSize: 14,
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
        width: 200,
        title: 'Confirm',
        type: CoolAlertType.warning,
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
              fontSize: 14,
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
                width: context.width * 0.20,
                height: context.height * 0.50,
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
                  width: context.width * 0.20,
                  height: context.height * 0.30,
                  child: PhoneNoVerifyDialogAlert(
                      noOperation: NumberOperation.update, key: UniqueKey())));
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

    if(usertype == UserType.investor){
       Get.toNamed(investor_registration_form, parameters: {'data': param});
    }

    if(usertype == UserType.founder){
       Get.toNamed(create_founder, parameters: {'data': param});
    }
  }


  // Delete User Handler :
  DeleteUser() async {
    await AskBeforeRemoveUserProfile(my_context);
  }


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
        width: context.width * 0.45,
        height: context.height * 0.45,
        child: Card(
            elevation: 10,
            shadowColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                width: context.width * 0.20,
                height: context.height * 0.30,
                margin: EdgeInsets.only(left: context.width * 0.03),
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
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          fun();
        },
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: AutoSizeText.rich(
          TextSpan(text: title),
          style: TextStyle(fontSize: 15, color: light_color_type1),
        ),
      ),
    );
  }

  Container EditEmailItem({title, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {},
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: Container(
          width: context.width * 0.06,
          child: Row(
            children: [
              AutoSizeText.rich(
                TextSpan(text: title),
                style: TextStyle(fontSize: 15, color: light_color_type1),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.verified_outlined,
                  size: 18,
                  color: primary_light,
                ),
              )
            ],
          ),
        ),
        trailing: Container(
          width: 200,
          height: 30,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey.shade300)),
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
                      size: 15,
                    ),
                    label: Text('update')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container EditAchivedAmount({title, amount, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {},
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: Container(
          width: context.width * 0.06,
          child: Row(
            children: [
              AutoSizeText.rich(
                TextSpan(text: title, children: [
                  TextSpan(
                    text: amount,
                    style: TextStyle(fontSize: 17, color: light_color_type1),
                  )
                ]),
                style: TextStyle(fontSize: 15, color: light_color_type1),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 200,
          height: 30,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 30,
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
                      size: 15,
                    ),
                    label: Text('update')),
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
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {},
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: Container(
          width: context.width * 0.06,
          child: Row(
            children: [
              AutoSizeText.rich(
                TextSpan(text: title),
                style: TextStyle(fontSize: 15, color: light_color_type1),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: fireInstance.currentUser?.phoneNumber != null
                    ? Icon(
                        Icons.verified_outlined,
                        size: 18,
                        color: primary_light,
                      )
                    : Container(),
              )
            ],
          ),
        ),
        trailing: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              fireInstance.currentUser?.phoneNumber != null
                  ? Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueGrey.shade300)),
                      child: TextButton.icon(
                          icon: Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          onPressed: () async {
                            await fun();
                          },
                          label: Text('update')),
                    )
                  : fireInstance.currentUser?.phoneNumber == null
                      ? Container(
                          width: 110,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.blueGrey.shade300)),
                          child: TextButton.icon(
                              icon: Icon(
                                Icons.check,
                                size: 15,
                              ),
                              onPressed: () async {
                                await fun();
                              },
                              label: Text('verify now')),
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
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          // fun();
        },
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: Container(
          child: TextField(
              controller: updateEmailFeild,
              decoration: InputDecoration(
                  hintText: 'Enter mail',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),
        ),
        trailing: Container(
          width: 200,
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 90,
                height: 30,
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
                    child: Text('Done')),
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
                      size: 22,
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
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          // fun();
        },
        autofocus: true,
        leading: Icon(icon, size: 20, color: light_color_type2),
        title: Container(
          child: TextField(
              controller: updateAchiveAmount,
              decoration: InputDecoration(
                  hintText: 'enter amount',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ))),
        ),
        trailing: Container(
          width: 200,
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 90,
                height: 30,
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
                    child: Text('Done')),
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
                      size: 22,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container WarningItem({title, icon, fun}) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        style: ListTileStyle.drawer,
        hoverColor: Colors.grey.shade200,
        selected: true,
        mouseCursor: MouseCursor.defer,
        onTap: () {
          fun();
        },
        autofocus: true,
        leading: Icon(icon, size: 20, color: Colors.red.shade300),
        title: AutoSizeText.rich(TextSpan(text: title),
            style: TextStyle(
              fontSize: 15,
              color: Colors.red,
            )),
      ),
    );
  }
}
