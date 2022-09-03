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
  ProductListView({this.index, this.product, Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  double image_cont_width = 0.18;
  double image_cont_height = 0.22;

  double desc_cont_width = 0.40;
  double desc_cont_height = 0.22;

  double prod_desc_fontSize = 14;
  double prod_title_fontSize = 20;

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
          child: const Icon(
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
                          form_type: 'update'),

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

  ///////////////////////////////////////////////
  /// MAIN WIDGET :
  ///////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1500) {
      image_cont_width = 0.18;
      image_cont_height = 0.22;

      desc_cont_width = 0.40;
      desc_cont_height = 0.22;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      image_cont_width = 0.18;
      image_cont_height = 0.22;

      desc_cont_width = 0.40;
      desc_cont_height = 0.22;
      print('1500');
    }
    if (context.width < 1460) {
      print('1450');
    }

    if (context.width < 1400) {
      print(' 1400');
    }

    if (context.width < 1300) {
      image_cont_width = 0.24;
      image_cont_height = 0.24;

      desc_cont_width = 0.42;
      desc_cont_height = 0.24;
      print(' 1300');
      // Increase image size widht & height:
      // Increase text container width :
    }

    if (context.width < 1200) {
      image_cont_width = 0.27;
      image_cont_height = 0.26;

      desc_cont_width = 0.42;
      desc_cont_height = 0.26;
      print('1200');
    }

    if (context.width < 1100) {
      image_cont_width = 0.28;
      image_cont_height = 0.26;

      desc_cont_width = 0.40;
      desc_cont_height = 0.26;
      print('1100');
    }

    // Seprate Image section and Description :
    if (context.width < 1000) {
      image_cont_width = 0.50;
      image_cont_height = 0.26;

      desc_cont_width = 0.50;
      desc_cont_height = 0.26;
      print('1000ddd');
    }

    // TABLET :
    if (context.width < 800) {
      prod_desc_fontSize = 13;
      prod_title_fontSize = 18; 

      image_cont_width = 0.55;
      image_cont_height = 0.26;

      desc_cont_width = 0.55;
      desc_cont_height = 0.26;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
       prod_desc_fontSize = 13;
      prod_title_fontSize = 16; 

      image_cont_width = 0.60;
      image_cont_height = 0.26;

      desc_cont_width = 0.60;
      desc_cont_height = 0.26;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      prod_desc_fontSize = 12;
      prod_title_fontSize = 15; 

      image_cont_width = 0.62;
      image_cont_height = 0.26;

      desc_cont_width = 0.62;
      desc_cont_height = 0.26;
      print('480');
    }

    ///////////////////////////////////////
    /// Important Variable :
    ///////////////////////////////////////

    Widget responsiveWidget;

    Widget horizontalProduct = Wrap(
      children: [
        // Image Section :
        ProductImage(context),

        SizedBox(width: context.width*0.02,), 

        // Product Dectription:
        ProductDescription(context),

        // Delete and Edit Icon :
        DeleteEditButton(context)
      ],
    );

    Widget verticalProduct = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image Section :
        ProductImage(context),

        SizedBox(
          height: context.height * 0.01,
        ),

        HorizontalDeleteEditButton(context),
        // Product Dectription:
        ProductDescription(context),
      ],
    );

    responsiveWidget = horizontalProduct;

    if (context.width < 1000) {
      responsiveWidget = verticalProduct;
    }

    return Container(margin: EdgeInsets.all(20), child: responsiveWidget);
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
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ))),
            ),
          ),

          // SPACING :
          const SizedBox(
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
                EditProduct();
              },
              radius: 15,
              child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue.shade300,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: const Icon(
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

  Container HorizontalDeleteEditButton(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /////////////////////////////
          // DELETE PRODUCT BUTTON :
          /////////////////////////////
          Container(
            width: 30,
            height: 30,
            child: Card(
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  DeleteProduct(widget.product!['id']);
                },
                radius: 13,
                child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red.shade300,
                    child: Container(
                        padding: EdgeInsets.all(2),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 13,
                        ))),
              ),
            ),
          ),

          // SPACING :
          const SizedBox(
            width: 5,
          ),

          /////////////////////////////
          // EDIT PRODUCT BUTTON:
          /////////////////////////////
          Container(
            width: 30,
            height: 30,
            child: Card(
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  EditProduct();
                },
                radius: 13,
                child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.blue.shade300,
                    child: Container(
                        padding: EdgeInsets.all(2),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 13,
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ProductDescription(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.only(left: 20),
        width: context.width * desc_cont_width,
        height: context.height * desc_cont_height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
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
                      color: product_title_color,
                      fontSize: prod_title_fontSize,
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
                        color: product_description_color,
                        fontSize: prod_desc_fontSize,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(19),
          right: Radius.circular(19),
        ),
      ),
      child: Container(
        width: context.width * image_cont_width,
        height: context.height * image_cont_height,
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(widget.product!['image_url'],
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.cover),
        ),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
      ),
    );
  }
}
