import 'package:be_startup/Components/RegistorFounder/RegistorFounderBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class RegistorFounderView extends StatelessWidget {
  const RegistorFounderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: registor_founder_head_text,),
              RegistorFounderBody()
          ]
        )
      ),
    );
  }
}