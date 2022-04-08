import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessProductStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListView extends StatefulWidget {
  Map<String, dynamic?>? product;
  ProductListView({this.product, Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  double image_cont_width = 0.18;
  double image_cont_height = 0.22;

  double desc_cont_width = 0.40;
  double desc_cont_height = 0.22;

  var productStore = Get.put(BusinessProductStore(), tag: 'productList');
  // REMOVE PRODUCT AND UPDATE UI :
  DeleteProduct(id) async {
    print('DELETING PRODUCT');
    var res = await productStore.RemoveProduct(widget.product!['id']);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.product);
    return Container(
        child: Row(
      children: [
        // Image Section :
        ProductImageSection(context),

        // Product Dectription:
        ProductDescription(context),

        // Delete and Edit Icon :
        DeleteEditButton(context)
      ],
    ));
  }

  Container DeleteEditButton(BuildContext context) {
    return Container(
      height: context.height * desc_cont_height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /////////////////////////////
          // DELETE PRODUCT BUTTON :
          /////////////////////////////
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                DeleteProduct(widget.product!['id']);
              },
              radius: 15,
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ))),
            ),
          ),

          // SPACING :
          SizedBox(
            height: 5,
          ),

          /////////////////////////////
          // EDIT PRODUCT BUTTON:
          /////////////////////////////
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                // SetService();
                // EditProduct();
              },
              radius: 15,
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Container ProductDescription(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20),
        width: context.width * desc_cont_width,
        height: context.height * desc_cont_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 1, color: Colors.grey.shade300)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: RichText(
                    text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: widget.product!['title'],
                    style: GoogleFonts.robotoSlab(
                      textStyle: TextStyle(),
                      color: light_color_type2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ])),
              ),
              Container(
                child: AutoSizeText.rich(
                  // Description:
                  TextSpan(
                    text: widget.product!['description'],
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: light_color_type3,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        wordSpacing: 2,
                        height: 1.6),
                  ),

                  textAlign: TextAlign.left,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  // maxLines:5,
                ),
              ),
            ],
          ),
        ));
  }

  Card ProductImageSection(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(19),
          right: Radius.circular(19),
        ),
      ),
      child: Container(
        width: context.width * image_cont_width,
        height: context.height * image_cont_height,
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(widget.product!['image_url'],
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.contain),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
      ),
    );
  }
}
