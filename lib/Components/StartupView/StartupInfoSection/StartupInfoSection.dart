import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/InvestmentChart.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/Picture.dart';
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

  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');
  var founderConnector = Get.put(FounderConnector());

  double image_cont_width = 0.6;
  double image_cont_height = 0.20;
  bool? is_admin;

  var startup_logo;
  var founder_profile;
  String? founder_name;
  var primary_mail;
  var registor_mail;
  var default_mail;

  // Edit Thumbnail :
  EditThumbnail() {
    Get.toNamed(create_business_thumbnail_url, parameters: {'type': 'update'});
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
      is_admin = await getIsUserAdmin;
      final startup_id = await getStartupDetailViewId;
      final founder_id = await getStartupFounderId;

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

          if (primary_mail != '') {
            registor_mail = primary_mail;
          }

          await SetStartupFounderEmail(registor_mail);
          
        }
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
        var my_data = {'thumbnail': thumbnail, 'logo': logo};

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
            return Center(
                child: Shimmer.fromColors(
                    baseColor: shimmer_base_color,
                    highlightColor: shimmer_highlight_color,
                    child: MainMethod(
                        context,
                        snapshot.data == null
                            ? {
                                'thumbnail': shimmer_image,
                                'logo': shimmer_image
                              }
                            : snapshot.data)));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data);
          }
          return MainMethod(context, snapshot.data);
        });
  }

///////////////////////////////////////
  /// MAIN METHOD :
///////////////////////////////////////
  Container MainMethod(BuildContext context, data) {
    return Container(
        height: context.height * 0.45,
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

            Positioned(
                left: context.width * 0.50,
                top: context.height * 0.25,
                child: InvestmentChart()),

            // TABS
            Positioned(
              top: context.height * 0.25,
              left: context.width * 0.10,
              child: Container(
                  width: context.width * 0.39,
                  height: 65,
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
            )
          ],
        ));
  }

  Stack Thumbnail(BuildContext context, thumbnail_image) {
    return Stack(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          )),
          child: InkWell(
            onHover: (flag) {},
            child: Container(
                height: context.height * 0.23,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
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
                left: context.width * 0.53,
                top: context.height * 0.02,
                child: Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: border_color)),
                  child: TextButton.icon(
                      onPressed: () {
                        EditThumbnail();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 15,
                      ),
                      label: Text('Edit')),
                ))
            : Positioned(
                left: context.width * 0.53,
                top: context.height * 0.02,
                child: Container(
                  width: 80,
                  height: 30,
                ))
      ],
    );
  }
}
