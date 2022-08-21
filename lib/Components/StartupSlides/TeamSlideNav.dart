import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TeamSlideType {
  founder,
  team,
}

class TeamSlideNav extends StatefulWidget {
  TeamSlideType slide;
  Function? submitform;
  TeamSlideNav({required this.submitform, required this.slide, Key? key})
      : super(key: key);

  @override
  State<TeamSlideNav> createState() => _TeamSlideNavState();
}

class _TeamSlideNavState extends State<TeamSlideNav> {
  BackWordButton(slide) {
    // Back to user type page:
    if (TeamSlideType.founder == slide) {
        Get.toNamed(user_type_slide_url);
    }

    if (TeamSlideType.team == slide) {
        Get.toNamed(create_founder);
    }
  }

  ForwordButton(slide) async {
    if (TeamSlideType.founder == slide) {
       await  widget.submitform!();
    }
    if (TeamSlideType.team == slide) {
       await  widget.submitform!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.50,
      height: context.height * 0.15,
      child: Row(
        children: [
          // Back Button:
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    BackWordButton(widget.slide);
                  },
                  child: Text('BACK'))),

          // Animation:
          Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('progress indicatior')],
                ),
              )),

          // NextSlideButton
          Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    ForwordButton(widget.slide);
                  },
                  child: Text('NEXT'))),
        ],
      ),
    );
  }
}
