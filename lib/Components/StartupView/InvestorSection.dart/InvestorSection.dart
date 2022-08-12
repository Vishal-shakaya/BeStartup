import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorBlock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
