import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StoryCeoProfile extends StatelessWidget {
  const StoryCeoProfile({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    double profile_top_pos = 0.14;
    double profile_left_pos = 0.01;
    
    return Positioned(
      top: context.height * profile_top_pos,
      left: context.width * profile_left_pos,
      child: Column(
        children: [
          Card(
            elevation: 5,
            shadowColor: light_color_type3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
            child: Container(
                child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blueGrey[100],
              foregroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/1e/c3/17/1ec317142711af99cce906ef35a2f44f.jpg'),
            )),
          ),

          // Container Name : 
          Container(
            margin: EdgeInsets.only(top:10),
            child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: 'Vishal Shakaya',
              style: TextStyle(
                  color: Colors.black, 
                  fontSize: 13))
        ])))
        ],
      ),
    );
  }
}


