import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberBlock extends StatefulWidget {
  var member;
  MemberBlock({this.member, Key? key}) : super(key: key);

  @override
  State<MemberBlock> createState() => _MemberBlockState();
}

class _MemberBlockState extends State<MemberBlock> {
  double mem_desc_block_width = 0.33;

  double mem_desc_block_height = 0.20;

  double phone_mem_desc_block_width = 0.98;

  double phone_mem_desc_block_height = 0.20;

  double img_spacing = 15;

  double desc_spacing = 0.04;

  double mem_box_width = 200;

  double mem_desc_padd = 20;

  double phone_mem_left_radius = 10;

  double phone_mem_right_radius = 10;

  double mem_left_radius = 20;

  double mem_right_radius = 20;

  double mem_info_cont_padding = 15;

  double mem_info_fontSize = 14;

  double phone_mem_info_fontSize = 12;

  double mem_info_fontHeight = 1.70;

  int mem_info_maxlines = 6;

  double contact_padding = 5.0;

  double phone_contact_padding = 2.0;

  double contact_iconSize = 16;

  double phone_contact_iconSize = 14;

  double contact_mail_fontSize = 11;

  double phone_contact_mail_fontSize = 10;

  double mem_name_bottom_padding = 12;

  double phone_mem_name_bottom_padding = 12;

  double mem_name_fontSize = 15;

  double phone_mem_name_fontSize = 13;

  double mem_pod_fontSize = 12;

  double phone_mem_pod_fontSize = 11;

  double profile_radius = 60;

  double phone_profile_radius = 40;

  double edit_btn_cont_height = 0.20;

  double edit_card_elevation = 10;

  double edit_card_radius = 20;

  double edit_btn_radius = 12;

  double edit_btn_iconSize = 15;

  @override
  Widget build(BuildContext context) {
    mem_desc_block_width = 0.33;

    mem_desc_block_height = 0.20;

    img_spacing = 15;

    desc_spacing = 0.04;

    mem_box_width = 200;

    mem_desc_padd = 20;

    mem_left_radius = 20;

    mem_right_radius = 20;

    mem_info_cont_padding = 15;

    mem_info_fontSize = 14;

    mem_info_fontHeight = 1.70;

    mem_info_maxlines = 6;

    contact_padding = 5.0;

    contact_iconSize = 16;

    contact_mail_fontSize = 11;

    mem_name_bottom_padding = 12;

    mem_name_fontSize = 15;

    mem_pod_fontSize = 12;

    profile_radius = 60;

    edit_btn_cont_height = 0.20;

    edit_card_elevation = 10;

    edit_card_radius = 20;

    edit_btn_radius = 12;

    edit_btn_iconSize = 15;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      mem_desc_block_width = 0.35;

      mem_desc_block_height = 0.20;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.04;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 14;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 16;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 15;

      mem_pod_fontSize = 12;

      profile_radius = 60;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('1500');
    }

    if (context.width < 1200) {
      mem_desc_block_width = 0.40;

      mem_desc_block_height = 0.20;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.04;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 14;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 16;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 15;

      mem_pod_fontSize = 12;

      profile_radius = 60;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('1200');
    }

    if (context.width < 1100) {
      mem_desc_block_width = 0.45;

      mem_desc_block_height = 0.20;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.04;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 14;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 16;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 15;

      mem_pod_fontSize = 12;

      profile_radius = 50;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('1100');
    }

    if (context.width < 900) {
      mem_desc_block_width = 0.52;

      mem_desc_block_height = 0.20;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.04;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 13;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 16;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 15;

      mem_pod_fontSize = 12;

      profile_radius = 50;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('900');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      mem_desc_block_width = 0.55;

      mem_desc_block_height = 0.18;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.03;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 13;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 16;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 14;

      mem_pod_fontSize = 12;

      profile_radius = 45;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      mem_desc_block_width = 0.50;

      mem_desc_block_height = 0.17;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.02;

      mem_box_width = 200;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 15;

      mem_info_fontSize = 12;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 5.0;

      contact_iconSize = 15;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 13;

      mem_pod_fontSize = 12;

      profile_radius = 43;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;
      print('640');
    }

    if (context.width < 600) {
      mem_desc_block_width = 0.53;

      mem_desc_block_height = 0.17;

      mem_desc_padd = 20;

      img_spacing = 15;

      desc_spacing = 0.02;

      mem_box_width = 160;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 12;

      mem_info_fontSize = 12;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 4.0;

      contact_iconSize = 15;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 13;

      mem_pod_fontSize = 12;

      profile_radius = 43;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 14;

      print('600');
    }

    // PHONE:
    if (context.width < 480) {
      mem_desc_block_width = 0.90;

      mem_desc_block_height = 0.17;

      mem_desc_padd = 18;

      img_spacing = 12;

      desc_spacing = 0.02;

      mem_box_width = 160;

      mem_left_radius = 15;

      mem_right_radius = 15;

      mem_info_cont_padding = 12;

      mem_info_fontSize = 12;

      mem_info_fontHeight = 1.70;

      mem_info_maxlines = 20;

      contact_padding = 4.0;

      contact_iconSize = 15;

      contact_mail_fontSize = 11;

      mem_name_bottom_padding = 12;

      mem_name_fontSize = 13;

      mem_pod_fontSize = 12;

      profile_radius = 43;

      edit_btn_cont_height = 0.20;

      edit_card_elevation = 10;

      edit_card_radius = 20;

      edit_btn_radius = 12;

      edit_btn_iconSize = 15;

      print('480');
    }

