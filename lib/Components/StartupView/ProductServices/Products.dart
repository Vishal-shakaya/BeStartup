import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import './ProductDetailDialog.dart';

class Products extends StatefulWidget {
  const Products({
    Key? key,
  }) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  double image_cont_width = 0.18;
  double image_cont_height = 0.20;

  double desc_cont_width = 0.40;
  double desc_cont_height = 0.20;
  double mem_dialog_width = 0.60;

  @override
  Widget build(BuildContext context) {
    // PRODUT DEATIL DIALOG :
    ProductDetailView() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
              content: SizedBox(
                  width: context.width * mem_dialog_width,
                  child: ProductDetailDialog())));
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                // PRODUCT iMAGE :
                InkWell(
                    onTap: () {
                      ProductDetailView();
                    },
                    child: ProductImage(
                        context, image_cont_width, image_cont_height)),
                // DESCRIPTION :
                ProductDescription(context, desc_cont_width, desc_cont_height)
              ],
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  Container ProductDescription(
      BuildContext context, double desc_cont_width, double desc_cont_height) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: context.width * 0.05),
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
                    text: 'sample product with heading',
                    style: GoogleFonts.robotoSlab(
                      textStyle: TextStyle(),
                      color: light_color_type2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ])),
              ),

              // Description:
              Container(
                child: AutoSizeText.rich(
                  TextSpan(
                    text: long_string,
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
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ));
  }

  Card ProductImage(
      BuildContext context, double image_cont_width, double image_cont_height) {
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
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(temp_image,
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
