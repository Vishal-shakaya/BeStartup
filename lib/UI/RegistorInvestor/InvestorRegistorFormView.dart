import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/InvestorRegistorFormbody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class InvestorRegistorForm extends StatelessWidget {
  const InvestorRegistorForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              Container(
                margin: EdgeInsets.only(top:50,bottom: 20),
                child: AutoSizeText.rich(
                  TextSpan(text: 'Fillup Required Details',
                  style: TextStyle(
                    fontSize: 25,
                  ) ),
                  style: context.textTheme.headline2,
                  ),
                
                ),
              InvestorRegistorFormBody(),
          ] 
        )
      ),
    );
  }
}