import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/connector/GetStartupData.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Products.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Services.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ServiceSection extends StatefulWidget {
  const ServiceSection({Key? key}) : super(key: key);

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  var services = [];
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

    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        await Future.delayed(Duration(seconds: 5));
        final data = await startupConnect.FetchServices();
        services = data;
        return data;
      } catch (e) {
        return '';
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Services(
                service: temp_product,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    return Container(
      width: context.width * 0.70,
      height: context.height * 0.50,
      margin: EdgeInsets.only(
          bottom: context.height * 0.06, top: context.height * 0.06),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: services.length,
        itemBuilder: (context, index) {
        return Services(service: services[index],);
      }),
    );
  }
}
