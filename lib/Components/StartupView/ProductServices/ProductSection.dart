import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Products.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({Key? key}) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  var detailViewState = Get.put(StartupDetailViewState());
    var startupConnect =
        Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');
  var products = [];
  var is_admin;
  var startup_id;
  var founder_id;

  double product_cont_width = 0.75;

  double product_cont_height = 0.60;

  double product_top_margin = 0.02;

  double product_bottom_margin = 0.06;

  double edit_btn_width = 0.63;

  double edit_btn_cont_width = 90;

  double edit_btn_cont_height = 30;

  double edit_btn_top_margin = 0.2; 

  double edit_btn_radius = 15; 

  double edit_btn_iconSize = 15; 

  double edit_btn_fontSize = 15; 


  Map<String, dynamic?> temp_product = {
    'id': 'some_randodnjflks',
    'title': 'word famous watter battle  cleane',
    'description': long_string,
    'type': 'product',
    'image_url': temp_image,
    'timestamp': DateTime.now().toString(),
    'youtube_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'content_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'belong_to': '',
    'catigory': '',
  };

  EditProductAndService() {
    var pageParam = jsonEncode({
      'type': 'update',
      'startup_id': startup_id,
      'is_admin': is_admin,
      'founder_id': founder_id
    });

    Get.toNamed(create_business_product_url, parameters: {'data': pageParam});
  }

  @override
  Widget build(BuildContext context) {
     product_cont_width = 0.75;

     product_cont_height = 0.60;

     product_top_margin = 0.02;

     product_bottom_margin = 0.06;

     edit_btn_width = 0.63;

     edit_btn_cont_width = 90;

     edit_btn_cont_height = 30;

     edit_btn_top_margin = 0.2; 

     edit_btn_radius = 15; 

     edit_btn_iconSize = 15; 

     edit_btn_fontSize = 15; 


		// DEFAULT :
    if (context.width > 1700) {
        product_cont_width = 0.75;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.63;

        edit_btn_cont_width = 90;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 15; 

        edit_btn_fontSize = 15; 
        print('Greator then 1700');
      }
  
    if (context.width < 1700) {
        product_cont_width = 0.75;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.70;

        edit_btn_cont_width = 80;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 14; 

        edit_btn_fontSize = 14; 
        print('1700');
      }
  
    if (context.width < 1600) {
        print('1500');
      }

    // PC:
    if (context.width < 1500) {
        product_cont_width = 0.80;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.70;

        edit_btn_cont_width = 80;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 14; 

        edit_btn_fontSize = 14; 
      print('1500');
      }

    if (context.width < 1300) {
        product_cont_width = 0.80;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.70;

        edit_btn_cont_width = 80;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 14; 

        edit_btn_fontSize = 14; 
      print('1300');
      }

    if (context.width < 1200) {
        product_cont_width = 0.85;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.70;

        edit_btn_cont_width = 80;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 14; 

        edit_btn_fontSize = 14; 
        print('1200');
      }
    
    if (context.width < 1000) {
        product_cont_width = 0.95;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.70;

        edit_btn_cont_width = 80;

        edit_btn_cont_height = 30;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 14; 

        edit_btn_fontSize = 14; 
        print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        product_cont_width = 1;

        product_cont_height = 0.60;

        product_top_margin = 0.02;

        product_bottom_margin = 0.06;

        edit_btn_width = 0.90;

        edit_btn_cont_width = 70;

        edit_btn_cont_height = 25;

        edit_btn_top_margin = 0.2; 

        edit_btn_radius = 15; 

        edit_btn_iconSize = 12; 

        edit_btn_fontSize = 12; 
        print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
      print('480');
      }


    ////////////////////////////////////////////
    ///  GET REQUIREMENTS :
    ////////////////////////////////////////////
    GetLocalStorageData() async {
      startup_id = await detailViewState.GetStartupId();
      is_admin = await detailViewState.GetIsUserAdmin();
      founder_id = await detailViewState.GetFounderId();

      try {
        final data = await startupConnect.FetchProducts(startup_id: startup_id);
        print('Detail View Fetch Product $data');
        products = data['data'];
        return products;
      } catch (e) {
        return products;
      }
    }

    ////////////////////////////////////////
    ///  SET REQUIREMENTS :
    ////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProductShimmer();
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethodSection(context);
          }
          return MainMethodSection(context);
        });
  }

////////////////////////////////////////
  /// Main Method :
////////////////////////////////////////
  Column MainMethodSection(BuildContext contex) {
    return Column(
    
      children: [
        is_admin == true
            ? EditButton(context, EditProductAndService)
            : Container(),
        
        Container(
            width: context.width * product_cont_width,
            height: context.height * product_cont_height,
            
            margin: EdgeInsets.only(
                bottom: context.height * product_bottom_margin,
                top: context.height * product_top_margin),
            
            
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                
                itemBuilder: (context, index) {
                  return Products(
                    product: products[index],
                    key: UniqueKey(),
                  );
                })),
      ],
    );
  }



  Container EditButton(BuildContext context, EditProductAndService) {
    return Container(
        width: context.width * edit_btn_width,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: context.height * edit_btn_top_margin),
        child: Container(
          width: edit_btn_cont_width,
          height: edit_btn_cont_height,
          
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(edit_btn_radius),
              border: Border.all(color: border_color)),
          
          child: TextButton.icon(
              onPressed: () {
                EditProductAndService();
              },
              icon:  Icon(
                Icons.edit,
                size: edit_btn_iconSize,
              ),
              label: Text(
                'Edit',
                style: TextStyle(
                  fontSize: edit_btn_fontSize), )),
        ));
  }

  Center ProductShimmer() {
    return Center(
        child: Shimmer.fromColors(
      baseColor: shimmer_base_color,
      highlightColor: shimmer_highlight_color,
      child: Products(
        product: temp_product,
      ),
    ));
  }
}
