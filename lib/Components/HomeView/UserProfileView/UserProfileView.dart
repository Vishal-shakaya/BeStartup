import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  CarouselController buttonCarouselController = CarouselController();
  var startups_length=2;

  double header_section_height = 0.67;
  var user_image;
  var user_position;
  var user_email;
  var user_phoneno;
  var user_name;
  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    await Future.delayed(Duration(seconds: 2));
    user_image = await getUserProfileImage;
    user_position = await getUserPosition;
    user_email = await getuserEmail;
    user_phoneno = await getUserPhoneno;
    user_name = await getUserName;
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
              child: CustomShimmer(
                text: 'Loading profile',
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

//////////////////////////////////////
  /// MAIN METHOD :
//////////////////////////////////////
  Card MainMethod(BuildContext context) {
    return Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(children: [
          ProfileHeader(),

          
          ////////////////////////////////
          // Founder Startup List 
          ////////////////////////////////
          Container(
              width: context.width * 0.45,
              height: context.height * 0.45,
              child:  CarouselSlider.builder(
                carouselController: buttonCarouselController,
                itemCount: startups_length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: context.height * 0.03),
                    child: SizedBox(
                      height: context.height * 0.43,
                      child: Stack(
                        children: [
                          ProfileStoryThumbnail(),
                          ProfileStoryHeading(),
                          ProfileInfoChart()
                        ],
                      ),
                    ),
                  )
                  );
                },
                options: CarouselOptions(
                    height: context.height * 0.67, viewportFraction: 1)))
        ]));
  }

  Column ProfileHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileImage(),

        // POSITION:
        SizedBox(
          width: 200,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              MemName(),

              SizedBox(
                height: 5,
              ),
              // CONTACT EMAIL ADDRESS :
              MemPosition(),

              MemContact()
            ],
          ),
        ),
      ],
    );
  }

  Card ProfileImage() {
    return Card(
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(user_image),
      )),
    );
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: user_name,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16))
    ])));
  }

  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: '@$user_position',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12))
    ])));
  }

  Container MemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade800,
            size: 16,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: user_email.toString().capitalizeFirst,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}
