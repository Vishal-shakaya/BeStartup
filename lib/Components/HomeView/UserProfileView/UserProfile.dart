import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeViewUserProfile extends StatelessWidget {
  HomeViewUserProfile({Key? key}) : super(key: key);

  var user_image = temp_avtar_image;
  var user_position = '_____________';
  var user_email = '_____________';
  var user_phoneno = '____________';
  var user_name = '_____________';
  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    user_image = await getUserProfileImage ?? temp_avtar_image;
    user_position = await getUserPosition ?? '';
    user_email = await getuserEmail ?? user_email;
    user_phoneno = await getUserPhoneno ?? user_phoneno;
    user_name = await getUserName ?? user_name;

    // print(user_name);
    // print(user_image);
    // print(user_email);
    // print(user_position);
    // print(user_phoneno);
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
                    baseColor: shimmer_base_color,
                    highlightColor: shimmer_highlight_color,
                    child: MainMethod()));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod();
          }
          return MainMethod();
        });
  }

///////////////////////////////////////
  /// MainMethod:
///////////////////////////////////////
  Column MainMethod() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileImage(),
        // POSITION:
        SizedBox(
          width: 200,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              MemName(),

              SizedBox(
                height: 5,
              ),
              // CONTACT EMAIL ADDRESS :
              MemPosition(),

              MemContact(
                text: user_email.toString().capitalizeFirst,
                icon: Icons.mail_outline_outlined ), 

              MemContact(
                text: user_phoneno,
                icon: Icons.call,
              ), 
            ],
          ),
        ),
      ],
    );
  }

  Card ProfileImage() {
    return Card(
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(user_image),
      )),
    );
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: user_name,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16))
    ])));
  }

  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: user_position,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12))
    ])));
  }

  Container MemContact({text , icon}) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            icon,
            color: Colors.orange.shade800,
            size: 16,
          ),
        ),
        AutoSizeText.rich(
          TextSpan(
            style: Get.textTheme.headline5,
             children: [
          TextSpan(
              text: text,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}
