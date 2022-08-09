import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/MainUserStartupsShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

/////////////////////////////////////////
///  Container main startup Container
///  Has coursel and other method:
///  1. thumbnail :
///  2. startup info : moree..
/////////////////////////////////////////
class StartupContainer extends StatelessWidget {
  var menutype;
  StartupContainer({this.menutype, Key? key}) : super(key: key);

  var homeviewConnector = Get.put(HomeViewConnector());
  CarouselController buttonCarouselController = CarouselController();
  var startups_length = 0;

  var startup_name = [];

  var startup_ids = [];

  var mainWidget;

  @override
  Widget build(BuildContext context) {
    ///////////////////////////
    /// GET REQUIREMENTS :
    ///////////////////////////
    GetLocalStorageData() async {
      final user_id = await getUserId;
      final usertype = await getUserType;
      var resp;
      print(menutype);
      if (usertype != null) {
        if (usertype == 'investor') {
          resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
        }

        // If user type founder then check selected menu type:
        // 1. if menu === intrested then show intrested startups :
        // 2. menu == my_startup show his startups: [ Default ] :
        if (usertype == 'founder') {
          resp = await homeviewConnector.FetchUserStartups(user_id: user_id);
        }
      }

      if (resp['response']) {
        startups_length = resp['data']['startup_len'];
        startup_ids = resp['data']['startup_ids'];
        startup_name = resp['data']['startup_name'];
      }
    }

    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MainUserStartupsShimmer(context);
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    if (startups_length <= 0) {
      mainWidget = MainUserStartupsShimmer(context);
    } else {
      mainWidget = StartupCont(context);
    }
    return mainWidget;
  }

  Container StartupCont(BuildContext context) {
    return Container(
        width: context.width * 0.45,
        height: context.height * 0.42,
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileStoryThumbnail(
                                  startup_id: startup_ids[itemIndex],
                                ),
                                ProfileStoryHeading(
                                  startup_name: startup_name[itemIndex],
                                ),
                                ProfileInfoChart(
                                  startup_id: startup_ids[itemIndex],
                                ),
                              ],
                            ),
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
