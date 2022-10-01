import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEditButton extends StatelessWidget {
  var func;
  var text;

  MyEditButton({
    required this.func, 
    required this.text, Key? key}) : super(key: key);

  double edit_btn_width = 0.63;

  double edit_btn_cont_width = 90;

  double edit_btn_cont_height = 30;

  double edit_btn_top_margin = 0.2;

  double edit_btn_radius = 15;

  double edit_btn_iconSize = 15;

  double edit_btn_fontSize = 15;


  @override
  Widget build(BuildContext context) {
    edit_btn_width = 0.63;

    edit_btn_cont_width = 90;

    edit_btn_cont_height = 30;

    edit_btn_top_margin = 0.2;

    edit_btn_radius = 15;

    edit_btn_iconSize = 15;

    edit_btn_fontSize = 15;

    // DEFAULT :
    if (context.width > 1700) {
      
      edit_btn_width = 0.63;

      edit_btn_cont_width = 90;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 15;

      edit_btn_fontSize = 15;
      print('Greator then 1700');
    }

    if (context.width < 1700) {

      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      edit_btn_fontSize = 14;
      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {

      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      edit_btn_fontSize = 14;
      print('1500');
    }

    if (context.width < 1300) {
  
      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      edit_btn_fontSize = 14;
      print('1300');
    }

    if (context.width < 1200) {

      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      print('1200');
    }

    if (context.width < 1000) {

      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      edit_btn_fontSize = 14;

      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      edit_btn_width = 0.90;

      edit_btn_cont_width = 70;

      edit_btn_cont_height = 25;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 12;

      edit_btn_fontSize = 12;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }


    return Container(
        width: context.width * edit_btn_width,
        alignment: Alignment.topRight,
        
        child: Container(
          width: edit_btn_cont_width,
          height: edit_btn_cont_height,
        
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(edit_btn_radius),
              border: Border.all(color: border_color)),
        
          child: TextButton.icon(
              onPressed: () {
                func();
              },
             
              icon: Icon(
                Icons.edit,
                size: edit_btn_iconSize,
                color: edit_btn_color,
              ),
             
              label: Text(
                '$text',
                style: TextStyle(
                    color: edit_btn_color, fontSize: edit_btn_fontSize),
              )),
        ));
  }
}
