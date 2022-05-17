import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
class ProfileStoryHeading extends StatelessWidget {
  const ProfileStoryHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:context.height*0.18,
      left:context.width*0.05, 

      child: Container(
        width:context.width*0.23,
        margin:EdgeInsets.only(top:context.height*0.02),
        child: AutoSizeText.rich(
          TextSpan(
            text: 'A Flutter package landscape guide comprising', 
            style:TextStyle(fontSize: 18)
          ),
            style: context.textTheme.headline2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ));
  }
}
