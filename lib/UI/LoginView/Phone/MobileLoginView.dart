import 'package:flutter/material.dart';

class MobileLoginView extends StatefulWidget {
  MobileLoginView({Key? key}) : super(key: key);

  @override
  State<MobileLoginView> createState() => _MobileLoginViewState();
}

class _MobileLoginViewState extends State<MobileLoginView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('mobile login View')
    );
  }
}