import 'package:be_startup/Components/HomeView/UserProfileView/UserProfile.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/UserStartups.dart';
import 'package:flutter/material.dart';


class UserProfileView extends StatelessWidget {
  UserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(children: [

          // User Profile View
          HomeViewUserProfile(),

          // Founder Startup List
          HomeViewUserStartups()

        ]));
  }
}
