import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStoryButton extends StatelessWidget {
  const ViewStoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.height * 0.23,
      left: context.width * 0.38,
      child: Container(
          // width: context.width * 0.48,
          alignment: Alignment.topRight,
          // margin: EdgeInsets.only(top: context.height*0.04),
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primary_light2)),
            child: TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye_rounded,
                  size: 15,
                  color: Colors.teal.shade500,
                ),
                label: Text(
                  'view',
                  style: TextStyle(color: Colors.teal.shade500),
                )),
          )),
    );
  }
}
