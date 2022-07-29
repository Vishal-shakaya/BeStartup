import 'package:be_startup/Components/HomeView/UserProfileView/UserProfile.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/UserStartups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
    width: context.width * 0.50,
    height: context.height * 0.74,
      child: Card(
          elevation: 10,
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [
            // User Profile View
            HomeViewUserProfile(),

            // Founder Startup List
            HomeViewUserStartups()

          ])),
    );
  }
}
