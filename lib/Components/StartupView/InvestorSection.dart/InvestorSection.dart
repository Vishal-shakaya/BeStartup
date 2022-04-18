import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorBlock.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';

class InvestorSection extends StatelessWidget {
  const InvestorSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mem_desc_block_width = 0.15;
    double mem_desc_block_height = 0.10;

    return Container(
      color: Colors.orange.shade300,
      margin: EdgeInsets.only(top: context.height * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: context.height * 0.30,
              width: context.width *0.60,
              color: Colors.orange.shade300,

              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                return InvestorBlock();
              })),
        ],
      ),
    );
  }
}
