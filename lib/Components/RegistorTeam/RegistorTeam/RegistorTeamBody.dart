import 'package:be_startup/Components/RegistorTeam/RegistorFounder/FounderImage.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/RegistorFounderForm.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistorTeamBody extends StatefulWidget {
  const RegistorTeamBody({Key? key}) : super(key: key);

  @override
  State<RegistorTeamBody> createState() => _RegistorTeamBodyState();
}

class _RegistorTeamBodyState extends State<RegistorTeamBody> {
  ShowDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              // title:  MileDialogHeading(context),
              content: SizedBox(
                width: milestone_width,
                child: TeamMemberDialog(),
              ),
            ));
  }

  AddMember(context) {
    ShowDialog(context);
  }

  double milestone_width = 900;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height * 0.7,
        width: context.width * 0.7,
        /////////////////////////////////////////
        ///  BUSINESS SLIDE :
        ///  1. BUSINESS ICON :
        ///  2. INPUT FIELD TAKE BUSINESS NAME :
        /////////////////////////////////////////
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(flex: 1, child: Container()),
                Container(
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primary_light)),
                        onPressed: () {
                          AddMember(context);
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add')))
              ],
            ),
          ],
        ));
  }
}
