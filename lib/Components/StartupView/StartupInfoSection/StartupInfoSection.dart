import 'package:be_startup/Backend/Startup/connector/FetchStartupData.dart';
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

class StartupInfoSection extends StatefulWidget {
  StartupInfoSection({Key? key}) : super(key: key);

  @override
  State<StartupInfoSection> createState() => _StartupInfoSectionState();
}

class _StartupInfoSectionState extends State<StartupInfoSection> {
  double image_cont_width = 0.6;
  double image_cont_height = 0.20;
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');

  EditThumbnail() {
    Get.toNamed(create_business_thumbnail_url, parameters: {'type':'update'});
  }

  @override
  Widget build(BuildContext context) {
    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        final data1 = await startupConnect.FetchBusinessDetail();
        final data = await startupConnect.FetchThumbnail();
        var temp_data = {'thumbnail': data, 'logo': data1};
        return temp_data;
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
            ),

            // TABS
            Positioned(
              top: context.height * 0.25,
              left: context.width * 0.10,
              child: Container(
                  width: context.width * 0.55,
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

                      // STATIC SECTION WITH INVEST BUTTON :
                      InvestmentChart()
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
        Positioned(
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
            )),
      ],
    );
  }
}
