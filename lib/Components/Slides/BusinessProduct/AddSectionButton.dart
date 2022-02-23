import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSectionButton extends StatelessWidget {
  const AddSectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: Container()),
            Container(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(primary_light)),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Add')))
        ],
        );
  }
}