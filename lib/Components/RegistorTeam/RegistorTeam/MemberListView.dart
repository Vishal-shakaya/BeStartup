import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum MemberFormType { edit, create }

class MemberListView extends StatefulWidget {
  Map<String, dynamic>? member;
  int? index;
  
  MemberListView({this.index, this.member, Key? key}) : super(key: key);

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
  double mem_desc_block_width = 0.30;
  double mem_desc_block_height = 0.20;
  double mem_dialog_width = 900;
  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');
  // REMOVE MEMBER FROM LIST :
  RemoveMember(id) async {
    await memeberStore.RemoveMember(widget.member!['id']);
  }

//  EDIT MEMBER DETAIL :
  EditMember() async {
    // SET DEFAULT IMAGE; 
    memeberStore.SetProfileImage(widget.member!['image']);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              // title:  MileDialogHeading(context),
              content: SizedBox(
                width: mem_dialog_width,
                child: TeamMemberDialog(
                  form_type: MemberFormType.edit,
                  member: widget.member,
                  index: widget.index,
                  
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Profile Image and Member Detail :
          Container(
            padding: EdgeInsets.all(12),

            // MEMBER DETAIL SECTION :
            child: Column(
              children: [
                // Profile Image
                ProfileImage(),

                // SPACING:
                SizedBox(
                  height: 15,
                ),

                // POSITION:
                SizedBox(
                  width:200, 
                  child: Column(
                    children: [
                      MemPosition(),
                      // MEMBER NAME :
                      MemName(),
                      // CONTACT EMAIL ADDRESS :
                      MemContact(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // SPACING:
          SizedBox(
            width: context.width * 0.04,
          ),

          // MEMBER DESCRIPTION SECTION :
          MemDescription(context),

          Container(
            height: context.height * 0.20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /////////////////////////////
                // DELETE MEMBER BUTTON :
                /////////////////////////////
                Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await RemoveMember(widget.member!['id']);
                    },
                    radius: 15,
                    child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red.shade300,
                        child: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 15,
                            ))),
                  ),
                ),

                // SPACING :
                SizedBox(
                  height: 5,
                ),

                /////////////////////////////
                // EDIT PRODUCT BUTTON:
                /////////////////////////////
                Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      EditMember();
                    },
                    radius: 15,
                    child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue.shade300,
                        child: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Card MemDescription(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        width: context.width * mem_desc_block_width,
        height: context.height * mem_desc_block_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 0, color: Colors.grey.shade200)),
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: RichText(
              maxLines: 6,
              text: TextSpan(children: [
                // Heading Texct :
                TextSpan(
                  text: widget.member!['meminfo'],
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(),
                    color: light_color_type3,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.70,
                  ),
                ),
              ])),
        ),
      ),
    );
  }

  Container MemContact() {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade300,
            size: 16,
          ),
        ),
        AutoSizeText.rich(
          TextSpan(
            style: Get.textTheme.headline5, 
            children: [
          TextSpan(
              text: widget.member!['member_mail'],
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.blue, fontSize: 11))
        ])),
      ],
    ));
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: widget.member!['name'],
          style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 13))
    ])));
  }

  Container MemPosition() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              text: widget.member!['position'],
              style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 15))
        ])));
  }

  Container ProfileImage() {
    return Container(
        child: CircleAvatar(
      radius: 70,
      backgroundColor: Colors.blueGrey[100],
      foregroundImage: NetworkImage(widget.member!['image']),
    ));
  }
}
