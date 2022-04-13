import 'package:be_startup/Components/StartupSlides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductList.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  double prod_cont_width = 0.80;
  double prod_cont_height = 0.70;

  double prod_sec_width = 0.65;

  var productStore = Get.put(BusinessProductStore(), tag: 'productList');

  @override
  Widget build(BuildContext context) {
    var product = productStore.GetProductList();
    Obx(() {
      print('update length ${product.length}');
      return Text('');
    });
    return Column(
      children: [
        Container(
          width: context.width * prod_cont_width,
          height: context.height * prod_cont_height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ADD SECTION BUTTON :
                AddSectionButton(
                  key: UniqueKey(),
                ),

                ////////////////////////////////////
                // PRODUCT SECTION;
                // DARK THEME COLOR ___ :
                // RESPONSIVE NESS _____:
                ////////////////////////////////////

                // PRODUCT LIST VIEW :

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: context.width * prod_sec_width,
                          height: context.height * 0.60,
                          child: Obx(() {
                            return ListView.builder(
                                itemCount: product.length,
                                key: UniqueKey(),
                                itemBuilder: (context, index) {
                                  return ProductListView(
                                      key: UniqueKey(),
                                      product: product[index],
                                      index: index,
                                      );
                                });
                          })),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        BusinessSlideNav(slide: SlideType.product)
      ],
    );
  }
}
