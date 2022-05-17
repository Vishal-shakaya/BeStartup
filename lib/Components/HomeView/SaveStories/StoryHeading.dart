import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
class SaveStoryHeading extends StatelessWidget {
  const SaveStoryHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:context.height*0.23,
      left:context.width*0.11, 

      child: Container(
        width:context.width*0.23,
        child: AutoSizeText.rich(
          TextSpan(
            text: 'A Flutter package landscape guide comprising', 
          ),
            style: context.textTheme.headline2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ));
  }
}
