import 'package:be_startup/Utils/Colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatigoryChip extends StatefulWidget {
  String? catigory = '';
  CatigoryChip(
      {Key? key,
      this.catigory,})
      : super(key: key);
  @override
  State<CatigoryChip> createState() => _CatigoryChipState();
}

class _CatigoryChipState extends State<CatigoryChip> {
  bool is_selected = false;



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
          onSelected: (chipState) {
            setState(() {
              is_selected = !is_selected;
              is_selected
                  ? chip_color = chip_activate_text_color
                  : chip_color = chip_text_color;
            });
          },
        ));
  }
}
