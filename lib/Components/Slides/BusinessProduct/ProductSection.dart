import 'package:be_startup/Components/Slides/BusinessProduct/ProductForm.dart';
import 'package:be_startup/Components/Slides/BusinessProduct/ProductImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LinkType {
  youtube,
  web,
}

class ProductSection extends StatefulWidget {
  Function removeProduct;
  ProductSection({Key? key, required this.removeProduct}) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  Widget build(BuildContext context) {
    var default_row;
    var first_row;

    default_row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /////////////////////////////////////
        // IMAGE SECTION :
        // ROW VIEW FOR IMAGE PREVIEW :
        // SHOW UPLOAD BUTTON FOR UPLOAD IMAGE :
        /////////////////////////////////////
        Expanded(
          flex: 1,
          child: ProductImage(
            context: context,
            key: UniqueKey(),
          ),
        ),

        ////////////////////////////////////////////////
        // PRODUCT TITLE AND DESCRIPTION SECTION :
        // 1 HEADING :
        // 2 DESCRIPTION :
        ////////////////////////////////////////////////

        Expanded(
          flex: 3,
          child: ProductForm(
            context: context,
            removeProduct: widget.removeProduct,
            key: UniqueKey(),
            product_key: widget.key,
          ),
        ),
      ],
    );

    // RESPONSIVE FOR WIDTH 1000 :
    first_row = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /////////////////////////////////////
          // IMAGE SECTION :
          // ROW VIEW FOR IMAGE PREVIEW :
          // SHOW UPLOAD BUTTON FOR UPLOAD IMAGE :
          /////////////////////////////////////
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ProductImage(
                  context: context,
                  key: UniqueKey(),
                ),
              ),
            ],
          ),
    
    
          SizedBox(height: context.height*0.03,),
          ////////////////////////////////////////////////
          // PRODUCT TITLE AND DESCRIPTION SECTION :
          // 1 HEADING :
          // 2 DESCRIPTION :
          ////////////////////////////////////////////////
    
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ProductForm(
                  context: context,
                  removeProduct: widget.removeProduct,
                  key: UniqueKey(),
                  product_key: widget.key,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.all(5),
      child: context.width<1000
      ? first_row
      : default_row
    );
  }
}
