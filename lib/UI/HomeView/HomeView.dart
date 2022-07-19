import 'package:be_startup/Components/HomeView/HomeHeaderSection.dart';
import 'package:be_startup/Components/HomeView/SaveStories/StoryListView.dart';
import 'package:be_startup/Components/HomeView/SettingsView/UserSettings.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryHandler.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/UserProfileView.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var view = HomePageViews.storyView;

  SetHomeView(changeView) {
    if (changeView == HomePageViews.profileView) {
      setState(() {
        view = HomePageViews.profileView;
      });
    }

    if (changeView == HomePageViews.safeStory) {
      setState(() {
        view = HomePageViews.safeStory;
      });
    }

    if (changeView == HomePageViews.storyView) {
      setState(() {
        view = HomePageViews.storyView;
      });
    }

    if (changeView == HomePageViews.settingView) {
      setState(() {
        view = HomePageViews.settingView;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;
    double page_height = 0.90;
    dynamic mainViewWidget = StoryListView();

    ///////////////////////////////////////////
    /// ASSIGNING VIEW  :
    /// DEFAULT VIEW IS STORYVIEW :
    ///////////////////////////////////////////
    if (view == HomePageViews.profileView) {
      mainViewWidget = UserProfileView();
    }

    if (view == HomePageViews.safeStory) {
      mainViewWidget = StoryListView(
        is_save_page: true,
      );
    }

    if (view == HomePageViews.storyView) {
      mainViewWidget = StoryListView(
        is_save_page: false,
      );
    }

    if (view == HomePageViews.settingView) {
      mainViewWidget = UserSettings();
    }

    return Container(
        width: page_width,
        height: page_height,
        margin: EdgeInsets.only(top: context.height * 0.02),
        child: Column(
          children: [
            // HEADER SECTION :
            // 1 EXPLORE AND SEARCH BAR :
            SizedBox(
              height: context.height * 0.04,
            ),
            HomeHeaderSection(changeView: SetHomeView),
            SizedBox(
              height: context.height * 0.06,
            ),

            mainViewWidget
          ],
        ));
  }
}
