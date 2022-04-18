import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';

class RowMembers extends StatefulWidget {
  RowMembers({Key? key}) : super(key: key);

  @override
  State<RowMembers> createState() => _RowMembersState();
}

class _RowMembersState extends State<RowMembers> {
  @override
  Widget build(BuildContext context) {
    double mem_dialog_width = 600;

    // MEMBER DETIAL BLOCK :
    MemberDetailDialogView() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
              content: SizedBox(
                  width: mem_dialog_width, child: MemberDetailDialog())));
    }

    return // Investor Block :
        Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: context.width * 0.12,
        height: context.height * 0.21,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            // PROFILE IMAGE :
            Tooltip(
              message: 'Tap For More Info',
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  MemberDetailDialogView();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImage(),

                    // POSITION:
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          MemName(),

                          SizedBox(
                            height: 5,
                          ),
                          // CONTACT EMAIL ADDRESS :
                          MemPosition()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card MemDescription(
      BuildContext context, mem_desc_block_width, mem_desc_block_height) {
    return Card(
      shadowColor: Colors.red,
      elevation: 5,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: ' 😎 Managing Director',
                    style: GoogleFonts.robotoSlab(
                      textStyle: TextStyle(),
                      color: light_color_type2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                    ),
                  ),
                ])),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: context.width * 0.15,
            height: context.height * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: long_string,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type3,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                    ),
                  ),
                ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card ProfileImage() {
    return Card(
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(profile_image),
      )),
    );
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: 'vishal shakaya',
          style: TextStyle(color: light_color_type1, fontSize: 15))
    ])));
  }

  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: '@Founder / CEO',
          style: TextStyle(color: light_color_type1, fontSize: 12))
    ])));
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
            color: Colors.orange.shade800,
            size: 16,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: 'shakayavishal007@gmail.com',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}
