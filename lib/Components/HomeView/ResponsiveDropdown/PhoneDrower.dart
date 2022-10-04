import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PhoneDrawer extends StatefulWidget {
  const PhoneDrawer({Key? key}) : super(key: key);

  @override
  State<PhoneDrawer> createState() => _PhoneDrawerState();
}

class _PhoneDrawerState extends State<PhoneDrawer> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      
      child: Icon(Icons.menu),

      drawer: Container(
        width: 50,
        height: 50,
        child: Column(children: [
        ListTile(title: Text('Hello'),), 
        ListTile(title: Text('Hello'),), 
        ListTile(title: Text('Hello'),), 
        ListTile(title: Text('Hello'),), 
      ],
      
      ),),
    );
  }
}
