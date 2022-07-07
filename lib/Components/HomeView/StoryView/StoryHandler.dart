import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shimmer/shimmer.dart';

class StoryListView extends StatelessWidget {
  StoryListView({Key? key}) : super(key: key);

  var homeViewConnector = Get.put(HomeViewConnector());
  var startups_length;
  var startup_ids;

  @override
  Widget build(BuildContext context) {
//////////////////////////////////////////////////////
    /// GET SECTION :
//////////////////////////////////////////////////////
    GetLocalStorageData() async {
      try {
        final resp = await homeViewConnector.FetchStartups();
        if (resp['response']) {
          startups_length = resp['data']['startup_len'];
          startup_ids = resp['data']['startup_ids'];
        }
        if (!resp['response']) {
          startups_length = 0;
        }
      } catch (e) {
        startups_length = 0;
        return '';
      }
    }

//////////////////////////////////////////////////////
    /// SET SECTION :
//////////////////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Input Section',
                style: Get.textTheme.headline2,
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

  //////////////////////////////////////////////////////
  /// MAIN SECTION :
  //////////////////////////////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
        width: context.width * 0.45,
        height: context.height * 0.67,
        child: Swiper(
          // containerHeight: 200,
          // containerWidth: 200,
          // CONTENT SECTION :
          itemBuilder: ((context, index) {
            print(index);
            return StoryView(
              key: UniqueKey(),
              // startup_id: startup_ids[index],
            );
          }),
          index: 0,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          pagination: SwiperPagination(builder: SwiperPagination.dots),
          control: SwiperControl(
            color: Colors.blueGrey.shade100,
            padding: EdgeInsets.only(top: context.height * 0.04, right: 8.0),
          ),
        ));
  }
}
