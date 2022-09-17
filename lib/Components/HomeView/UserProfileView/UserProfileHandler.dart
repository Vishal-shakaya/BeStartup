import 'package:be_startup/Components/HomeView/UserProfileView/UserProfile.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/UserStartups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({Key? key}) : super(key: key);

  double profile_width = 0.50;
  double profile_height = 0.85;

  @override
  Widget build(BuildContext context) {
    profile_width = 0.50;
    profile_height = 0.85;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      profile_width = 0.50;
      profile_height = 0.85;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      profile_width = 0.60;
      print('1500');
    }

    if (context.width < 1200) {
      profile_width = 0.70;
      print('1200');
    }

    if (context.width < 1000) {
      profile_width = 0.85;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      profile_width = 0.90;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      profile_width = 1;
      print('480');
    }

    return Container(
      width: context.width * profile_width,
      height: context.height * profile_height,
      child: Card(
          elevation: 10,
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // User Profile View
            HomeViewUserProfile(),

            // Founder Startup List
            HomeViewUserStartups()
          ])),
    );
  }
}
