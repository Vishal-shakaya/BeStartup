import 'package:be_startup/Components/HomeView/HomeHeaderSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;
    double page_height = 0.90;

    return Container(
      width: page_width,
      height: page_height,
      margin: EdgeInsets.only(top:context.height*0.02),
        child: Column(
          children: [

              // HEADER SECTION : 
              // 1 EXPLORE AND SEARCH BAR : 
              HomeHeaderSection(), 
          ],
    ));
  }
}
