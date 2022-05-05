import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductForm.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductImageSection.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/SelectProductType.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListView extends StatefulWidget {
  Map<String, dynamic?>? product;
  int? index; 
  ProductListView({
    this.index,
    this.product, Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  double image_cont_width = 0.18;
  double image_cont_height = 0.22;

  double desc_cont_width = 0.40;
  double desc_cont_height = 0.22;

  var productStore = Get.put(BusinessProductStore(), tag: 'productList');

  Row ProductDialogHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // HEADING SECTION:
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.topCenter,
                child: Text('Add Title', style: Get.textTheme.headline2))),

        // CLOSE DIALOG ICON :
        // POP THE DIALOG BOX:
        TextButton(
          onPressed: () {
            CloseDialog();
          },
          child: Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  EditProduct() async {
    // Set Links
    await productStore.SetYoutubeLink(widget.product!['youtube_link']);
    await productStore.SetContentLink(widget.product!['content_link']);
    // Set Image
    await productStore.SetImageUrl(widget.product!['image_url']);
    // Set product type:
    if (widget.product!['type'] == 'product') {
      await productStore.SetProductType(ProductType.product);
    }
    if (widget.product!['type'] == 'service') {
      await productStore.SetProductType(ProductType.service);
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: ProductDialogHeading(),
            content: SizedBox(
              width: context.width * 0.60,
              height: context.height * 0.50,

              // PRODUCT CONTAINER :
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      /////////////////////////////////
                      // Image Section :
                      /////////////////////////////////
                      ProductImageSection(
                        product_image_url: widget.product!['image_url'],
                        form_type : 'update'
                      ),

                      //////////////////////////////
                      // Content Section :
                      // 1. Title :
                      // 2. Description :
                      //////////////////////////////
                      ProductForm(
                          title: widget.product!['title'],
                          product_index: widget.index,
                          description: widget.product!['description'],
                          id: widget.product!['id'],
                          form_type: 'update'),

                      SelectProductType(product_type: widget.product!['type']),
                    ],
                  )),
            )));
  }

  // REMOVE PRODUCT AND UPDATE UI :
  DeleteProduct(id) async {
    // print('DELETING PRODUCT');
    var res = await productStore.RemoveProduct(widget.product!['id']);
  }

  CloseDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.product);
    return Container(
      margin: EdgeInsets.all(20),
        child: Row(
      children: [
        // Image Section :
        ProductImage(context),

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
                EditProduct();
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        wordSpacing: 2,
                        height: 1.6),
                  ),

                  textAlign: TextAlign.left,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  // maxLines:5,
                ),
              ),
            ],
          ),
        ));
  }

  Card ProductImage(BuildContext context) {
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
