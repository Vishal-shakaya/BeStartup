import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PHLoginIcon extends StatelessWidget {
  const PHLoginIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(5),
      margin:EdgeInsets.only(top:context.height*0.05),
      alignment:Alignment.center ,
      child:Card(
        elevation: 2,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),),

          child: Image.asset(logo_image,
          fit:BoxFit.fill,
          width:200, 
          height:130,
          ),
        )
    );
  }
}
