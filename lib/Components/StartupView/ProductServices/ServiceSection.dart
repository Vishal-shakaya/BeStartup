import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Products.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Services.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ServiceSection extends StatelessWidget {
  const ServiceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: context.width*0.70,
      height: context.height*0.50,
      margin: EdgeInsets.only(bottom: context.height*0.06,top:context.height*0.06),
      child: SingleChildScrollView(
        child: Column(
          children: [            
           Services(),
           Services(),
           Services(),
           Services(),
      
          ],
        ),
      ),
    );
  }
  
}
