import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/MainUserStartupsShimmer.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/AppState/StartupState.dart';

class FounderStartups extends StatefulWidget {
  var startupType;

  FounderStartups({this.startupType, Key? key}) : super(key: key);

  @override
  State<FounderStartups> createState() => _FounderStartupsState();
}

class _FounderStartupsState extends State<FounderStartups> {
  var homeviewConnector = Get.put(HomeViewConnector());
  var startupState = Get.put(StartupDetailViewState());
  var userState = Get.put(UserState());
  CarouselController buttonCarouselController = CarouselController();

  var startups_length = 0;

  var startup_name = [];

  var user_ids = [];

  var usertype;
  var user_id;
  User? user;

  var menuType = FounderStartupMenu.my_startup;
  var frontText = 'SUP';
  var backText = 'Interested';

  double startup_sec_width = 0.45;
  double startup_sec_height = 0.42;
  double startup_cont_height = 0.45;

  int back_button_flex = 10;
  int forword_button_flex = 10;
  int startup_flex = 80;

  double back_button_left_margin = 20;

  double forword_button_right_margin = 20;

  double switch_btn_top_margin = 0.04;
  double switch_btn_right_margin = 0.70;

  double switch_btn_fontSize = 14;
  double switch_btn_width = 100;

  double back_btn_left_margin = 20;
  double forword_btn_right_margin = 20;

  double spacer = 0.04;

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    print(widget.startupType);
    
    user = FirebaseAuth.instance.currentUser;
    usertype = await userState.GetUserType();
    user_id = user?.uid;

    var resp;

    if (usertype != null) {
      print('user Type $usertype');
      ///////////////////////////////////////////
      /// If user is Investor :
      ///////////////////////////////////////////
      if (usertype == UserType.investor) {
        resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
      }

      /////////////////////////////////////////////////////////////
      // If user type founder then check selected menu type:
      // 1. if menu === intrested then show intrested startups :
      // 2. menu == my_startup show his startups: [ Default ] :
      /////////////////////////////////////////////////////////////
      if (usertype == UserType.founder) {
        if (widget.startupType == FounderStartupMenu.my_startup) {
          print('Menu Type $menuType');
          resp = await homeviewConnector.FetchUserStartups(user_id: user_id);
          print('Menu Type $resp');
        } else {
          resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
        }
      }
    }

    // Response Handler :
    if (resp['response']) {
      startups_length = resp['data']['startup_len'];
      user_ids = resp['data']['user_ids'];
      startup_name = resp['data']['startup_name'];
    }

    print(resp);
  }

  @override
  Widget build(BuildContext context) {
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
    return Container(
        width: context.width * startup_sec_width,
        height: context.height * startup_sec_height,
        child: Row(
          children: [
            // Bakcword Button :
            Expanded(
              child: BackButton(context),
              flex: back_button_flex,
            ),

            Expanded(
                flex: startup_flex,
                child: CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    itemCount: startups_length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: context.height * 0.03),
                        child: SizedBox(
                          height: context.height * startup_cont_height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileStoryThumbnail(
                                  user_id: user_ids[itemIndex],
                                ),
                                ProfileStoryHeading(
                                  startup_name: startup_name[itemIndex],
                                ),
                                ProfileInfoChart(
                                  user_id: user_ids[itemIndex],
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
            Expanded(flex: forword_button_flex, child: ForwordButton(context))
          ],
        ));
  }

  BackButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: back_btn_left_margin),
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
      margin: EdgeInsets.only(right: forword_btn_right_margin),
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
