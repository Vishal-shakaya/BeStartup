import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PHBottomBar extends StatefulWidget {
  Function setPageState;
  String main_text = '';
  String desc_text = '';
  String btn_text = '';

  PHBottomBar({
    required this.setPageState,
    required this.main_text,
    required this.desc_text   
    });

  @override
  State<PHBottomBar> createState() => _PHBottomBarState();
}

class _PHBottomBarState extends State<PHBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.10,
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            widget.setPageState();
          },
          child: RichText(
              text: TextSpan(style: TextStyle(letterSpacing: 2), children: [
            TextSpan(
                text: '${widget.desc_text}', style: TextStyle(color: light_color_type3)),
            TextSpan(
                text: '${widget.main_text}',
                style: TextStyle(
                    color: primary_light, fontWeight: FontWeight.bold))
          ])),
        ));
  }
}
