import 'package:be_startup/Components/StartupSlides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
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



  @override
  Widget build(BuildContext context) {


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
                // 1. IMAGE SECTION :
                // 2. FORM SECTIN:
                ////////////////////////////////////

              ],
            ),
          ),
        ),
        BusinessSlideNav(slide:SlideType.product)
      ],
    );
  }
}
