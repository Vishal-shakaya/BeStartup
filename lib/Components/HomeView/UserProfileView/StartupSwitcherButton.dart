import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class StartupSwitcherButton extends StatefulWidget {
  var switchStartup;
  StartupSwitcherButton({this.switchStartup, Key? key}) : super(key: key);

  @override
  State<StartupSwitcherButton> createState() => _StartupSwitcherButtonState();
}

class _StartupSwitcherButtonState extends State<StartupSwitcherButton> {
  var menuType = FounderStartupMenu.my_startup;

  int value = 0;
  bool positive = false;

  double switch_btn_top_margin = 0.04;
  double switch_btn_right_margin = 0.70;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * switch_btn_top_margin,
        right: context.height * switch_btn_right_margin,
      ),
      child: AnimatedToggleSwitch<bool>.dual(
        current: positive,
        first: false,
        second: true,
        dif: 10.0,
        borderColor: Colors.transparent,
        borderWidth: 5.0,
        height: 20,
        indicatorSize: Size(20, 20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          ),
        ],

        onChanged: (b) {
          if (b == true) {
            widget.switchStartup(FounderStartupMenu.my_startup);
          }
          if (b == false) {
            widget.switchStartup(FounderStartupMenu.intrested);
          }
          setState(() => positive = b);
        },
        
        colorBuilder: (b) => b ? Colors.red : Colors.green,
        iconBuilder: (value) => value
            ? Icon(Icons.coronavirus_rounded, size: 18)
            : Icon(Icons.tag_faces_rounded, size: 18),
      ),

      //  FlipCard(
      //   onFlipDone: (done) {
      //     if (done) {
      //       if (menuType == FounderStartupMenu.intrested) {
      //         menuType = FounderStartupMenu.my_startup;
      //         frontText = 'SUP';
      //         backText = 'Interested';
      //       } else {
      //         menuType = FounderStartupMenu.intrested;
      //         frontText = 'Interested';
      //         backText = 'SUP';
      //       }

      //       setState(() {});
      //     }
      //   },
      //   direction: FlipDirection.VERTICAL,
      //   alignment: Alignment.topRight,
      //   front: StartupMenuSwitcher(title: '$frontText'),
      //   back: StartupMenuSwitcher(title: '$backText'),
      // ),
    );
  }
}
