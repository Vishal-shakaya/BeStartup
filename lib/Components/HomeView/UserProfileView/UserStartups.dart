import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserStoreName.dart';
import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/MainUserStartupsShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class HomeViewUserStartups extends StatefulWidget {
  HomeViewUserStartups({Key? key}) : super(key: key);

  @override
  State<HomeViewUserStartups> createState() => _HomeViewUserStartupsState();
}

class _HomeViewUserStartupsState extends State<HomeViewUserStartups> {
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

  int value = 0;
  bool positive = false;

  double ind_size_height = 22;
  double ind_size_width = 22;

  double indicator_height = 22; 
  double indi_icon_size = 20; 

  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    user = FirebaseAuth.instance.currentUser;
    usertype = await userState.GetUserType();
    user_id = user?.uid;

    var resp;

    if (usertype != null) {
      print('user Type $usertype');
      ///////////////////////////////////////////
      /// If user is Investor :
      ///////////////////////////////////////////
      if (usertype == UserStoreName.investor) {
        resp = await homeviewConnector.FetchLikeStartups(user_id: user_id);
      }

      /////////////////////////////////////////////////////////////
      // If user type founder then check selected menu type:
      // 1. if menu === intrested then show intrested startups :
      // 2. menu == my_startup show his startups: [ Default ] :
      /////////////////////////////////////////////////////////////
      if (usertype == UserStoreName.founder) {
        if (menuType == FounderStartupMenu.my_startup) {
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
      user_id = resp['data']['user_id'];
      startup_name = resp['data']['startup_name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    startup_sec_width = 0.45;
    startup_sec_height = 0.42;
    startup_cont_height = 0.45;

    back_button_flex = 10;
    forword_button_flex = 10;
    startup_flex = 80;

    switch_btn_top_margin = 0.04;
    switch_btn_right_margin = 0.70;

    switch_btn_fontSize = 14;
    switch_btn_width = 100;

    back_btn_left_margin = 20;
    forword_btn_right_margin = 20;

    spacer = 0.04;

    ind_size_height = 22;
    ind_size_width = 22;

    indicator_height = 22; 

    indi_icon_size = 20; 
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      startup_sec_width = 0.45;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 10;
      forword_button_flex = 10;
      startup_flex = 80;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.70;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 20;
      forword_btn_right_margin = 20;

      ind_size_height = 22;
      ind_size_width = 22;

      indicator_height = 22;

      spacer = 0.04;
      indi_icon_size = 20; 

      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      startup_sec_width = 0.45;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;
      print('1200');
    }

    if (context.width < 1000) {
      startup_sec_width = 0.65;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 15;
      forword_button_flex = 15;
      startup_flex = 70;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.60;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 0;
      forword_btn_right_margin = 0;

      spacer = 0.04;

      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      startup_sec_width = 0.80;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 15;
      forword_button_flex = 15;
      startup_flex = 70;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.60;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 0;
      forword_btn_right_margin = 0;

      spacer = 0.04;
      print('800');
    }
    if (context.width < 700) {
      startup_sec_width = 0.80;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 15;
      forword_button_flex = 15;
      startup_flex = 70;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.52;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 0;
      forword_btn_right_margin = 0;

      spacer = 0.04;
      print('700');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      startup_sec_width = 0.90;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 15;
      forword_button_flex = 15;
      startup_flex = 70;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.39;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 0;
      forword_btn_right_margin = 0;

      ind_size_height = 18;
      ind_size_width = 18;

      indicator_height = 18;
      indi_icon_size = 17; 

      spacer = 0.02;
      print('640');
    }



    // PHONE:
    if (context.width < 480) {
      startup_sec_width = 1;
      startup_sec_height = 0.42;
      startup_cont_height = 0.45;

      back_button_flex = 15;
      forword_button_flex = 15;
      startup_flex = 70;

      switch_btn_top_margin = 0.04;
      switch_btn_right_margin = 0.38;

      switch_btn_fontSize = 14;
      switch_btn_width = 100;

      back_btn_left_margin = 0;
      forword_btn_right_margin = 0;

      ind_size_height = 16;
      ind_size_width = 15;

      indicator_height = 16;
      indi_icon_size = 16; 

      spacer = 0.02;
      print('480');
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

  ////////////////////////////////////////////////
  /// MainMethod :
  ////////////////////////////////////////////////
  MainMethod(BuildContext context) {
    var mainWidget;

    if (startups_length <= 0) {
      mainWidget = MainUserStartupsShimmer(context);
    } else {
      mainWidget = SingleChildScrollView(
        child: Column(
          children: [
            // Swith Menu button only show if user is founder :
            usertype == UserType.founder
                ?
                // Swith Menu Switcher :
                StartupSwitcherButton(context)

                // Spacer :
                : Spacer(context),

            // Main Startup Container :
            StartupMethod(context),
          ],
        ),
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
                                  user_id: user_id[itemIndex],
                                ),
                                ProfileStoryHeading(
                                  startup_name: startup_name[itemIndex],
                                ),
                                ProfileInfoChart(
                                  user_id: user_id[itemIndex],
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

////////////////////////////////////////////
  /// Startup Switcher button :
  /// 1 Switch interested to own startup:
  /// for founder :
////////////////////////////////////////////
  Container StartupSwitcherButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * switch_btn_top_margin,
        right: context.height * switch_btn_right_margin,
      ),
      child: AnimatedToggleSwitch<bool>.dual(
        current: positive,
        first: false,
        second: true,
        dif: 10.0,
        borderColor: Colors.transparent,
        borderWidth: 5.0,
        height: indicator_height,
        indicatorSize: Size(ind_size_width, ind_size_height),
       
        boxShadow: [
       
          BoxShadow(
            color: shadow_color1,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0.1),
          ),
        ],
    
        onChanged: (b) async {
          setState(() => positive = b);
        },
    
        colorBuilder: (b) => b ? Colors.transparent : Colors.transparent,
       
        iconBuilder: (value) => value
            ?  Icon(
                Icons.home,
                size: indi_icon_size,
                color: Colors.blueAccent,
              )
            :  Icon(
                CupertinoIcons.heart_fill,
                size: indi_icon_size,
                color: Colors.redAccent,
              ),
      ),

      //  FlipCard(
      //   onFlipDone: (done) {
      //     if (done) {
      //       if (menuType == FounderStartupMenu.intrested) {
      //         menuType = FounderStartupMenu.my_startup;
      //         frontText = 'SUP';
      //         backText = 'Interested';
      //       } else {
      //         menuType = FounderStartupMenu.intrested;
      //         frontText = 'Interested';
      //         backText = 'SUP';
      //       }

      //       setState(() {});
      //     }
      //   },
      //   direction: FlipDirection.VERTICAL,
      //   alignment: Alignment.topRight,
      //   front: StartupMenuSwitcher(title: '$frontText'),
      //   back: StartupMenuSwitcher(title: '$backText'),
      // ),
    );
  }

////////////////////////////////
  /// Startup Siwther Text:
////////////////////////////////
  SizedBox StartupMenuSwitcher({title, func}) {
    return SizedBox(
      width: switch_btn_width,
      child: Container(
        width: switch_btn_width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: shimmer_base_color)),
        child: AutoSizeText.rich(
          TextSpan(
              text: '$title',
              style: TextStyle(
                  fontSize: switch_btn_fontSize,
                  fontWeight: FontWeight.bold,
                  color: light_color_type2,
                  letterSpacing: 1.3)),
        ),
      ),
    );
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

  // Spacer :
  Container Spacer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * spacer,
      ),
    );
  }
}
