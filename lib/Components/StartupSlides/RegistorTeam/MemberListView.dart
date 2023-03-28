import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Team/CreateTeamStore.dart';
import 'package:be_startup/Components/StartupSlides/RegistorTeam/TeamMemberDialog.dart';

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
  double mem_desc_block_width = 0.32;
  double mem_desc_block_height = 0.17;
 
  double mem_desc_text = 14; 

  double ver_mem_desc_block_width = 0.60;
  double ver_mem_desc_block_height = 0.20;

  double ver_mem_desc_text = 13; 

  double mem_dialog_width = 900;

  var memeberStore = Get.put(BusinessTeamMemberStore(), tag: 'team_memeber');

  // REMOVE MEMBER FROM LIST :
  RemoveMember(id) async {
    await memeberStore.RemoveMember(id: widget.member!['id'] , path:widget.member!['path']);
  }

  //  EDIT MEMBER DETAIL :
  EditMember() async {
    // SET DEFAULT IMAGE;
    memeberStore.SetProfileImage(widget.member!['image']);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Colors.blueGrey.shade800,
                    )),
              ),
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
    /////////////////////////////////
    /// Vertical View :
    /////////////////////////////////
    Widget verticalViewWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile Image and Member Detail :
        ProfileSection(),

        // Edit And Delete Button :
        EditAndDeleteButtonRow(context),

        // Description:
        VerticalMemDescription(context),
      ],
    );

    //////////////////////////////////
    /// Horizontal view :
    //////////////////////////////////
    Widget horizontalViewWidget = Row(
      children: [
        // Profile Image and Member Detail :
        ProfileSection(),

        // SPACING:
        SizedBox(width: context.width * 0.04),

        // Sescription:
        MemDescription(context),

        // Edit And Delete Button :
        EditAndDeleteButton(context)
      ],
    );

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      ver_mem_desc_block_width = 0.32;
      ver_mem_desc_block_height = 0.17;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      mem_desc_block_width = 0.35;
      mem_desc_block_height = 0.18;
      print('1200');
    }

    if (context.width < 1000) {
      mem_desc_block_width = 0.32;
      mem_desc_block_height = 0.19;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      mem_desc_block_width = 0.50;
      mem_desc_block_height = 0.19;
      horizontalViewWidget = verticalViewWidget;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(child: horizontalViewWidget),
      ),
    );
  }

  Container EditAndDeleteButton(BuildContext context) {
    return Container(
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
              onTap: () {
                RemoveMember(widget.member!['id']);
              },
              radius: 15,
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ))),
            ),
          ),

          // SPACING :
          const SizedBox(
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
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Container EditAndDeleteButtonRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: context.height * 0.01, bottom: context.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              onTap: () {
                RemoveMember(widget.member!['id']);
              },
              radius: 15,
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 14,
                      ))),
            ),
          ),

          // SPACING :
          const SizedBox(
            width: 5,
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
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Container ProfileSection() {
    return Container(
      padding: const EdgeInsets.all(12),

      // MEMBER DETAIL SECTION :
      child: Column(
        children: [
          // Profile Image
          ProfileImage(),

          // SPACING:
          const SizedBox(
            height: 15,
          ),

          // POSITION:
          SizedBox(
            width: 200,
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
    );
  }

  Card MemDescription(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15),
          right: Radius.circular(15),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: context.width * mem_desc_block_width,
        height: context.height * mem_desc_block_height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15),
            ),
            border: Border.all(width: 0, color: Colors.grey.shade200)),
        child: Container(
          padding: const EdgeInsets.only(bottom: 2, left: 8, right: 8),
          child: RichText(
            text: TextSpan(
              text: widget.member!['meminfo'],
              style: GoogleFonts.robotoSlab(
                textStyle: TextStyle(),
                color: input_text_color,
                fontSize: mem_desc_text,
                fontWeight: FontWeight.w600,
                height: 1.70,
              ),
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  SingleChildScrollView VerticalMemDescription(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shadowColor: Colors.teal,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: context.width * ver_mem_desc_block_width,
          height: context.height * ver_mem_desc_block_height,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
              border: Border.all(width: 0, color: Colors.grey.shade200)),
          child: Container(
            padding: const EdgeInsets.only(bottom: 2, left: 8, right: 8),
            child: RichText(
              text: TextSpan(
                text: widget.member!['meminfo'],
                style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(),
                  color: input_text_color,
                  fontSize: ver_mem_desc_text,
                  fontWeight: FontWeight.w600,
                  height: 1.70,
                ),
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.member!['member_mail'],
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blue,
                  fontSize: 11))
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
          style: TextStyle(
            color: input_text_color,
            fontSize: 13))
    ])));
  }

  Container MemPosition() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              text: widget.member!['position'],
              style: TextStyle(color: input_text_color, fontSize: 15))
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