    Widget mainMemberSection = Row(
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
                height: img_spacing,
              ),

              // POSITION:
              SizedBox(
                width: mem_box_width,
                child: InkWell(
                  child: Column(
                    children: [
                      // MEMBER NAME :
                      MemName(),

                      // POSITION:
                      MemPosition(),
                      // CONTACT EMAIL ADDRESS :
                      MemContact(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // SPACING:
        SizedBox(
          width: context.width * desc_spacing,
        ),

        // MEMBER DESCRIPTION SECTION :
        MemDescription(context),

        // EidtDeleteLButtons(context)
      ],
    );

    Widget phoneMemberSection = Column(
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
                height: img_spacing,
              ),

              // POSITION:
              SizedBox(
                width: mem_box_width,
                child: InkWell(
                  child: Column(
                    children: [
                      // MEMBER NAME :
                      PhoneMemName(),

                      // POSITION:
                      PhoneMemPosition(),
                      // CONTACT EMAIL ADDRESS :
                      MemContact(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // SPACING:
        SizedBox(
          width: context.width * desc_spacing,
        ),

        // MEMBER DESCRIPTION SECTION :
        PhoneMemDescription(context),

        // EidtDeleteLButtons(context)
      ],
    );

    if (context.width < 480) {
      mainMemberSection = phoneMemberSection;
    }



    return Container(
      child: SingleChildScrollView(child: mainMemberSection),
    );
  }




  Card MemDescription(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(mem_left_radius),
          right: Radius.circular(mem_right_radius),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(mem_desc_padd),
        width: context.width * mem_desc_block_width,
        height: context.height * mem_desc_block_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(mem_left_radius),
              right: Radius.circular(mem_right_radius),
            ),
            border: Border.all(width: 0, color: Colors.grey.shade200)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: mem_info_cont_padding),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: widget.member['meminfo'],
                style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(),
                  color: light_color_type3,
                  fontSize: mem_info_fontSize,
                  fontWeight: FontWeight.w600,
                  height: mem_info_fontHeight,
                ),
              ),
              maxLines: mem_info_maxlines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }



  Card PhoneMemDescription(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(phone_mem_left_radius),
          right: Radius.circular(phone_mem_right_radius),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(mem_desc_padd),
        width: context.width * phone_mem_desc_block_width,
        height: context.height * phone_mem_desc_block_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(phone_mem_left_radius),
              right: Radius.circular(phone_mem_right_radius),
            ),
            border: Border.all(width: 0, color: Colors.grey.shade200)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: mem_info_cont_padding),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: widget.member['meminfo'],
                style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(),
                  color: light_color_type3,
                  fontSize: phone_mem_info_fontSize,
                  fontWeight: FontWeight.w600,
                  height: mem_info_fontHeight,
                ),
              ),
              maxLines: mem_info_maxlines,
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
          padding: EdgeInsets.all(contact_padding),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade300,
            size: contact_iconSize,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.member['member_mail'],
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blue,
                  fontSize: contact_mail_fontSize))
        ])),
      ],
    ));
  }

  Container PhoneMemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(phone_contact_padding),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade300,
            size: phone_contact_iconSize,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.member['member_mail'],
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blue,
                  fontSize: phone_contact_mail_fontSize))
        ])),
      ],
    ));
  }

  Container MemName() {
    return Container(
        margin: EdgeInsets.only(bottom: mem_name_bottom_padding),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              text: widget.member['name'],
              style: TextStyle(
                  color: Colors.blueGrey.shade700, fontSize: mem_name_fontSize))
        ])));
  }

  Container MemPosition() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: '@${widget.member['position']}',
          style:
              TextStyle(color: light_color_type2, fontSize: mem_pod_fontSize))
    ])));
  }

  Container ProfileImage() {
    return Container(
        child: CircleAvatar(
      radius: profile_radius,
      backgroundColor: Colors.blueGrey[100],
      foregroundImage: NetworkImage(widget.member['image']),
    ));
  }

  Container PhoneMemName() {
    return Container(
        margin: EdgeInsets.only(bottom: phone_mem_name_bottom_padding),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              text: widget.member['name'],
              style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontSize: phone_mem_name_fontSize))
        ])));
  }

  Container PhoneMemPosition() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: '@${widget.member['position']}',
          style: TextStyle(
              color: light_color_type2, fontSize: phone_mem_pod_fontSize))
    ])));
  }

  Container PhoneProfileImage() {
    return Container(
        child: CircleAvatar(
      radius: profile_radius,
      backgroundColor: Colors.blueGrey[100],
      foregroundImage: NetworkImage(widget.member['image']),
    ));
  }

  Container EidtDeleteLButtons(BuildContext context) {
    return Container(
      height: context.height * edit_btn_cont_height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /////////////////////////////
          // DELETE MEMBER BUTTON :
          /////////////////////////////
          Card(
            shadowColor: Colors.grey,
            elevation: edit_card_elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(edit_card_radius),
            ),
            child: InkWell(
              onTap: () async {},
              radius: 15,
              child: CircleAvatar(
                  radius: edit_btn_radius,
                  backgroundColor: Colors.red.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: edit_btn_iconSize,
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
            elevation: edit_card_elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                // EditMember();
              },
              radius: 15,
              child: CircleAvatar(
                  radius: edit_btn_radius,
                  backgroundColor: Colors.blue.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: edit_btn_iconSize,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
