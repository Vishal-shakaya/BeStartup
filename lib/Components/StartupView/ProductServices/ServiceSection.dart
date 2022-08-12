import 'package:be_startup/AppState/DetailViewState.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Services.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ServiceSection extends StatelessWidget {
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');
  var detailViewState = Get.put(StartupDetailViewState());
  var services = [];

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

  ///////////////////////////////////////////
  /// Get Required param :
  ///////////////////////////////////////////
  GetLocalStorageData() async {
    try {
      final startup_id = await detailViewState.GetStartupId();
      final data = await startupConnect.FetchServices(startup_id: startup_id);
      services = data['data'];
      return data;
    } catch (e) {
      return services;
    }
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////
    /// Set Required param :
    //////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ServiceShimmer();
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

///////////////////////////////////////
  /// Main Method :
///////////////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
      width: context.width * 0.75,
      height: context.height * 0.60,
      margin: EdgeInsets.only(
          bottom: context.height * 0.06, top: context.height * 0.06),
   
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Services(service: services[index], key: UniqueKey());
          }),
    );
  }

  Center ServiceShimmer() {
    return Center(
        child: Shimmer.fromColors(
      baseColor: shimmer_base_color,
      highlightColor: shimmer_highlight_color,
      child: Services(
        service: temp_product,
      ),
    ));
  }
}
