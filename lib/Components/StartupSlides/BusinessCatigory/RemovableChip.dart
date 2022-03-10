import 'package:be_startup/Utils/Colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemovableChip extends StatefulWidget {
  String? catigory = '';
  Function removeFun;

  RemovableChip(
      {Key? key,
      this.catigory, 
      required this.removeFun})
      : super(key: key);
  @override
  State<RemovableChip> createState() => _RemovableChipState();
}

class _RemovableChipState extends State<RemovableChip> {
  bool is_selected = false;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        key: UniqueKey(),
        child: InputChip(
          onDeleted: (){
              widget.removeFun(widget.catigory);
          },
          deleteIcon: Icon(
            Icons.cancel_rounded, 
            size: 16, 
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
                fontSize: 16,
                color: chip_activate_text_color),
          ),
          selected: is_selected,
        ));
  }
}
