
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/RegistorFounderBody.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/RegistorTeamBody.dart';
import 'package:be_startup/Components/StartupSlides/SlideHeading.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';

class RegistorTeamView extends StatelessWidget {
  const RegistorTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          children: [
              SlideHeading(heading: registor_team_head_text,),
              RegistorTeamBody()
          ]
        )
      ),
    );
  }
}