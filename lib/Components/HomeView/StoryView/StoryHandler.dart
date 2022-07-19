import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shimmer/shimmer.dart';

import 'package:carousel_slider/carousel_slider.dart';

class StoryListView extends StatelessWidget {
  bool? is_save_page = false;
  StoryListView({this.is_save_page, Key? key}) : super(key: key);

  var homeViewConnector = Get.put(HomeViewConnector());
  var startups_length;
  var startup_names;
  var startup_ids;
  var founder_ids;

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
//////////////////////////////////////////////////////
    /// GET SECTION :
//////////////////////////////////////////////////////
    GetLocalStorageData() async {
      final user_id = await getUserId;
      var resp;
      try {
        print('is Save Page $is_save_page');
        if (is_save_page == true) {
          print('Fetch Save Startups ');
          resp = await homeViewConnector.FetchSaveStartups(user_id: user_id);
        } else {
          print('Fectching All Post ');
          resp = await homeViewConnector.FetchStartups();
        }
        if (resp['response']) {
          startups_length = resp['data']['startup_len'];
          startup_ids = resp['data']['startup_ids'];
          founder_ids = resp['data']['founder_id'];
          startup_names = resp['data']['startup_name'];
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
        child: Stack(
          children: [
            //////////////////////////////////
            // CAURSEL SLIDER :
            //////////////////////////////////
            CarouselSlider.builder(
                carouselController: buttonCarouselController,
                itemCount: startups_length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    child: StoryView(
                      key: UniqueKey(),
                      startup_id: startup_ids[itemIndex],
                      founder_id: founder_ids[itemIndex],
                      startup_name: startup_names[itemIndex],
                    ),
                  );
                },
                options: CarouselOptions(
                    height: context.height * 0.67, viewportFraction: 1)),

            // Back Button :
            BackButton(context),
            ForwordButton(context)
          ],
        ));
  }

//////////////////////////////////////////////////
  /// EXTERNAL METHOD  :
//////////////////////////////////////////////////
  Positioned ForwordButton(BuildContext context) {
    return Positioned(
        top: context.height * 0.32,
        left: context.width * 0.42,
        child: Container(
          child: IconButton(
              onPressed: () {
                buttonCarouselController.nextPage(
                    duration: Duration(milliseconds: 450),
                    curve: Curves.linear);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade300,
              )),
        ));
  }

  Positioned BackButton(BuildContext context) {
    return Positioned(
        top: context.height * 0.32,
        left: context.width * 0.01,
        child: Container(
          child: IconButton(
              onPressed: () {
                buttonCarouselController.previousPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey.shade300,
              )),
        ));
  }
}
