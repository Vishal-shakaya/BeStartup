import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestorBlock extends StatefulWidget {
  var investor; 

  InvestorBlock({
    required this.investor, 
    Key? key}) : super(key: key);

  @override
  State<InvestorBlock> createState() => _InvestorBlockState();
}

class _InvestorBlockState extends State<InvestorBlock> {
  @override
  Widget build(BuildContext context) {
    double mem_dialog_width = 600;

    // MEMBER DETAIL DIALOG BLOK :
    MemberDetailDialogView() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                  content: SizedBox(
                width: mem_dialog_width,
                child: MemberDetailDialog(investor:widget.investor ),
              )));
    }

    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: context.width * 0.12,
        height: context.height * 0.21,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: 'Tap For More Detail',
              child: InkWell(
                hoverColor: Colors.transparent,
                radius: 20,
                onTap: () {
                  MemberDetailDialogView();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image :
                    ProfileImage(),

                    // Postition:
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          // Spacer
                          const SizedBox(
                            height: 5,
                          ),

                          // Member Name Block :
                          MemName(),

                          // Spacer :
                          const SizedBox(
                            height: 5,
                          ),

                          // Contact and email adderss :
                          MemContact()
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

  //////////////////////////////////////
  /// Member Description :
  //////////////////////////////////////
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
            decoration: const BoxDecoration(
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(widget.investor['image']??temp_logo),
      )),
    );
  }

//////////////////////////////////////
  /// Mem Name  Method :
//////////////////////////////////////
  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children:  [
      TextSpan(
          text: widget.investor['name'] ?? '',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16))
    ])));
  }

  //////////////////////////////////
  // Member Position Method :
  //////////////////////////////////
  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children:  [
      TextSpan(
          text: '@${widget.investor['position']}',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12))
    ])));
  }

/////////////////////////////////////////
  /// Member Contact :
/////////////////////////////////////////
  Container MemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon :
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade800,
            size: 16,
          ),
        ),

        // Tect :
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.investor['email']??'',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}
