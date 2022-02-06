import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top:50),
        width:100.w,
        height:context.height *0.10,
        color:  Get.isDarkMode? Colors.blueGrey.shade700: Colors.blueGrey.shade900,
        child:Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
                child:RichText(
                  text: TextSpan(
                    style: Get.theme.textTheme.headline5,
                    children: [
                      TextSpan(
                        text:copyright_text,
                        style:TextStyle(
                          color: Colors.blueGrey.shade100
                        )
                      )
                    ]
                  ))
              )
          ]
        ) 
    );
  }
}
