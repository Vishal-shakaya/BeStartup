import 'dart:convert';

import 'package:be_startup/AppState/DetailViewState.dart';
import 'package:be_startup/AppState/PageState.dart';
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
  var products = [];
  var is_admin;
  var startup_id;
  var founder_id;

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
    var pageParam = jsonEncode( {
          'type': 'update',
          'startup_id': startup_id,
          'is_admin':is_admin,
          'founder_id':founder_id });

    Get.toNamed(create_business_product_url,
        parameters:{'data':pageParam});
  }

  @override
  Widget build(BuildContext context) {
    var startupConnect =
        Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

    ////////////////////////////////////////////
    ///  GET REQUIREMENTS :
    ////////////////////////////////////////////
    GetLocalStorageData() async {
      startup_id = await detailViewState.GetStartupId();
      is_admin =   await detailViewState.GetIsUserAdmin();
      founder_id = await detailViewState.GetFounderId();

      try {
        final data = await startupConnect.FetchProducts(startup_id: startup_id);
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
            width: context.width * 0.75,
            height: context.height * 0.60,
            margin: EdgeInsets.only(
                bottom: context.height * 0.06, top: context.height * 0.02),
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
        width: context.width * 0.63,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: context.height * 0.02),
        child: Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                EditProductAndService();
              },
              icon: Icon(
                Icons.edit,
                size: 15,
              ),
              label: Text('Edit')),
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
