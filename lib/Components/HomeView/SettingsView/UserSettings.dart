import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Auth/MyAuthentication.dart';
import 'package:be_startup/Backend/Auth/Reauthenticate.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Components/HomeView/SettingsView/ReauthenticateDialog.dart';
import 'package:be_startup/Components/Widgets/PhoneNoVerification.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  var auth = Get.put(MyAuthentication(), tag: 'my_auth');
  FirebaseAuth fireInstance = FirebaseAuth.instance;

  var updateEmailFeild = TextEditingController();
  var is_update_mail = false;
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
              color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
                  child:PhoneNoVerifyDialogAlert(
                    noOperation: NumberOperation.update,
                    key:UniqueKey())
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
      var email = updateEmailFeild.text;
      // print(email);
      ReauthenticateDialog(
          task: ReautheticateTask.updateEmail, updateMail: email);
    }

    DeleteUser() async {
      await ReauthenticateDialog(
        task: ReautheticateTask.deleteProfile,
      );
      print('DeleteUser ');
    }

    VerifyPhoneno() async {
     PhoneNoVerificationDialog();
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
                    is_update_mail
                        ? TakeEmailAddress(fun: UpdateEmail)
                        : EditEmailItem(
                            title: fireInstance.currentUser?.email,
                            icon: Icons.email,
                            fun: () {},
                          ),
                    SettingItem(
                      title: 'Edit Profile',
                      icon: Icons.person,
                      fun: EditProfile,
                    ),
                    EditPhoneNo(
                        title: fireInstance.currentUser?.phoneNumber,
                        icon: Icons.phone,
                        fun: VerifyPhoneno),
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
                child: fireInstance.currentUser?.phoneNumber!=null
                ? Icon(Icons.verified_outlined,
                  size: 18,
                  color: primary_light,
                )
                :Container(), 
              )
            ],
          ),
        ),
        trailing: Container(
            width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey.shade300)),
                child: TextButton.icon(
                  icon: Icon(Icons.edit,size:15,),
                    onPressed: () async {
                      await fun();
                    },
                    label:Text('update')),
              ),

              fireInstance.currentUser?.phoneNumber==null?
              Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey.shade300)),
                child:  TextButton.icon(
                icon:   Icon(Icons.check,size: 15,),
                    onPressed: () async {
                      await fun();
                    },
                    label:Text('verify')),
              )
              :Container()
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
