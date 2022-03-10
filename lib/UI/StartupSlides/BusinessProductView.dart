import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class BusinessProductView extends StatelessWidget {
  const BusinessProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
            SlideHeading(heading: product_heading_text,),
            ProductBody(),  
          ]
        )
      ),
    );
  }
}