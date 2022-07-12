import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StoryHeading extends StatelessWidget {
  var startup_name; 
  StoryHeading({
    required this.startup_name, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: context.height * 0.23,
        left: context.width * 0.11,
        child: Container(
          alignment: Alignment.center,
          width: context.width * 0.23,
          child: AutoSizeText.rich(
            TextSpan(
              text: startup_name.toString().capitalizeFirst,
            ),
            style: context.textTheme.headline2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
