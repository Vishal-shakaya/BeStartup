import 'dart:convert';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/InvestmentChart.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/Picture.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupDetailButtons.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupNavigation.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum StartupPageRoute {
  team,
  vision,
  invest,
}

class StartupInfoSection extends StatelessWidget {
  StartupInfoSection({Key? key}) : super(key: key);

  var startupConnect = Get.put(StartupViewConnector());
  var founderConnector = Get.put(FounderConnector());

  var startup_logo;

  bool? is_admin;
  bool? is_liked = false;
  var startup_id;
  var founder_id;

  String? founder_name;
  var founder_profile;
  var primary_mail;
  var registor_mail;
  var default_mail;

  double image_cont_width = 0.6;
  double image_cont_height = 0.20;

  double image_sec_height = 0.23;

  double page_height = 0.45;

  double invest_chart_left_margin = 0.50;
  double invest_chart_top_margin = 0.25;

  double tab_top_margin = 0.25;
  double tab_left_margin = 0.10;

  double tab_cont_width = 0.39;
  double tab_cont_height = 65;

  double edit_btn_left_margin = 0.53;
  double edit_btn_top_margin = 0.02;

  double edit_btn_width = 80;
  double edit_btn_height = 30;

  double edit_iconSize = 15;

  double detail_btn_top_margin = 0.25;

  double detail_btn_left_margin = 0.20;

  double edit_btn_fontSize = 14;
/////////////////////////////////////////
  /// GET REQUIRED PARAM :
/////////////////////////////////////////
  IsStartupLiked() async {
    final resp = await startupConnect.IsStartupLiked(
      startup_id: startup_id,
      user_id: founder_id,
    );

    if (resp['code'] == 101) {
      is_liked = true;
    }
    if (resp['code'] == 111) {
      is_liked = false;
    }
  }

