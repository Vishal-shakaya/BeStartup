import 'package:be_startup/Components/Slides/BusinessProduct/ProductForm.dart';
import 'package:be_startup/Components/Slides/BusinessProduct/ProductImage.dart';
import 'package:flutter/material.dart';

enum LinkType {
  youtube,
  web,
}

class ProductSection extends StatefulWidget {
  Function removeProduct; 
  ProductSection({Key? key , required this.removeProduct}) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
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
      ),
    );
  }
}
