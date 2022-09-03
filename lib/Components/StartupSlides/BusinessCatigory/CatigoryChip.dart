import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessCatigoryStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatigoryChip extends StatefulWidget {
  String? catigory = '';
  bool? is_selected;
  CatigoryChip({Key? key, this.catigory, this.is_selected}) : super(key: key);
  @override
  State<CatigoryChip> createState() => _CatigoryChipState();
}

class _CatigoryChipState extends State<CatigoryChip> {
  var catigoryStore = Get.put(BusinessCatigoryStore(), tag: 'catigories');
  late bool is_selected;
  double? chip_fontSize = 16;

  // Add or Remove catigory form backend :
  UpdateStorage(is_selected, snack_width) async {
    var res;
    if (is_selected) {
      res = await catigoryStore.SetCatigory(cat: widget.catigory);
    } else {
      res = await catigoryStore.RemoveCatigory(cat: widget.catigory);
    }
    if (!res['response']) {
      Get.showSnackbar(MyCustSnackbar(width: snack_width));
    }
  }

  @override
  void initState() {
    super.initState();
    is_selected = widget.is_selected!;
  }

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
      chip_fontSize = 16;
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
      chip_fontSize = 16;
    }

    if (context.width < 1200) {
      chip_fontSize = 14;
      print('1200');
    }

    if (context.width < 1000) {
      chip_fontSize = 14;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      chip_fontSize = 12;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      chip_fontSize = 10;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      chip_fontSize = 10;
      print('480');
    }

    // catigory Default State :
    var snack_width = MediaQuery.of(context).size.width * 0.50;
    // select chip color if chip already selected or not :
    is_selected
        ? chip_color = chip_activate_text_color
        : chip_color = chip_text_color;

    return Container(
        margin: const EdgeInsets.all(5),
        key: UniqueKey(),
        child: ChoiceChip(
          
          // elevation: 1,
          selectedColor: chip_activate_background,
          autofocus: true,
          padding: const EdgeInsets.all(5),
          backgroundColor: Colors.grey.shade200,
          // side: BorderSide(color: Colors.teal.shade50),

          label: Text(
            '${widget.catigory}',
            style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: chip_fontSize,
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
            await UpdateStorage(is_selected, snack_width);
          },
        ));
  }
}
