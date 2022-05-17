import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileInfoChart.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/ProfileStoryHeading.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/Thumbnail.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
class UserProfileView extends StatefulWidget {
  UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  double header_section_height = 0.67; 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: Column(
        children: [
            ProfileHeader(),
            Container(
            width: context.width*0.45,
            height:context.height*0.45,
            child: Swiper(
            // containerHeight: 200,
            // containerWidth: 200,
            scrollDirection : Axis.horizontal,
            itemCount: 3,
            pagination: SwiperPagination(
              builder: SwiperPagination.rect
            ),
            control: SwiperControl(
              color: Colors.blueGrey.shade100, 
              padding: EdgeInsets.only(top:context.height*0.04, right: 8.0), 
            ),

            // CONTENT SECTION : 
            itemBuilder: ((context, index) {
              return Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top:context.height*0.03),
                child: SizedBox(
                  height:context.height*0.43,
                  child: Stack(
                    children: [
                      ProfileStoryThumbnail(),
                      ProfileStoryHeading(),
                      ProfileInfoChart()
                    ],
                  ),
                ),
              );
            }),
          ))

        ])
      );
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
        foregroundImage: NetworkImage(profile_image),
      )),
    );
  }

  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: 'vishal shakaya',
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
          text: '@Founder / CEO',
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
              text: 'shakayavishal007@gmail.com',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}