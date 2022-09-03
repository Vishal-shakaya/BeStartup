import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeSection extends StatefulWidget {
  NoticeSection({Key? key}) : super(key: key);

  @override
  State<NoticeSection> createState() => _NoticeSectionState();
}

class _NoticeSectionState extends State<NoticeSection> {
  // double image_hint_text_size = 22
  double notice_cont_width = 0.20;
  double notice_block_padding = 20;
  bool is_notice_visible = true;

  double? notice_input_text_size = 14;

  @override
  Widget build(BuildContext context) {

    notice_input_text_size = 14;
    ////////////////////////////////////
    /// RESPONSIVE BREAK POINTS :
    /// //////////////////////////////

    // PC:
    if (context.width > 1200) {
      notice_cont_width = 0.19;
    }

    // SMALL PC 1000
    if (context.width < 1200) {
      notice_cont_width = 0.24;
    }


    // TABLET :
    if (context.width < 800) {
      notice_input_text_size = 14;
      notice_cont_width = 0.45;
    }
    
    // SMALL TABLET:
    if (context.width < 640) {
      notice_input_text_size = 13;
      notice_cont_width = 0.59;
    }

    // PHONE:
    if (context.width < 480) {
      notice_input_text_size = 12;
      notice_cont_width = 0.59;
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          NoticeHeading(),
          //////////////////////////////////
          // NOTICE HEADER SECTION
          // 1. TOOGLE NOTICE SECTION:
          //////////////////////////////////
          // SPACER :
          SizedBox(
            height: context.height * 0.02,
          ),
          ///////////////////////////////////////
          // NOTICE SECTION :
          // SHOW IMPORTANT  NOTICE SECTION :
          ///////////////////////////////////////
          NoticeContainer(context),
        ],
      ),
    );
  }

  //////////////////////////////////
  // NOTICE HEADER SECTION
  // 1. TOOGLE NOTICE SECTION:
  //////////////////////////////////
  Wrap NoticeHeading() {
    return Wrap(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              is_notice_visible = !is_notice_visible;
              is_notice_visible
                  ? notice_block_padding = 20
                  : notice_block_padding = 0;
            });
          },
          child: AutoSizeText('Why thumbnail Important!',
              style: Get.textTheme.headline2),
        ),
        Icon(Icons.arrow_downward_rounded)
      ],
    );
  }

  ///////////////////////////////////////
  // NOTICE SECTION :
  // SHOW IMPORTANT  NOTICE SECTION :
  ///////////////////////////////////////
  Container NoticeContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(notice_block_padding),
      decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(10), right: Radius.circular(10))),
      child: Visibility(
          visible: is_notice_visible,
          child: Container(
              width: context.width * notice_cont_width,
              child: AutoSizeText.rich(
                    TextSpan(
                      text: thumbnail_important_text,
                      style: TextStyle(
                        fontSize: notice_input_text_size,
                        wordSpacing: 5, color: Colors.black
                          
                        )),

                      textAlign: TextAlign.center, 
                  ))),
    );
  }
}
