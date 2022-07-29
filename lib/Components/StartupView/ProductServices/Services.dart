import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ProductDetailDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_glow/flutter_glow.dart';
class Services extends StatelessWidget {
  var service; 
  Services({
    this.service, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double image_cont_width = 0.20;
    double image_cont_height = 0.27;

    double desc_cont_width = 0.41;
    double desc_cont_height = 0.26;

    double mem_dialog_width = 0.60;

    // PRODUT DEATIL DIALOG :
    ServiceDetailView() {
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
                // DESCRIPTION :
                ProductDescription(context, desc_cont_width, desc_cont_height),
                // PRODUCT iMAGE :
                InkWell(
                    onTap: () {
                      ServiceDetailView();
                    },
                    child: ProductImage(
                        context, image_cont_width, image_cont_height)),
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
        margin: EdgeInsets.only(right: context.width * 0.05),
        width: context.width * desc_cont_width,
        height: context.height * desc_cont_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 1, color: Colors.grey.shade300)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: RichText(
                  text: TextSpan(children: [
                // Heading Texct :
                TextSpan(
                  text: service['title'],
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(),
                    color: light_color_type2,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
              ]),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Description:
            Container(
              child: AutoSizeText.rich(
                TextSpan(
                  text: service['description'],
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type3,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 2,
                      height: 1.8),
                ),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),

            // IMPORTANT Links : 
            Container(
              width:context.width*0.35, 
              height: 50,
              child: 
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Tooltip(
                    message: 'play video',
                     child: IconButton(
                      onPressed: () {}, 
                      icon: GlowIcon(
                        Icons.play_circle_fill,
                        blurRadius: 12,
                        color:Colors.red.shade300,
                        size:25 )),
                   ),
                 ), 

                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Tooltip(
                    message: 'content detail',
                     child: IconButton(
                      onPressed: () {}, 
                      icon: GlowIcon(
                        Icons.link_rounded,
                        blurRadius: 8,
                        color: Colors.blue.shade300, 
                        size: 25,
                        
                        )),
                   ),
                 ) 
              ],)
            )
          ],
        ));
  }

  Card ProductImage(
      BuildContext context, double image_cont_width, double image_cont_height) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15),
          right: Radius.circular(15),
        ),
      ),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
          child: Image.network(service['image_url'],
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.fill),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15),
            ),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
      ),
    );
  }
}
