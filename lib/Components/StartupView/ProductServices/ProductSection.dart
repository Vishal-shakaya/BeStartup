import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Products.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/Widgets/EditButton.dart';
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
  var user_id;

  double product_cont_width = 0.75;

  double product_cont_height = 0.50;

  double product_top_margin = 0.02;

  double product_bottom_margin = 0.06;

  double heading_fontSize = 32;

  double product_bottom_space = 0.04;

  double product_top_space = 0.12;

  var product_len = 0;

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
      'is_admin': is_admin,
      'user_id': user_id
    });

    Get.toNamed(create_business_product_url, parameters: {'data': pageParam});
  }

  @override
  Widget build(BuildContext context) {
    product_cont_width = 0.75;

    product_cont_height = 0.50;

    product_top_margin = 0.02;

    product_bottom_margin = 0.06;

    heading_fontSize = 32;

    product_bottom_space = 0.04;

    product_top_space = 0.12;

    // DEFAULT :
    if (context.width > 1700) {
      product_cont_width = 0.75;

      product_cont_height = 0.50;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;

      heading_fontSize = 32;

      product_bottom_space = 0.04;

      product_top_space = 0.12;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      product_cont_width = 0.75;

      product_cont_height = 0.50;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;

      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
      product_cont_width = 0.80;

      product_cont_height = 0.50;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;

      product_top_space = 0.10;

      product_bottom_space = 0.04;
      print('1500');
    }

    if (context.width < 1300) {
      product_cont_width = 0.80;

      product_cont_height = 0.60;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;

      heading_fontSize = 30;

      product_top_space = 0.09;

      product_bottom_space = 0.03;
      print('1300');
    }

    if (context.width < 1200) {
      product_cont_width = 0.85;

      product_cont_height = 0.60;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;
      heading_fontSize = 30;
      print('1200');
    }

    if (context.width < 1000) {
      product_cont_width = 0.95;

      product_cont_height = 0.60;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      product_cont_width = 1;

      product_cont_height = 0.60;

      product_top_margin = 0.02;

      product_bottom_margin = 0.06;

      product_top_space = 0.03;

      product_bottom_space = 0.03;
      heading_fontSize = 28;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      product_top_space = 0.03;

      product_bottom_space = 0.03;
      heading_fontSize = 28;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      product_top_space = 0.03;

      product_bottom_space = 0.03;
      heading_fontSize = 25;

      print('480');
    }

    ////////////////////////////////////////////
    ///  GET REQUIREMENTS :
    ////////////////////////////////////////////
    GetLocalStorageData() async {
      final pageParam = jsonDecode(Get.parameters['data']!);
      user_id = pageParam['user_id'];
      is_admin = pageParam['is_admin'];

      try {
        final data = await startupConnect.FetchProducts(user_id: user_id);
        // print('Detail View Fetch Product $data');
        product_len = data['data'].length;
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
  MainMethodSection(BuildContext contex) {
    var no_product = Container();

    var product_list = Column(
      children: [
        SizedBox(height: context.height * product_top_space),

        // PRODUCT HEADING :
        StartupHeaderText(
          title: 'Product',
          font_size: heading_fontSize,
        ),

        SizedBox(height: context.height * product_bottom_space),

        is_admin == true
            ? MyEditButton(func: EditProductAndService, text: 'Edit')
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

    if (product_len <= 0) {
      return no_product;
    } else {
      return product_list;
    }
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
