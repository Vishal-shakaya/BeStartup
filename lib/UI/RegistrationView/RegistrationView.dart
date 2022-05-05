import 'package:be_startup/Components/SelectUserType/UserType.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatefulWidget {
  RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            child:SingleChildScrollView(
              child: Column(
                children: [
                  UserType(), 
                ],
              ),
            )
      ),
    );
  }
}