  // Edit Thumbnail :
  EditThumbnail() {
    var param = jsonEncode({
      'type': 'update',
      'founder_id': founder_id,
      'startup_id': startup_id,
      'is_admin': is_admin,
    });

    Get.toNamed(create_business_thumbnail_url, parameters: {'data': param});
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////
    /// GET REQUIRED PARAMETER :
    //////////////////////////////////////////
    GetLocalStorageData() async {
      var my_data;
      var thumbnail;
      var logo;

      var startupDetialView = Get.put(StartupDetailViewState());
      var userStateView = Get.put(UserState());

      is_admin = await startupDetialView.GetIsUserAdmin();
      startup_id = await startupDetialView.GetStartupId();
      founder_id = await startupDetialView.GetFounderId();

      // Set Liked Default State :
      await IsStartupLiked();

      try {
        final business_name_resp =
            await startupConnect.FetchBusinessDetail(startup_id: startup_id);
        final business_thum_resp =
            await startupConnect.FetchThumbnail(startup_id: startup_id);

        final found_resp = await founderConnector.FetchFounderDetailandContact(
            user_id: founder_id);

        ////////////////////////////////////////
        // Founder Success Handler :
        ////////////////////////////////////////
        if (found_resp['response']) {
          founder_profile = found_resp['data']['userDetail']['picture'];
          founder_name = found_resp['data']['userDetail']['name'];

          registor_mail = found_resp['data']['userDetail']['email'];
          primary_mail = found_resp['data']['userContect']['primary_mail'];

          primary_mail = await CheckAndGetPrimaryMail(
              primary_mail: primary_mail, default_mail: registor_mail);
        }

        // Founder Error Handler :
        if (!found_resp['response']) {
          founder_profile = found_resp['data'];
        }

        /////////////////////////////////////
        // Thumbnail Handler :
        /////////////////////////////////////
        if (business_thum_resp['response']) {
          thumbnail = business_thum_resp['data']['thumbnail'];
        }
        if (!business_thum_resp['response']) {
          thumbnail = business_thum_resp['data'];
        }

        ////////////////////////////////////
        // Business Detial  Handler :
        ////////////////////////////////////
        if (business_name_resp['response']) {
          logo = business_name_resp['data']['logo'];
        }
        if (!business_name_resp['response']) {
          logo = business_name_resp['data'];
        }
        my_data = {'thumbnail': thumbnail, 'logo': logo};

        return my_data;
      } catch (e) {
        return my_data;
      }
    }

    //////////////////////////////////////////
    /// SET REQUIRED PARAMETER :
    //////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return StoryViewThumbnailAndLogoShimmer(context, snapshot);
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data);
          }
          return MainMethod(context, snapshot.data);
        });
  }

  Container MainMethod(BuildContext context, data) {
    image_cont_width = 0.6;
    image_cont_height = 0.20;

    image_sec_height = 0.23;

    page_height = 0.45;

    invest_chart_left_margin = 0.50;
    invest_chart_top_margin = 0.25;

    tab_top_margin = 0.25;
    tab_left_margin = 0.10;

    tab_cont_width = 0.39;
    tab_cont_height = 65;

    edit_btn_left_margin = 0.53;
    edit_btn_top_margin = 0.02;

    edit_btn_width = 80;
    edit_btn_height = 30;

    edit_iconSize = 15;

    detail_btn_top_margin = 0.25;

    detail_btn_left_margin = 0.20;

    edit_btn_fontSize = 14;

    // DEFAULT :
    if (context.width > 1700) {
      image_cont_width = 0.6;
      image_cont_height = 0.20;

      image_sec_height = 0.23;

      page_height = 0.45;

      invest_chart_left_margin = 0.50;
      invest_chart_top_margin = 0.25;

      tab_top_margin = 0.25;
      tab_left_margin = 0.10;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.53;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;

      detail_btn_top_margin = 0.25;

      detail_btn_left_margin = 0.20;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      image_cont_width = 0.6;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.49;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.10;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.53;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;
      print(' 1700');
    }

    if (context.width < 1600) {
      image_cont_width = 0.64;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.52;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.10;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.58;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;
      print(' 1600');
    }

    if (context.width < 1500) {
      image_cont_width = 0.66;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.51;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.10;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.58;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 14;
      print('1500');
    }

    if (context.width < 1400) {
      image_cont_width = 0.66;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.51;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.12;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.58;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;
      print('1400');
    }

    if (context.width < 1300) {
      image_cont_width = 0.70;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.54;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.13;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.60;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;
      print('1300');
    }

    if (context.width < 1200) {
      image_cont_width = 0.75;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.58;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.16;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.65;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 14;
      print('1200');
    }

    if (context.width < 1100) {
      image_cont_width = 0.75;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.57;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.16;

      tab_cont_width = 0.39;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.61;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 15;
      print('1100');
    }

    if (context.width < 1000) {
      image_cont_width = 0.85;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.65;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.17;

      tab_cont_width = 0.44;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.74;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 14;
      edit_btn_fontSize = 12;
      print('1000');
    }

    // TABLET :
    if (context.width < 900) {
      image_cont_width = 0.85;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.63;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.16;

      tab_cont_width = 0.44;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.74;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 14;
      print('900');
    }

    if (context.width < 800) {
      image_cont_width = 0.90;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.69;
      invest_chart_top_margin = 0.24;

      tab_top_margin = 0.25;
      tab_left_margin = 0.18;

      tab_cont_width = 0.49;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.74;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 80;
      edit_btn_height = 30;

      edit_iconSize = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 660) {
      image_cont_width = 0.99;
      image_cont_height = 0.20;

      page_height = 0.45;

      invest_chart_left_margin = 0.72;
      invest_chart_top_margin = 0.23;

      tab_top_margin = 0.25;
      tab_left_margin = 0.18;

      tab_cont_width = 0.53;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.80;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 70;
      edit_btn_height = 30;

      edit_iconSize = 14;

      edit_btn_fontSize = 12;

      print('640');
    }

    // PHONE:
    if (context.width < 550) {
      image_cont_width = 0.99;
      image_cont_height = 0.05;

      image_sec_height = 0.19;

      page_height = 0.45;

      invest_chart_left_margin = 0.14;
      invest_chart_top_margin = 0.33;

      tab_top_margin = 0.21;
      tab_left_margin = 0.22;

      tab_cont_width = 0.52;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.76;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 70;
      edit_btn_height = 25;

      edit_iconSize = 14;

      detail_btn_top_margin = 0.21;

      detail_btn_left_margin = 0.80;

      edit_btn_fontSize = 12;
    }

    if (context.width < 480) {
      image_cont_width = 0.99;
      image_cont_height = 0.05;

      image_sec_height = 0.19;

      page_height = 0.45;

      invest_chart_left_margin = 0.14;
      invest_chart_top_margin = 0.33;

      tab_top_margin = 0.22;
      tab_left_margin = 0.25;

      tab_cont_width = 0.52;
      tab_cont_height = 65;

      edit_btn_left_margin = 0.76;
      edit_btn_top_margin = 0.02;

      edit_btn_width = 62;
      edit_btn_height = 23;

      edit_btn_fontSize = 12;
      edit_iconSize = 12;

      detail_btn_top_margin = 0.21;

      detail_btn_left_margin = 0.80;


      print('480');
    }

    return Container(
        height: context.height * page_height,
        child: Stack(
          children: [
            // THUMBNAIL SECTION:
            Thumbnail(context, data['thumbnail']),

            // PROFILE PICTURE :
            Picture(
              logo: data['logo'],
              founder_name: founder_name,
              founder_profile: founder_profile,
            ),

            // INVESTMENT CHART :
            Positioned(
                left: context.width * invest_chart_left_margin,
                top: context.height * invest_chart_top_margin,
                child: InvestmentChart()),

            // TABS
            Positioned(
              top: context.height * tab_top_margin,
              left: context.width * tab_left_margin,
              child: Container(
                  width: context.width * tab_cont_width,
                  height: tab_cont_height,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      StartupNavigation(
                          title: 'Team', route: StartupPageRoute.team),
                      StartupNavigation(
                          title: 'Vision', route: StartupPageRoute.vision),
                      StartupNavigation(
                          title: 'Invest', route: StartupPageRoute.invest),
                    ],
                  )),
            ),


            // Show like and mail button phone size :
            // if user is not admin and screen size < then 550; 
            is_admin == true
                ? Positioned(
                        top: context.height * detail_btn_top_margin,
                        left: context.width * detail_btn_left_margin,
                        child: Container())
                 : context.width < 550
                    ? Positioned(
                        top: context.height * detail_btn_top_margin,
                        left: context.width * detail_btn_left_margin,
                        child: StartupDetailButtons(
                          startup_id: startup_id,
                          user_id: founder_id,
                          is_saved: is_liked,
                        ))
                    
                    : Positioned(
                        top: context.height * detail_btn_top_margin,
                        left: context.width * detail_btn_left_margin,
                        child: Container()),

            // Phone Small Chart :
            // Positioned(
            //   child:
            //   )
          ],
        ));
  }

  Stack Thumbnail(BuildContext context, thumbnail_image) {
    return Stack(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.grey,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          )),
          child: InkWell(
            onHover: (flag) {},
            child: Container(
                height: context.height * image_sec_height,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(19),
                    right: Radius.circular(19),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: thumbnail_image,
                    width: context.width * image_cont_width,
                    height: context.height * image_cont_height,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        ),
        is_admin == true
            ? Positioned(
                left: context.width * edit_btn_left_margin,
                top: context.height * edit_btn_top_margin,
                child: Container(
                  width: edit_btn_width,
                  height: edit_btn_height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: border_color)),
                  child: TextButton.icon(
                      onPressed: () {
                        EditThumbnail();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: edit_iconSize,
                        color: edit_btn_color,
                      ),
                      label: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: edit_btn_fontSize,
                          color: edit_btn_color),
                      )),
                ))
            : Positioned(
                left: context.width * edit_btn_left_margin,
                top: context.height * edit_btn_top_margin,
                child: Container(
                  width: edit_btn_width,
                  height: edit_btn_height,
                ))
      ],
    );
  }

  Center StoryViewThumbnailAndLogoShimmer(
      BuildContext context, AsyncSnapshot<Object?> snapshot) {
    return Center(
        child: Shimmer.fromColors(
            baseColor: shimmer_base_color,
            highlightColor: shimmer_highlight_color,
            child: MainMethod(
                context,
                snapshot.data == null
                    ? {'thumbnail': shimmer_image, 'logo': shimmer_image}
                    : snapshot.data)));
  }
}
