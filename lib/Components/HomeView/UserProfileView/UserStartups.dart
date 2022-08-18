import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Backend/Keys/CacheStoreKeys/CacheStoreKeys.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/MainUserStartupsShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeViewUserStartups extends StatefulWidget {
  HomeViewUserStartups({Key? key}) : super(key: key);

  @override
  State<HomeViewUserStartups> createState() => _HomeViewUserStartupsState();
}

class _HomeViewUserStartupsState extends State<HomeViewUserStartups> {
  var homeviewConnector = Get.put(HomeViewConnector());
  CarouselController buttonCarouselController = CarouselController();

  var startups_length = 0;

  var startup_name = [];

  var startup_ids = [];

  var usertype;
  var user_id;
  User? user;

  var menuType = FounderStartupMenu.my_startup;
  var frontText = 'My SUP';
  var backText = 'Interested';

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    user = FirebaseAuth.instance.currentUser;
    usertype = await getMycachedData(key: getUserTypeKey);
    user_id = user?.uid;

    var resp;

    if (usertype != null) {

      ///////////////////////////////////////////
      /// If user is Investor : 
      ///////////////////////////////////////////
      if (usertype == 'investor') {
        resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
      }

      /////////////////////////////////////////////////////////////
      // If user type founder then check selected menu type:
      // 1. if menu === intrested then show intrested startups :
      // 2. menu == my_startup show his startups: [ Default ] :
      /////////////////////////////////////////////////////////////
      if (usertype == 'founder') {
        if (menuType == FounderStartupMenu.my_startup) {
          resp = await homeviewConnector.FetchUserStartups(user_id: user_id);
        } else {
          resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
        }
      }
    }

    // Response Handler : 
    if (resp['response']) {
      startups_length = resp['data']['startup_len'];
      startup_ids = resp['data']['startup_ids'];
      startup_name = resp['data']['startup_name'];
    }

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
            return MainUserStartupsShimmer(context);
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  ////////////////////////////////////////////////
  /// MainMethod :
  ////////////////////////////////////////////////
  MainMethod(BuildContext context) {
    var mainWidget;

    if (startups_length <= 0) {
      mainWidget = MainUserStartupsShimmer(context);
    } else {
      mainWidget = Column(
        children: [
          // Swith Menu button only show if user is founder :
          usertype == 'founder'
              ?
              // Swith Menu Switcher :
              StartupSwitcherButton(context)

              // Spacer :
              : Spacer(context),

          // Main Startup Container :
          StartupMethod(context),
        ],
      );
    }

    return mainWidget;
  }

//////////////////////////////////////////////////
  /// EXTERNAL METHOD  :
//////////////////////////////////////////////////

/////////////////////////////////////////
  ///  Container main startup Container
  ///  Has coursel and other method:
  ///  1. thumbnail :
  ///  2. startup info : moree..
/////////////////////////////////////////
  Container StartupMethod(BuildContext context) {
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

////////////////////////////////////////////
  /// Startup Switcher button :
  /// 1 Switch interested to own startup:
  /// for founder :
////////////////////////////////////////////
  Container StartupSwitcherButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * 0.04,
        right: context.height * 0.60,
      ),
      child: FlipCard(
        onFlipDone: (done) {
          if (done) {
            if (menuType == FounderStartupMenu.intrested) {
              menuType = FounderStartupMenu.my_startup;
              frontText = 'My SUP';
              backText = 'Interested';
            } else {
              menuType = FounderStartupMenu.intrested;
              frontText = 'Interested';
              backText = 'My SUP';
            }

            setState(() {});
          }
        },
        direction: FlipDirection.VERTICAL,
        alignment: Alignment.topRight,
        front: StartupMenuSwitcher(title: '$frontText'),
        back: StartupMenuSwitcher(title: '$backText'),
      ),
    );
  }

////////////////////////////////
  /// Startup Siwther Text:
////////////////////////////////
  SizedBox StartupMenuSwitcher({title, func}) {
    return SizedBox(
      width: 100,
      child: Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: shimmer_base_color)),
        child: AutoSizeText.rich(
          TextSpan(
              text: '$title',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: light_color_type2,
                  letterSpacing: 1.3)),
        ),
      ),
    );
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

  // Spacer :
  Container Spacer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * 0.04,
      ),
    );
  }
}
