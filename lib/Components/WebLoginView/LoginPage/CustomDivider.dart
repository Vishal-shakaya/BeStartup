import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 50),
      width: 20,
      child: Column(children: [
        Text('or'),
        SizedBox(
            height: 25,
            child: VerticalDivider(
              color: Colors.blue[400],
              thickness: 3,
              indent: 5,
              endIndent: 0,
              width: 20,
            ))
      ]),
    );
  }
}
