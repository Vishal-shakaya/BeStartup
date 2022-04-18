import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Products.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Services.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditProductAndService() {
      Get.toNamed(create_business_product_url);
    }

    return Column(
      children: [
        EditButton(context, EditProductAndService),
        Container(
          width: context.width * 0.70,
          height: context.height * 0.50,
          margin: EdgeInsets.only(
              bottom: context.height * 0.06, top: context.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Product and Service List :
                Products(),
                Products(),
                Products(),
                Products(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container EditButton(BuildContext context, Null EditProductAndService()) {
    return Container(
          width: context.width * 0.63,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: context.height * 0.02),
          child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: border_color)),
            child: TextButton.icon(
                onPressed: () {
                  EditProductAndService();
                },
                icon: Icon(
                  Icons.edit,
                  size: 15,
                ),
                label: Text('Edit')),
          ));
  }
}
