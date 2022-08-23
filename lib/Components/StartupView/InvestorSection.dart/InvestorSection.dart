import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/CreateInvestorDialog.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorBlock.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestorSection extends StatelessWidget {
  const InvestorSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mem_desc_block_width = 0.15;
    double mem_desc_block_height = 0.10;
    double mem_dialog_width = 600;

    // MEMBER DETAIL DIALOG BLOK :
    MemberDetailDialogView({form_type})async  {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                  content: SizedBox(
                width: mem_dialog_width,
                child: InvestorDialog(form_type: form_type,),
              )));
    }

    return Column(
      children: [
        // INVESTOR HEADING:
        Container(
          child: Wrap(
            children: [
              StartupHeaderText(
                title: 'Investors',
                font_size: 32,
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: context.height * 0.06,
                    left: context.width * 0.02,
                  ),
                  child: Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: border_color)),
                    child: TextButton.icon(
                        onPressed: () async  {
                        await MemberDetailDialogView(form_type: InvestorFormType.create);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 16,
                        ),
                        label: const Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                  ))
            ],
          ),
        ),

        Container(
          color: Colors.orange.shade300,
          margin: EdgeInsets.only(top: context.height * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: context.height * 0.30,
                  width: context.width * 0.60,
                  color: Colors.orange.shade300,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InvestorBlock();
                      })),
            ],
          ),
        ),
      ],
    );
  }
}
