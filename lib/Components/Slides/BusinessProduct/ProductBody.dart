import 'package:be_startup/Components/Slides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/Slides/BusinessProduct/ProductSection.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  double prod_cont_width = 0.80;
  double prod_cont_height = 0.90;

  List<ProductSection> products = [
    ProductSection(
        key: UniqueKey(),
        removeProduct: (key) {
          Get.snackbar(
            'INFO',
            'Default Product Section not Deletable',
            icon: Icon(
              Icons.warning_amber,
              size: 40, 
              ),
              // backgroundColor: Colors.yellow.shade100 ,
              maxWidth: Get.width*0.50,
              );
        })
  ];

  /////////////////////////////////////////
  /// PRODUCT HANDLERS :
  /// 1. ADD :
  /// 2. REMOVE :
  ////////////////////////////////////////
  AddProduct() {
    print('ADD PRODUCT');
    // Add Production Section to List :
    setState(() {
      products
          .add(ProductSection(key: UniqueKey(), removeProduct: RemoveProduct));
    });
  }

  RemoveProduct(key) {
    print('Remove Product');
    setState(() {
      try {
        products.removeWhere((element) {
          return element.key == key;
        });
      } catch (err) {
        print('NOT ABLE TO DELET PRODUCT');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * prod_cont_width,
      height: context.height * prod_cont_height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ADD SECTION BUTTON :
            AddSectionButton(
              key: UniqueKey(),
              addProduct: AddProduct,
            ),

            ////////////////////////////////////
            // PRODUCT SECTION;
            // DARK THEME COLOR ___ :
            // RESPONSIVE NESS _____:
            // 1. IMAGE SECTION :
            // 2. FORM SECTIN:
            ////////////////////////////////////
            SingleChildScrollView(
              child: Column(
                children: products,
              ),
            )
          ],
        ),
      ),
    );
  }
}
