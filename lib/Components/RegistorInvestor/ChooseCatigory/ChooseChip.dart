import 'package:be_startup/Backend/Investor/InvestorCatigoryStorage.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessCatigoryStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseChip extends StatefulWidget {
  String? catigory = '';
  ChooseChip({
    Key? key,
    this.catigory,
  }) : super(key: key);
  @override
  State<ChooseChip> createState() => _ChooseChipState();
}

class _ChooseChipState extends State<ChooseChip> {
  bool is_selected = false;
  var catigoryStore = Get.put(InvestorCatigoryStore(), tag: 'catigories');

  // Add or Remove catigory form backend :
  UpdateStorage(is_selected) async {
    var res;
    if (is_selected) {
      res = await catigoryStore.SetCatigory(cat: widget.catigory);
    } else {
      res = await catigoryStore.RemoveCatigory(cat: widget.catigory);
    }
    if (!res['response']) {
      // CLOSE SNAKBAR :
      Get.closeAllSnackbars();
      // Error Alert :
      Get.snackbar(
        '',
        '',
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Error accure'),
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: context.width * 0.50,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        key: UniqueKey(),
        child: ChoiceChip(
          // elevation: 1,
          selectedColor: chip_activate_background,
          autofocus: true,
          padding: EdgeInsets.all(5),
          backgroundColor: Colors.grey.shade200,
          // side: BorderSide(color: Colors.teal.shade50),

          label: Text(
            '${widget.catigory}',
            style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: chip_color),
          ),
          selected: is_selected,
          onSelected: (chipState) async {
            is_selected = !is_selected;
            setState(() {
              is_selected
                  ? chip_color = chip_activate_text_color
                  : chip_color = chip_text_color;
            });

            // UPLDATE BACKEND :
            // 1 REMOVE OR ADD CATIGORY :
            await UpdateStorage(is_selected);
          },
        ));
  }
}
