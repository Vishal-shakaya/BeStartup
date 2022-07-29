import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;

class UpdateInvestmentDialog extends StatelessWidget {
  Function updateInvestmentFun;
  UpdateInvestmentDialog({required this.updateInvestmentFun, Key? key})
      : super(key: key);

  var investAmountController = TextEditingController();
  var detailController = Get.put(BusinessDetailStore());
  var my_context = Get.context;

  SubmitAmount() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final amount = investAmountController.text;
    final startup_id = await getStartupDetailViewId;
    final resp = await detailController.UpdateBusinessDetailDatabaseField(
        field: 'achived_amount', val: amount, startup_id: startup_id);

    if (resp['response']) {
      await updateInvestmentFun(data:amount);
      Navigator.of(my_context!).pop();

      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(
            title: 'Amount Updated',
            message: 'Investment Amount updated Successfully',
            width: snack_width, type: MySnackbarType.success));
    }


    if (!resp['response']) {
      Get.closeAllSnackbars();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [CloseButton(context)],
          ),

          // HEADER TEXT :
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Heading(),
                Subheading(),
              ],
            ),
          ),

          // Amount Input Field :
          AmountInputField(context),

          // Submit Button :
          SubmitFormButton(),
        ],
      ),
    );
  }

///////////////////////////////////////
  /// External Methods :
///////////////////////////////////////
  Container AmountInputField(BuildContext context) {
    return Container(
      width: context.width * 0.15,
      child: TextField(
          controller: investAmountController,
          decoration: InputDecoration(
              hintText: '₹ Enter amount',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))))),
    );
  }

  Container Heading() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: AutoSizeText.rich(
          TextSpan(
            text: 'Update Investment',
            style: TextStyle(fontSize: 18),
          ),
          style: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: light_color_type2,
            fontWeight: FontWeight.w600,
          )),
    );
  }

  Container Subheading() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: AutoSizeText.rich(
        TextSpan(
            text:
                'Ex duis nostrud ea adipisicing eiusmod in aute magna non velit culpa non elit.',
            style: TextStyle(fontSize: 14, color: light_color_type4)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container SubmitFormButton() {
    return Container(
      width: 300,
      height: 42,
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            await SubmitAmount();
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            // side: BorderSide(color: Colors.orange)
          ))),
          child: Text('Done',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ))),
    );
  }

  IconButton CloseButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.close,
          color: Colors.grey,
        ));
  }
}
