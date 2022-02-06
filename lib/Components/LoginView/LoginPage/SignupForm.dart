import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23)),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              margin: EdgeInsets.only(top:40),
              width: Get.width*0.5,

              child: Text('${signup_heading_msg}',
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.headline2
                ),
            ),

            Container(
              width:200,
              margin: EdgeInsets.only(bottom:40),

              child:RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style:Get.theme.textTheme.headline5, 
                  children:[
                    TextSpan(
                    text:signup_detail_message,
                    style: TextStyle(
                      fontSize: 15, 
                    )
                    )
                  ]
                ),
              )
            ),

            Container(
              margin: EdgeInsets.only(bottom:20),
              width:220,
              height:50,  

              child: a.GradientElevatedButton(
                gradient: g1,
                onPressed: () {}, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.orange)
                    ))),
                
                child: Text('Signup Now',
                          style:  TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ))
                ),
            )
          ],
        ));
  }
}
