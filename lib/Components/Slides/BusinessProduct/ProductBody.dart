import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
double prod_cont_width = 0.60;
double prod_cont_height = 0.90;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width * prod_cont_width,
        height: context.height * prod_cont_height,
        child: Column(
          children: [
            
          ],
        ),
    );
  }
}