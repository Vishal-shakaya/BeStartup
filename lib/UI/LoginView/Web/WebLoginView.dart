// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:be_startup/Components/LoginView/InfoPage.dart';
import 'package:be_startup/Components/LoginView/LoginPage/HeaderText.dart';
import 'package:be_startup/Components/LoginView/LoginPage/LogoContainer.dart';
import 'package:be_startup/Components/LoginView/LoginPage.dart';
import 'package:be_startup/Components/Widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLoginView extends StatefulWidget {
  WebLoginView({Key? key}) : super(key: key);

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> {
  @override
  Widget build(BuildContext context) {
    // RESPONSIVE POINTS :
    // 1 800 Login Tabs:
    // 2 1150 Hide image: 
    // 3 890 Info Page  :
    // 4.800 Info Page Andd Responsive Row:
    return SingleChildScrollView(
      // Login Page : 
      child: Column(
        children: [
          // Header Heading: 
          HeaderText(),

          // BE STARTUP LOGO: 
          LogoContainer(),

          //  LOGIN FORM AND SIDE IMAGE:
          LoginPage(),

          // INFO PAGE:
          InfoPage(),

          // BOTTAM BAR :
          BottomBar(),
      ]),
    );
  }
}
