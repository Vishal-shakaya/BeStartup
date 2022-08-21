import 'package:be_startup/Components/SelectPlan/SelectPlan.dart';
import 'package:flutter/material.dart';

class RegistorTeamView extends StatelessWidget {
  const RegistorTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SelectPlan()
          ]
        )
      ),
    );
  }
}