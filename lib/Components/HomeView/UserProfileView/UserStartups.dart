import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HomeViewUserStartups extends StatelessWidget {
  HomeViewUserStartups({Key? key}) : super(key: key);
  var homeviewConnector = Get.put(HomeViewConnector());
  CarouselController buttonCarouselController = CarouselController();
  var startups_length;
  var startup_name = [];
  var startup_ids = [];
  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    final user_id = await getUserId;
    final resp = await homeviewConnector.FetchUserStartups(user_id: user_id);
    startups_length = resp['data']['startup_len'];
    startup_ids = resp['data']['startup_ids'];
    startup_name = resp['data']['startup_name'];
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
                    baseColor: shimmer_base_color,
                    highlightColor: shimmer_highlight_color,
                    child: MainMethod(context)));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  ////////////////////////////
  /// MainMethod :
  ////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
        width: context.width * 0.45,
        height: context.height * 0.45,
        child: Row(
          children: [
            // Bakcword Button :
            Expanded(
              child: BackButton(context),
              flex: 10,
            ),

            Expanded(
                flex: 80,
                child: CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    itemCount: startups_length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: context.height * 0.03),
                        child: SizedBox(
                          height: context.height * 0.43,
                          child: Stack(
                            children: [
                              ProfileStoryThumbnail(
                                startup_id: startup_ids[itemIndex],
                              ),
                              ProfileStoryHeading(
                                startup_name: startup_name[itemIndex],
                              ),
                              ProfileInfoChart(),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        height: context.height * 0.67, viewportFraction: 1))),

            // Forword Button :
            Expanded(flex: 10, child: ForwordButton(context))
          ],
        ));
  }

  //////////////////////////////////////////////////
  /// EXTERNAL METHOD  :
//////////////////////////////////////////////////

  BackButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: IconButton(
          onPressed: () {
            buttonCarouselController.previousPage();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade400,
          )),
    );
  }

  ForwordButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: IconButton(
          onPressed: () {
            buttonCarouselController.nextPage(
                duration: Duration(milliseconds: 450), curve: Curves.linear);
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade400,
          )),
    );
  }
}
