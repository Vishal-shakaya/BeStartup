import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double profile_top_pos = 0.18;
  double profile_left_pos = 0.01;
    return Positioned(
      top: context.height * profile_top_pos,
      left: context.width * profile_left_pos,
      child: Card(
        elevation: 5,
        shadowColor: light_color_type3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
        child: Container(
            child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blueGrey[100],
          foregroundImage: NetworkImage(
              'https://i.pinimg.com/originals/1e/c3/17/1ec317142711af99cce906ef35a2f44f.jpg'),
        )),
      ),
    );
  }
}