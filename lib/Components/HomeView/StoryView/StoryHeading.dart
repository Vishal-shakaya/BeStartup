import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StoryHeading extends StatelessWidget {
  var startup_name;
  StoryHeading({
    required this.startup_name,
    Key? key,
  }) : super(key: key);

  double heading_pos_top = 0.23;
  double heading_pos_left = 0.11;
  double heading_width = 0.23; 
  double heading_fontSize =20; 

  @override
  Widget build(BuildContext context) {
     heading_pos_top = 0.23;
     heading_pos_left = 0.11;
     heading_width = 0.23; 
     heading_fontSize =20;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      heading_pos_top = 0.23;
      heading_pos_left = 0.11;
      heading_width = 0.23; 
      heading_fontSize =20;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.15;
        heading_width = 0.23; 
        print('1500');
    }

    if (context.width < 1400) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.18;
        heading_width = 0.23; 
        print('1400');
    }

    if (context.width < 1200) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.21;
        heading_width = 0.23; 
      print('1200');
    }

    if (context.width < 1000) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.25;
        heading_width = 0.23; 
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.33;
        heading_width = 0.23; 
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.36;
        heading_width = 0.26; 
        heading_fontSize =18;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
        heading_pos_top = 0.23;
        heading_pos_left = 0.36;
        heading_width = 0.30; 
        heading_fontSize =15;
      print('480');
    }

    return Positioned(
        top: context.height * heading_pos_top,
        left: context.width * heading_pos_left,

        child: Container(
          alignment: Alignment.center,
          width: context.width * heading_width,
         
          child: AutoSizeText.rich(
            TextSpan(
              text: startup_name.toString().capitalizeFirst,
            ),
            style: context.textTheme.headline2?.copyWith(
              fontSize: heading_fontSize
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
