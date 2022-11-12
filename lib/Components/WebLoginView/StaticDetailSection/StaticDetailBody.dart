import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionOne.dart';
import 'package:be_startup/Components/WebLoginView/StaticDetailSection/StaticSectionTwo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StaticDetailSectionBody extends StatelessWidget {
  var pixels ; 
  
   StaticDetailSectionBody({
    required this.pixels, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 1300),
        opacity: pixels >=3900 ? 1.0 : 0.0,

      child: Container(
        margin: EdgeInsets.only(
          top:context.height*0.01,
          bottom: context.height*0.08 ),
        
        width: context.width*0.60,
        height: context.width*0.25,
        
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 15,
          shadowColor: Colors.blueGrey,
          child: Row(
            children :  [
              
            // SECTION ONE :   
            StaticSectionOne(
              pixels: pixels,
            ),
    
            // DIVIDER : 
            VerticalDivider(), 
    
             // INVESTOR :   
             Expanded(
              child: Container(
                child: StatiSectionTwo(),
              )),  
    
            ]
          ),
        ),
      ),
    );
  }
}

