import 'package:be_startup/Components/RegistorInvestor/ChooseCatigory/ChooseCatigoryBody.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CatigoryBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class ChooseCatigoryView extends StatelessWidget {
  const ChooseCatigoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: investor_choise_text,),
              ChooseCatigoryBody(), 
          ]
        )
      ),
    );
  }
}