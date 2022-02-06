import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:be_startup/Components/LoginView/InfoPage/PhoneResponsiveRow.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:get/get.dart';
class ResponsiveRow extends StatefulWidget {
  String? heading_text = '';
  String? body_text = '';
  Gradient? gradient1; 
  ResponsiveRow({this.heading_text, this.body_text, this.gradient1});

  @override
  State<ResponsiveRow> createState() => _ResponsiveRowState();
}

class _ResponsiveRowState extends State<ResponsiveRow> {
  @override
  Widget build(BuildContext context) {
    double heading_font_size = 27; 
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    // margin:EdgeInsets.all(40),
                    padding: EdgeInsets.all(10),
                    // color: Colors.green,
                    child: Image.asset('assets/images/Info/Feature1.png',
                        width: 200, height: 250, fit: BoxFit.contain))
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 200,
                  margin: EdgeInsets.only(right: 50),
                  padding: EdgeInsets.all(10),
                  // color: Colors.pink,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // HEADER TEXT :
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style:Get.theme.textTheme.headline3,
                                children: [
                                  TextSpan(
                                    text:widget.heading_text,
                                    style:TextStyle(
                                      fontSize:context.width<890 ? 23 :heading_font_size, 
                                    ),
                                  ),
                                ]
                              ) 
                            ),
                          ),
                  
                          // GRADIENT HEADER :
                          Container(
                            // padding:EdgeInsets.all(50),
                            margin: EdgeInsets.only(right:20, top: 2),
                            width: context.width *0.05,
                            height: 12,
                  
                            child: a.GradientCard(gradient: widget.gradient1!),
                          ),
                  
                          // BODY TEXT BLOCK :
                          Container(
                            width: 400,
                            margin: EdgeInsets.only(top: 15),
                            
                            child: RichText(
                              textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: Get.theme.textTheme.headline5,
                                  children: [
                                  TextSpan(
                                    style: TextStyle(
                                        letterSpacing: 1,
                                    ),
                                    text: widget.body_text
                                    )
                                ])),
                          )
                        ]),
                  )
                  )
                ),
          ],
        )
      ],
    );
  }
}