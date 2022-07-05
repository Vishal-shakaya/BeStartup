import 'package:be_startup/Backend/Startup/connector/FetchStartupData.dart';
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
  var products = [];

  EditProductAndService() {
    Get.toNamed(create_business_product_url, parameters: {'type': 'update'});
  }

  @override
  Widget build(BuildContext context) {


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
    var startupConnect =
        Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

////////////////////////////////////////
///  GET REQUIREMENTS : 
////////////////////////////////////////
    GetLocalStorageData() async {
      try {
        final data = await startupConnect.FetchProducts();
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
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Products(
                product: temp_product,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethodSection(context);
          }
          return MainMethodSection(context);
        });
  }



  Column MainMethodSection(BuildContext contex) {
    return Column(
      children: [
        EditButton(context, EditProductAndService),
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
}
