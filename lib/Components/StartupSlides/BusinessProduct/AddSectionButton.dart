import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSectionButton extends StatefulWidget {
   Function addProduct;
   AddSectionButton({Key? key, required this.addProduct})
      : super(key: key);

  @override
  State<AddSectionButton> createState() => _AddSectionButtonState();
}

class _AddSectionButtonState extends State<AddSectionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(flex: 1, child: Container()),
        Container(
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary_light)),
                onPressed: () {
                  widget.addProduct();
                },
                icon: Icon(Icons.add),
                label: Text('Add')))
      ],
    );
  }
}
