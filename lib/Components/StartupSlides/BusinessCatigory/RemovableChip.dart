import 'package:be_startup/Utils/Colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemovableChip extends StatefulWidget {
  String? catigory = '';
  Function removeFun;

  RemovableChip({Key? key, this.catigory, required this.removeFun})
      : super(key: key);
  @override
  State<RemovableChip> createState() => _RemovableChipState();
}

class _RemovableChipState extends State<RemovableChip> {
  bool is_selected = false;
  double chip_fontSize=16; 

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
    return Container(
        margin: EdgeInsets.all(5),
        key: UniqueKey(),
        child: InputChip(
          onDeleted: () {
            widget.removeFun(widget.catigory);
          },
          deleteIcon: Icon(Icons.cancel_rounded,
                size: chip_fontSize,
                color: Colors.white70),
          // elevation: 1
          autofocus: true,
          padding: EdgeInsets.all(5),
          backgroundColor: chip_activate_background,
          // side: BorderSide(color: Colors.teal.shade50),

          label: Text(
            '${widget.catigory}',
            style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: chip_fontSize,
                color: chip_activate_text_color),
          ),
          selected: is_selected,
        ));
  }
}
