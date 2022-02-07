import 'package:be_startup/Components/LoginView/InfoPage/PhoneResponsiveRow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class FeatureBlock extends StatefulWidget {
  String? heading_text = '';
  String? body_text = '';
  Gradient? gradient1; 
  FeatureBlock({this.heading_text, this.body_text, this.gradient1});

  @override
  State<FeatureBlock> createState() => _FeatureBlockState();
}

class _FeatureBlockState extends State<FeatureBlock> {
  @override
  Widget build(BuildContext context) {
    double heading_font_size = 27; 

    return Container(
        margin: EdgeInsets.only(top: context.height*0.09),
        child: context.width<800
        ?ResponsiveRow(
          heading_text: widget.heading_text,
          body_text: widget.body_text,
          gradient1: widget.gradient1,)  
        :Row(
          mainAxisSize: MainAxisSize.max,
          children: [
          ////////////////////////
          // IMAGE SECTION :
          ////////////////////////
           Expanded(
              flex: 1,
              child: Container(
                  // margin:EdgeInsets.all(40),
                  padding: EdgeInsets.all(10),
                  // color: Colors.green,
                  child: Image.asset('assets/images/Info/Feature1.png',
                      width: 200, height: 250, fit: BoxFit.contain))
          ),

          ////////////////////////
          // TEXT SECTION:
          ////////////////////////
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
        ]));
  }
}
