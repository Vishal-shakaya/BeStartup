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
            maxWidth: Get.width * 0.50,
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
    // DEFAULT CONFIG:
    if (context.width > 1500) {
      prod_cont_width = 0.80;
      prod_cont_height = 0.90;
    }

    if (context.width < 1500) {
      print('width 1500');
    }

    // PC:
    if (context.width < 1200) {
      prod_cont_width = 0.95;
      prod_cont_height = 0.90;
      print('width 1200');
    }

    if (context.width < 1000) {
      print('width 1000');

    }

    // TABLET :
    if (context.width < 800) {
      print('width 800');

    }
    // SMALL TABLET:
    if (context.width < 640) {
      print('width 640');

    }

    // PHONE:
    if (context.width < 480) {
      print('width 480');

    }

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
