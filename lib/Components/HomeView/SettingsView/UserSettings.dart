import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Components/HomeView/SettingsView/ReauthenticateDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  var auth = Get.put(MyAuthentication(), tag: 'social_auth');

  // success alert :
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
            color: Get.isDarkMode
              ? Colors.white 
              : Colors.blueGrey.shade900),
        ));
  }

  @override
  Widget build(BuildContext context) {
    ReauthenticateDialog() async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: SizedBox(
              width: context.width * 0.20,
              height: context.height * 0.50,
              child: ReauthenticateWidget(),
            ));
          });
    }

    ResetPassword() async {
      await auth.ResetPasswordWithEmail();
      await ResultDialog(context);
    }

    SecondFactAuth() async {
      print('SecondFactAuth ');
    }

    EditProfile() async {
      print('EditProfile ');
    }

    UpdateEmail() async {
      await ReauthenticateDialog();
      print('UpdateEmail ');
    }

    DeleteUser() async {
      try {
        var resp = await auth.Deleteuser();
        print(resp);
      } catch (e) {
        print('Error while Delete account');
      }
    }

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
                    SettingItem(
                      title: 'Rest Pasword',
                      icon: Icons.settings,
                      fun: ResetPassword,
                    ),
                    SettingItem(
                      title: '2 Factor Auth',
                      icon: Icons.verified_rounded,
                      fun: SecondFactAuth,
                    ),
                    SettingItem(
                      title: 'Update Email',
                      icon: Icons.email,
                      fun: UpdateEmail,
                    ),
                    SettingItem(
                      title: 'Edit Profile',
                      icon: Icons.person,
                      fun: EditProfile,
                    ),
                    WarningItem(
                        title: 'Delete Account',
                        icon: Icons.delete_rounded,
                        fun: DeleteUser)
                  ],
                ))));
  }

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
