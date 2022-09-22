import 'package:be_startup/AppState/StartupState.dart';
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

  double service_cont_width = 0.75;

  double service_cont_height = 0.60;

  double service_top_margin = 0.06;

  double service_bottom_margin = 0.06;


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
      service_cont_width = 0.75;

     service_cont_height = 0.60;

     service_top_margin = 0.02;

     service_bottom_margin = 0.06;



		// DEFAULT :
    if (context.width > 1700) {
        service_cont_width = 0.75;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;


        print('Greator then 1700');
      }
  
    if (context.width < 1700) {
        service_cont_width = 0.75;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;
        print('1700');
      }
  
    if (context.width < 1600) {
        print('1500');
      }

    // PC:
    if (context.width < 1500) {
        service_cont_width = 0.80;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;
        print('1500');
      }

    if (context.width < 1300) {
        service_cont_width = 0.80;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;
        print('1300');
      }

    if (context.width < 1200) {
        service_cont_width = 0.85;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;

        print('1200');
      }
    
    if (context.width < 1000) {
        service_cont_width = 0.95;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;

        print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        service_cont_width = 1;

        service_cont_height = 0.60;

        service_top_margin = 0.02;

        service_bottom_margin = 0.06;

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
      width: context.width * service_cont_width,
      height: context.height * service_cont_height,
      margin: EdgeInsets.only(
          bottom: context.height * service_bottom_margin, top: context.height *service_top_margin),
   
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
