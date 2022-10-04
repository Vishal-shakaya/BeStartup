import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryView.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/MainHomeViewShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:carousel_slider/carousel_slider.dart';

class StoryListView extends StatelessWidget {
  bool? is_save_page = false;
  bool? is_explore = false;
    
  StoryListView({this.is_explore = false, this.is_save_page, Key? key})
      : super(key: key);

  var homeViewConnector = Get.put(HomeViewConnector());
  var exploreStore = Get.put(ExploreCatigoryStore());
  CarouselController buttonCarouselController = CarouselController();
  User? user;

  var startups_length;
  var startup_names;
  var startup_ids;
  var founder_ids;

  var catigory;
  var date_range;
  var user_id;

  double storyWidth = 0.45;
  double storyHeight = 0.67;

  double forword_btn_top = 0.32;
  double forword_btn_left = 0.42;

  double backword_btn_left = 0.01;
  double backword_btn_top = 0.32; 

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////
    /// GET SECTION :
    //////////////////////////////////////////////////////
    GetLocalStorageData() async {
      user = FirebaseAuth.instance.currentUser;
      user_id = user?.uid;
      var resp;

      try {
        //////////////////////////////////////////
        /// Filter Startup If Explore is true:
        /// 1 filtering using datetime :
        /// 2 Catigory :
        //////////////////////////////////////////
        if (is_explore == true) {
          catigory = await exploreStore.GetCatigories();
          date_range = await exploreStore.GetDateRange();

          resp = await homeViewConnector.FetchExploreStartups(
              start_date: date_range['start'],
              end_date: date_range['end'],
              catigories: catigory);
        }

        ///////////////////////////////////////////////
        /// Fetch Startup if Save is true :
        ///  1 fetch user save startups:
        ///////////////////////////////////////////////
        if (is_save_page == true) {
          print('Fetching Save Styory ');
          resp = await homeViewConnector.FetchSaveStartups(user_id: user_id);
          print('Save Story Response $resp');
        }

        /////////////////////////////////////////////////
        /// Fetch all Startups here :
        /// if explore and is_save is false :
        /////////////////////////////////////////////////
        else {
          resp = await homeViewConnector.FetchStartups();
        }

        // General Response Hnadler :
        if (resp['response']) {
          startups_length = resp['data']['startup_len'];
          startup_ids = resp['data']['startup_ids'];
          founder_ids = resp['data']['founder_id'];
          startup_names = resp['data']['startup_name'];
        }

        // Error handler :
        if (!resp['response']) {
          startups_length = 0;
        }
      } catch (e) {
        startups_length = 0;
        return '';
      }
    }

    //////////////////////////////////////////////////////
    /// SET REQUIREMENTS SECTION :
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
    var mainWidget;

     storyWidth = 0.45;
     storyHeight = 0.67;

     forword_btn_top = 0.32;
     forword_btn_left = 0.42;

     backword_btn_left = 0.01;
     backword_btn_top = 0.32; 

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
        storyWidth = 0.45;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.42;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
        storyWidth = 0.55;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.52;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('1500');
    } 

    if (context.width < 1400) {
        storyWidth = 0.60;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.56;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('1400');
    } 

    if (context.width < 1200) {
        storyWidth = 0.65;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.61;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
       print('1200');
    }

    if (context.width < 1000) {
        storyWidth = 0.74;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.69;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        storyWidth = 0.90;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.84;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
        storyWidth = 0.95;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.88;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
        print('640');
    }


    if (context.width < 480) {
        storyWidth = 0.95;
        storyHeight = 0.67;

        forword_btn_top = 0.32;
        forword_btn_left = 0.85;

        backword_btn_left = 0.01;
        backword_btn_top = 0.32; 
      print('480');
    }

    // when there is no startups then show this container :
    if (startups_length <= 0) {
      mainWidget = MainHomeViewShimmer(context);
    }

    // Container with Startups :
    else {
      mainWidget = Container(
          width: context.width * storyWidth,
          height: context.height * storyHeight,
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

    return mainWidget;
  }

//////////////////////////////////////////////////
  /// EXTERNAL METHOD  :
//////////////////////////////////////////////////
  Positioned ForwordButton(BuildContext context) {
    return Positioned(
        top: context.height * forword_btn_top,
        left: context.width * forword_btn_left,
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
        top: context.height * backword_btn_top,
        left: context.width * backword_btn_left,
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
