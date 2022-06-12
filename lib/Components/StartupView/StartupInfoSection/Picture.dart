import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Picture extends StatelessWidget {
  String? logo = temp_logo;

  Picture({this.logo, Key? key}) : super(key: key);

  EditBusinessLogo() {
    Get.toNamed(create_business_detail_url, parameters: {'type':'update'});
  }

  @override
  Widget build(BuildContext context) {
    double profile_top_pos = 0.19;
    double profile_left_pos = 0.01;
    return Positioned(
        top: context.height * profile_top_pos,
        left: context.width * profile_left_pos,
        child: Stack(
          children: [
            Card(
              elevation: 5,
              shadowColor: light_color_type3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(62)),
              child: Container(
                child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blueGrey[100],
                    foregroundImage: NetworkImage(logo!)),
              ),
            ),
            Positioned(
              top: context.height * 0.09,
              left: context.width * 0.05,
              child: Container(
                padding: EdgeInsets.all(5),
                child: IconButton(
                  onPressed: () {
                    EditBusinessLogo();
                  },
                  icon: Icon(
                    Icons.edit,
                  size: 19,
                  color:light_color_type3)),
              ))
          ],
        ));
  }
}
