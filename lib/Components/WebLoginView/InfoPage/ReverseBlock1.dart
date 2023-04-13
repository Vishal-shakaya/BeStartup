import 'package:be_startup/Components/WebLoginView/InfoPage/PhoneResponsiveRow.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class ReverseBlock1 extends StatefulWidget {
  String? heading_text = '';
  String? body_text = '';
  String image = '';
  Gradient? gradient1;
  var pixels; 

  ReverseBlock1(
      {
        required this.pixels, 
        required this.image, 
        this.heading_text, 
        this.body_text, 
        this.gradient1});

  @override
  State<ReverseBlock1> createState() => _ReverseBlock1State();
}

class _ReverseBlock1State extends State<ReverseBlock1> {
  @override
  Widget build(BuildContext context) {
    double heading_font_size = 23;

    return Container(
        margin: EdgeInsets.only(
            bottom: context.height * 0.10, top: context.height * 0.10),
        child: context.width < 800
            ? ResponsiveRow(
                heading_text: widget.heading_text,
                body_text: widget.body_text,
                gradient1: widget.gradient1,
                image: widget.image,
              )
            : Row(children: [
                ////////////////////////
                // TEXT SECTION:
                ////////////////////////
                Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 2,
                      color: Colors.grey.shade100,
                      shadowColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                     
                     
                      child: AnimatedOpacity(
                          duration: Duration(milliseconds: 1000),
                          opacity: widget.pixels >=2100 ? 1.0 : 0.0,
                       
                        child: AnimatedPadding(
                          
                          duration: Duration(milliseconds: 1000),
                          padding:EdgeInsets.only(
                            right: widget.pixels >=2100 ? 0.0 : context.width*0.05,
                          ),


                          child: Container(
                              width: context.width * 0.40,
                              height: context.height * 0.35,
                              alignment: Alignment.center,
                              color: Colors.grey.shade100,
                              margin: EdgeInsets.only(
                                  left: context.width * 0.02,
                                  right: context.width * 0.01),
                              padding: EdgeInsets.all(10),
                                              
                              // color: Colors.pink,
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                         width: context.width*0.30,
                                        child: RichText(
                                            text: TextSpan(
                                                style:
                                                    Get.theme.textTheme.headline3,
                                                children: [
                                              TextSpan(
                                                text: widget.heading_text,
                                                style: TextStyle(
                                                  color:
                                                      login_page_detail_sec_title_color,
                                                  fontSize: context.width < 890
                                                      ? 20
                                                      : heading_font_size,
                                                ),
                                              ),
                                            ]),textAlign: TextAlign.center,),
                                      ),
                                              
                                      // GRADIENT HEADER :
                                      Container(
                                        margin: EdgeInsets.only(right: 20, top: 2),
                                        width: context.width * 0.05,
                                        height: 12,
                                        child: a.GradientCard(
                                            gradient: widget.gradient1!),
                                      ),
                                              
                                      // BODY TEXT BLOCK :
                                      Container(
                                        width: context.width*0.35,
                                        margin: EdgeInsets.only(top: 15),
                                        alignment: Alignment.center,
                                        child: RichText(
                                            text: TextSpan(
                                                style:Get.theme.textTheme.headline5,
                                                children: [
                                               TextSpan(
                                                  style: TextStyle(
                                                    color:login_page_detail_sec_desc_color,
                                                    letterSpacing: 1,
                                                    fontSize: 16,
                                                    height: 2, 
                                                   ),
                                                  text: widget.body_text)
                                            ]),textAlign: TextAlign.center,),
                                      )
                                    ]),
                              )),
                        ),
                      ),
                    )),


                // Image BLock:
                Expanded(
                    flex: 1,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1100),
                      opacity: widget.pixels >=2100 ? 1.0 : 0.0,
                     
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(5),
                          // color: Colors.green,
                          child: Image.asset(widget.image,
                              scale: 1,
                              width: context.width * 0.35,
                              height: context.height * 0.45,
                              fit: BoxFit.contain)),
                    )),
              ]));
  }
}
