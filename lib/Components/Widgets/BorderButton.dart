import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class PHSocailAuth extends StatelessWidget {
  const PHSocailAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Card(
        shadowColor: Colors.teal[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 3,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.teal[100],
          borderRadius:  BorderRadius.all(Radius.circular(18)),
          child: Container(
            width: 270,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1.9, color: primary_light),
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Text('Sign up',
                style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: light_color_type2)),
          ),
        ),
      ),
    );
  }
}

