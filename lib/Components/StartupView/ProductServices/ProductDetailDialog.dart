

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/HeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailDialog extends StatefulWidget {
  ProductDetailDialog({Key? key}) : super(key: key);

  @override
  State<ProductDetailDialog> createState() => _ProductDetailDialogState();
}

class _ProductDetailDialogState extends State<ProductDetailDialog> {
    // Image width and height :
  double image_cont_width = 0.17;
  double image_cont_height = 0.28;

  // CLOSE DIALOG :
  CloseDialog(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      key: GlobalKey(),
      widthFactor: 0.9,
      heightFactor: 0.60,
      child: Column(
        children: [
           // Header Text : 
            HeaderText(context,'Product  Review'),  
            SizedBox(height: context.height*0.07,), 

           Row(
            children: [
              // PRODUCT IMAGE SECTION : 
              Expanded(
                flex:3,
                child: ImageContainer(context, temp_image)),
                
                SizedBox(width: context.width*0.02,), 
                // PRODUCT DETAIL : 
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: context.height*0.31,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: AutoSizeText.rich(
                              TextSpan(
                                text:'Best TV for online contents', 
                                style: TextStyle(
                                  fontSize: 25,
                                  color: light_color_type2
                                )
                              ),
                                 style: Get.theme.textTheme.headline2 
                              ) ,
                          ),

                          SizedBox(height: context.height*0.02,),
                          // DESCRIPTION
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade200) 
                            ),
                            child: AutoSizeText.rich(
                              TextSpan(
                                text:long_string, 
                                style: TextStyle(
                                  fontSize: 14,
                                  wordSpacing: 2,
                                  height:1.8 )
                              ),
                                 style: Get.theme.textTheme.headline5, 
                              ) ,
                          ),
                        ],
                      ),
                    ),
                  )) 
            ],
          ),
        ],
      ),
    );
  }
    Container ImageContainer(BuildContext context, final_image) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(final_image,
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.contain),
        ));
  }

  
  Row HeaderText(BuildContext context,String title) {
    return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: Get.theme.textTheme.headline2,
                        children: [
                          TextSpan(
                            text:title,
                            style: TextStyle(
                              fontSize: 20, 
                              color:light_color_type3
                            ) )
                        
                          ])),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    CloseDialog(context);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.blueGrey.shade800,
                  ))
              ],
            );
  }
}
