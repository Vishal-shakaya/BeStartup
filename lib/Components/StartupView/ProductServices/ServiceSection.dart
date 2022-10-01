import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/ProductServices/Services.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ServiceSection extends StatelessWidget {
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');
  var detailViewState = Get.put(StartupDetailViewState());
  var services = [];
  var is_admin;
  var startup_id;
  var founder_id;

  double service_cont_width = 0.75;

  double service_cont_height = 0.60;

  double service_top_margin = 0.06;

  double service_bottom_margin = 0.06;

  double heading_fontSize = 32;

  var service_len = 0;

  double prouduct_bottom_space = 0.03;

  double service_bottom_height = 0.04;


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



  ///////////////////////////////////////////
  /// Get Required param :
  ///////////////////////////////////////////
  GetLocalStorageData() async {
    try {
      startup_id = await detailViewState.GetStartupId();
      is_admin = await detailViewState.GetIsUserAdmin();
      founder_id = await detailViewState.GetFounderId();
      
      final data = await startupConnect.FetchServices(startup_id: startup_id);
      
      service_len = data['data'].length;

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

    prouduct_bottom_space = 0.03;

    service_bottom_height = 0.04;

    edit_btn_width = 0.63;

    edit_btn_cont_width = 90;

    edit_btn_cont_height = 30;

    edit_btn_top_margin = 0.2;

    edit_btn_radius = 15;

    edit_btn_iconSize = 15;

    edit_btn_fontSize = 15;

    // DEFAULT :
    if (context.width > 1700) {
      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.04;

      service_cont_width = 0.75;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;
      
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
      service_cont_width = 0.75;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

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
      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03;

      service_cont_width = 0.80;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

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
      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03;

      service_cont_width = 0.80;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

      
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
      service_cont_width = 0.85;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

      edit_btn_width = 0.70;

      edit_btn_cont_width = 80;

      edit_btn_cont_height = 30;

      edit_btn_top_margin = 0.2;

      edit_btn_radius = 15;

      edit_btn_iconSize = 14;

      print('1200');
    }

    if (context.width < 1000) {
      service_cont_width = 0.95;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

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
      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03;

      service_cont_width = 1;

      service_cont_height = 0.60;

      service_top_margin = 0.02;

      service_bottom_margin = 0.06;

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
      prouduct_bottom_space = 0.03;
      service_bottom_height = 0.02;

      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      prouduct_bottom_space = 0.03;

      service_bottom_height = 0.03;
      print('480');
    }

    /////////////////////////////////////
    /// HEADING FONT SIZE :
    /////////////////////////////////////
    heading_fontSize = 32;
    if (context.width > 1700) {
      heading_fontSize = 32;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1300) {
      heading_fontSize = 30;
      print('1300');
    }

    if (context.width < 1200) {
      heading_fontSize = 30;
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      heading_fontSize = 28;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      heading_fontSize = 28;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      heading_fontSize = 25;
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
   MainMethod(BuildContext context) {
    var no_services = Container();

    var services_section = Column(
      children: [
        SizedBox(height: context.height * prouduct_bottom_space),

        // SERVICE HEADING :
        StartupHeaderText(
          title: 'Services',
          font_size: heading_fontSize,
        ),

      is_admin == true
        ? EditButton(context, EditProductAndService)
        : Container(),

        SizedBox(height: context.height * service_bottom_height),

        Container(
          width: context.width * service_cont_width,
          height: context.height * service_cont_height,
          margin: EdgeInsets.only(
              bottom: context.height * service_bottom_margin,
              top: context.height * service_top_margin),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Services(service: services[index], key: UniqueKey());
              }),
        ),
      ],
    );

    if (service_len <= 0) {
      return no_services;
    } else {
      return services_section;
    }
  }


  Container EditButton(BuildContext context, EditProductAndService) {
    return Container(
        width: context.width * edit_btn_width,
        alignment: Alignment.topRight,
        // margin: EdgeInsets.only(top: context.hei),
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
              icon: Icon(
                Icons.edit,
                size: edit_btn_iconSize,
                color: edit_btn_color,
              ),
              label: Text(
                'Edit',
                style: TextStyle(
                    color: edit_btn_color, fontSize: edit_btn_fontSize),
              )),
        ));
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
