  
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


  Container MainUserStartupsShimmer(BuildContext context) {
    return Container(
            width: context.width * 0.40,
            height: context.height * 0.30,
            margin: EdgeInsets.only(top: context.height * 0.03),
              child: Card(
                color: shimmer_background_color,
                elevation: 10,
                shadowColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  ),
                child: CustomShimmer(text: 'Waiting for Startups...')),
          );
  }