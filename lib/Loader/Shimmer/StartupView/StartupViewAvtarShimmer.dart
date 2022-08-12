import 'package:flutter/material.dart';
import 'package:get/get.dart';

  Card StartupViewAvtarShimmer() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
      child: Container(
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blueGrey[100],
        ),
      ),
    );
  }