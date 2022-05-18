import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {

    ResetPassword() async {
      print('Password Reset');
    }

    SecondFactAuth() async {
      print('SecondFactAuth ');
    }

    EditProfile() async {
      print('EditProfile ');
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
                      fun: ResetPassword,),

                    SettingItem(
                      title: '2 Factor Auth',
                      icon: Icons.mail,
                      fun: SecondFactAuth,),

                    SettingItem(
                      title: 'Edit Profile',
                      icon: Icons.person,
                      fun: EditProfile,),

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
        leading: Icon(icon, size: 20, color: Colors.blueGrey.shade200),
        title: AutoSizeText.rich(
          TextSpan(text: title),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ),
    );
  }
}
