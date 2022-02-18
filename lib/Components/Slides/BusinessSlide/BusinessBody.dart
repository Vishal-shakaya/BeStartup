import 'package:be_startup/Components/Slides/BusinessSlide/BusinessForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Components/Slides/BusinessSlide/BusinessIcon.dart';


class BusinessBody extends StatelessWidget {
  const BusinessBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.7,

  /////////////////////////////////////////  
   ///  BUSINESS SLIDE :
   ///  1. BUSINESS ICON : 
   ///  2. INPUT FIELD TAKE BUSINESS NAME :  
   /////////////////////////////////////////  
        child: Column(
          children: [
            BusinessIcon(),
            Container(
              padding: EdgeInsets.all(10),
              height: context.height * 0.2,
              margin: EdgeInsets.only(top: context.height * 0.15),
              width: 500,

              child:BusinessForm()
            )

            ],
        ));
  }
}
