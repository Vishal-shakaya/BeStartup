import 'dart:ui';
import 'package:be_startup/Components/WebLoginView/InfoPage/PhoneResponsiveRow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class ReverseBlock extends StatefulWidget {
  String? heading_text = '';
  String? body_text = '';
  Gradient? gradient1; 
  ReverseBlock({this.heading_text, this.body_text ,this.gradient1});

  @override
  State<ReverseBlock> createState() => _ReverseBlockState();
}

class _ReverseBlockState extends State<ReverseBlock> {
  @override
  Widget build(BuildContext context) {
    double heading_font_size = 27; 

    return Container(
      margin:EdgeInsets.only(top:context.height*0.09),
      child:
      context.width<800
        ?ResponsiveRow(
          heading_text: widget.heading_text,
          body_text: widget.body_text,
          gradient1: widget.gradient1,)  
          :Row(
        children:[

          ////////////////////////
          // TEXT SECTION:
          ////////////////////////
          Expanded(
            flex:1,
            child:Container(
              height:250, 
              margin:EdgeInsets.only(left:80),
              padding:EdgeInsets.all(10),
              // color: Colors.pink,
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    
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
                      margin:EdgeInsets.only(right:20, top:2),
                      width:context.width *0.05,
                      height: 12, 
                      child: a.GradientCard(
                        gradient: widget.gradient1!
                        ),
                    ),
              
                     // BODY TEXT BLOCK :
                    Container(
                      width:400,
                      margin: EdgeInsets.only(top:15),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                        style: Get.theme.textTheme.headline5,
                        children: [
                           TextSpan(
                             style: TextStyle(
                               letterSpacing: 1,                               
                             ),
                             text:widget.body_text
                             ) 
                        ]
                      )),
                    )
                  ]
                ),
              )
            ) 
          ),


            // Image BLock: 
          Expanded(
            flex:1,
            child:Container(
              margin:EdgeInsets.only(right:10),
              padding:EdgeInsets.all(10),
              // color: Colors.green,
              child:Image.asset(
                'assets/images/Info/Feature1.png',
                width:200,
                height:250,
                 fit:BoxFit.contain)
            ) 
          ),


   

        ]
      )
    );
  }
}
