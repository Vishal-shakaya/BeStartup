import 'package:be_startup/Components/WebLoginView/InfoPage/PhoneResponsiveRow.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class FeatureBlock extends StatefulWidget {
  String? heading_text = '';
  String? body_text = '';
  Gradient? gradient1;
  String image = '';

  var pixels ; 

  FeatureBlock(
      {
        required this.pixels,
        required this.image, 
        this.heading_text, 
        this.body_text, 
        this.gradient1});

  @override
  State<FeatureBlock> createState() => _FeatureBlockState();
}

class _FeatureBlockState extends State<FeatureBlock> {
  @override
  Widget build(BuildContext context) {

    double heading_font_size = 27;

    return Container(
        margin: EdgeInsets.only(
            top: context.height * 0.09, bottom: context.height * 0.05),
        // color: Colors.grey.shade100,

        child: context.width < 800
            ? ResponsiveRow(
                heading_text: widget.heading_text,
                body_text: widget.body_text,
                gradient1: widget.gradient1,
              )
            : Row(children: [
                /////////////////////////////////////////////
                // IMAGE SECTION :
                /////////////////////////////////////////////
                Expanded(
                    flex: 1,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1200),
                      opacity: widget.pixels >=500 ? 1.0 : 0.0,

                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(widget.image,
                              scale: 1,
                              width: context.width * 0.35,
                              height: context.height * 0.50,
                              fit: BoxFit.contain)),
                    )),

                ////////////////////////
                // TEXT SECTION:
                ////////////////////////
                Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 3,
                      color: Colors.grey.shade100,
                      shadowColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    
                    
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 1000),
                        opacity: widget.pixels >=500 ? 1.0 : 0.0,

                        child: AnimatedPadding(
                        duration: Duration(milliseconds: 1000),
                        padding:EdgeInsets.only(
                          left: widget.pixels >=500 ? 0.0 : context.width*0.05,
                        ) , 

                          child: Container(
                              color: Colors.grey.shade100,
                              alignment: Alignment.center,
                              width: context.width * 0.40,
                              height: context.height * 0.45,
                              margin: EdgeInsets.only(
                                  right: context.width * 0.01,
                                  left: context.width * 0.01),
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
                                                style:
                                                    Get.theme.textTheme.headline3,
                                                children: [
                                              TextSpan(
                                                text: widget.heading_text,
                                                style: TextStyle(
                                                  color:
                                                      login_page_detail_sec_title_color,
                                                  fontSize: context.width < 890
                                                      ? 23
                                                      : heading_font_size,
                                                ),
                                              ),
                                            ])),
                                      ),
                                              
                                      // GRADIENT HEADER :
                                      Container(
                                        // padding:EdgeInsets.all(50),
                                        margin: EdgeInsets.only(right: 20, top: 2),
                                        width: context.width * 0.05,
                                        height: 12,
                                              
                                        child: a.GradientCard(
                                            gradient: widget.gradient1!),
                                      ),
                                              
                                      // BODY TEXT BLOCK :
                                      Container(
                                        width: 400,
                                        margin: EdgeInsets.only(top: 15),
                                        child: RichText(
                                            text: TextSpan(
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(),
                                                  color:
                                                      login_page_detail_sec_desc_color,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                ),
                                                children: [
                                              TextSpan(
                                                text: widget.body_text,
                                              )
                                            ])),
                                      )
                                    ]),
                              )),
                        ),
                      ),
                    )),
              ]));
  }
}
