import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistorTeamBody extends StatefulWidget {
  const RegistorTeamBody({Key? key}) : super(key: key);

  @override
  State<RegistorTeamBody> createState() => _RegistorTeamBodyState();
}

class _RegistorTeamBodyState extends State<RegistorTeamBody> {
  double mem_dialog_width = 900;
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');

  ShowDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              // title:  MileDialogHeading(context),
              content: SizedBox(
                width: mem_dialog_width,
                child: TeamMemberDialog(
                  form_type: MemberFormType.create,
                ),
              ),
            ));
  }

  AddMember(context) {
    ShowDialog(context);
  }

  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>?> member_list = memeberStore.GetMembers();
    
    return Column(
      children: [
        Container(
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
                            label: Text('Add'))),
                  ],
                ),

                // MEMBER PROFILE LIST VIEW :
                // Image , name , position , email , then desc :
                Container(
                    height: context.height * 0.60,
                    width: context.width * 0.50,
                    child: Obx(
                      () {
                        return ListView.builder(
                            itemCount: member_list.length,
                            itemBuilder: (context, index) {
                              return MemberListView(
                                key: UniqueKey(),
                                member: member_list[index],
                                index : index,
                              );
                            });
                      }
                    ))
              ],
            )),
        TeamSlideNav(submitFounderDetail: () {}, slide: TeamSlideType.team)
      ],
    );
  }
}
