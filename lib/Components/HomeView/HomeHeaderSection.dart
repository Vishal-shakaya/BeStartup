import 'dart:convert';

import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/ExploreAlert.dart';
import 'package:be_startup/Utils/Colors.dart';

import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeHeaderSection extends StatefulWidget {
  Function changeView;
  var usertype;
  var profile_image;

  HomeHeaderSection(
      {required this.profile_image,
      required this.changeView,
      required this.usertype,
      Key? key})
      : super(key: key);
  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  var exploreStore = Get.put(ExploreCatigoryStore());
  var socialAuth = Get.put(
    MySocialAuth(),
  );
  var userStore = Get.put(UserStore());
  var my_context = Get.context;

  double header_sec_width = 1;
  double header_sec_height = 0.10;

  double con_button_width = 80;
  double con_button_height = 40;
  double con_btn_top_margin = 40;

  double mem_dialog_width = 900;

  SfRangeValues values =
      SfRangeValues(DateTime(2000, 01, 01), DateTime(2022, 01, 01));

  bool is_home_view = true;
  bool is_save_view = false;

  // SUBMIT DATE AND CATIGORY :
  var catigories = [];
  SubmitExploreCatigory(context) async {
    exploreStore.SetCatigory(catigories);
    Navigator.of(context).pop();
  }

  LogoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      // await socialAuth.Logout();
    } catch (er) {
      print('Logout Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;

    //////////////////////////
    // Explore Topics
    //////////////////////////
    ExploreFunction() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: ExploreCatigoryAlert(
              changeView: widget.changeView,
            ));
          });
    }

    //////////////////////////////////////////////////////////
    /// Create Startup Url  :
    //////////////////////////////////////////////////////////
    CreateStatup() async {
      await ClearCachedData();
      Get.toNamed(create_business_detail_url);
    }

    //////////////////////////////////////
    /// INVESTOR ITEMS :
    //////////////////////////////////////
    // SwitchInvestorToFounder() async {
    //   print('Switch to founder ');
    // }

    return Container(
      width: context.width * header_sec_width,
      height: context.height * header_sec_height,
      child: Card(
        elevation: 1,
        shadowColor: Colors.grey,
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey.shade300)
          // ),
          alignment: Alignment.topCenter,
          // 1 ADD EXPLORE BUTTON FOR SELECT CATIGORIES :
          // 2 ADD SEARCH BAR FOR SEARCH SEPCIFIC STARTUP [ BY CEO NAME , STARTUP NAME ] :
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              // Explore Menu :
              ExploreButton(context, ExploreFunction),

              Container(
                width: context.width * 0.20,
              ),

              // Menu Icon :
              Container(
                  margin: EdgeInsets.only(
                    left: context.width * 0.07,
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  height: context.width * 0.04,
                  width: context.width * 0.14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Home Button :
                      StartupViewLink(),

                      // Save Startup Button:
                      SaveStartupLink(),

                      widget.usertype == UserType.investor
                          ? InvestorDropDownMenu(
                              context: context,
                            )
                          : FounderDropDownMenu(
                              context: context,
                              CreateStatup: CreateStatup,
                            ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

////////////////////////////////////////
  /// External Methods  :
////////////////////////////////////////

  IconButton SaveStartupLink() {
    return IconButton(
        onPressed: () {
          setState(() {
            is_home_view = false;
            is_save_view = true;
          });
          widget.changeView(HomePageViews.safeStory);
        },
        icon: is_save_view
            ? const Icon(
                Icons.bookmark,
                size: 28,
              )
            : const Icon(
                Icons.bookmark_border_outlined,
                size: 28,
              ));
  }

  IconButton StartupViewLink() {
    return IconButton(
        onPressed: () {
          setState(() {
            is_home_view = true;
            is_save_view = false;
          });
          widget.changeView(HomePageViews.storyView);
        },
        icon: is_home_view
            ? const Icon(
                Icons.home,
                size: 28,
              )
            : const Icon(
                Icons.home_outlined,
                size: 28,
              ));
  }

//////////////////////////////////////////
  // Explore Button :
//////////////////////////////////////////
  Container ExploreButton(BuildContext context, Null ExploreFunction()) {
    return Container(
        margin: EdgeInsets.only(
            top: context.height * 0.03, right: context.width * 0.02),
        child: Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                ExploreFunction();
              },
              icon: const Icon(
                Icons.wb_incandescent_sharp,
                size: 15,
              ),
              label: Text('Explore')),
        ));
  }

////////////////////////////////////////
  ///  Founder Dropdown Menu :
////////////////////////////////////////
  Container FounderDropDownMenu(
      {BuildContext? context,  CreateStatup, is_investor}) {
    return Container(
      width: context!.width * 0.08,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        items: [
          ...FounderMenuItems.firstItems.map((item) {
            return DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItems.buildItem(item),
            );
          }),
          // const DropdownMenuItem<Divider>(enabled: true, child:Divider(height: 0.1,)),
          ...FounderMenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) async {
          // FounderMenuItems.onChanged(context, value as MenuItem);
          switch (value) {
            case FounderMenuItems.profile:
              await widget.changeView(HomePageViews.profileView);
              setState(() {
                is_home_view = false;
                is_save_view = false;
              });
              break;

            // case FounderMenuItems.investor:
            //    await AddInvestor(context);
            //   break;

            case FounderMenuItems.startup:
              await CreateStatup();
              break;

            case FounderMenuItems.settings:
              await widget.changeView(HomePageViews.settingView);

              setState(() {
                is_home_view = false;
                is_save_view = false;
              });
              break;

            case FounderMenuItems.logout:
              await socialAuth.Logout();
              break;
          }
        },
        openWithLongPress: true,
        customItemsHeight: 8,
        customButton: Container(
          margin: EdgeInsets.only(top: context.height * 0.01),
          child: CircleAvatar(
            // backgroundColor: Colors.orange.shade100,
            radius: 30,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.profile_image,
                fit: BoxFit.cover,
                width: 51,
                height: 51,
              ),
            ),
          ),
        ),
      )),
    );
  }

////////////////////////////////////////
  ///  Founder Dropdown Menu :
////////////////////////////////////////
  Container InvestorDropDownMenu(
      {BuildContext? context, AddInvestor, CreateStatup, is_investor}) {
    return Container(
        width: context!.width * 0.08,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
              items: [
                ...InvestorMenuItems.firstItems.map((item) {
                  return DropdownMenuItem<MenuItem>(
                    value: item,
                    child: InvestorMenuItems.buildItem(item),
                  );
                }),
                ...InvestorMenuItems.secondItems.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: InvestorMenuItems.buildItem(item),
                  ),
                ),
              ],
              onChanged: (value) async {
                switch (value) {
                  case FounderMenuItems.profile:
                    await widget.changeView(HomePageViews.profileView);
                    setState(() {
                      is_home_view = false;
                      is_save_view = false;
                    });
                    break;

                  case FounderMenuItems.settings:
                    await widget.changeView(HomePageViews.settingView);
                    setState(() {
                      is_home_view = false;
                      is_save_view = false;
                    });
                    break;

                  case FounderMenuItems.logout:
                    await LogoutUser();
                    break;
                }
              },
              openWithLongPress: true,
              customItemsHeight: 8,
              customButton: Container(
                margin: EdgeInsets.only(top: context.height * 0.01),
                child: CircleAvatar(
                  // backgroundColor: Colors.orange.shade100,
                  radius: 30,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.profile_image,
                      fit: BoxFit.cover,
                      width: 51,
                      height: 51,
                    ),
                  ),
                ),
              )),
        ));
  }
}

//////////////////////////
/// Menu Item Class :
//////////////////////////
class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

////////////////////////////////////
/// Founder Menu Items
////////////////////////////////////
class FounderMenuItems {
  static const List<MenuItem> firstItems = [
    profile,
    // investor,
    startup,
    settings,
  ];

  static const List<MenuItem> secondItems = [logout];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);

  static const startup =
      MenuItem(text: 'startup', icon: Icons.add_box_outlined);

  static const settings = MenuItem(text: 'settings', icon: Icons.settings);

  static const logout = MenuItem(text: 'logout', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: light_color_type2,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: light_color_type2,
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////
/// Investor Menu Items
////////////////////////////////////
class InvestorMenuItems {
  static const List<MenuItem> firstItems = [
    profile,
    // investor,
    settings,
  ];

  static const List<MenuItem> secondItems = [logout];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);

  static const settings = MenuItem(text: 'settings', icon: Icons.settings);

  static const logout = MenuItem(text: 'logout', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: light_color_type2,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: light_color_type2,
          ),
        ),
      ],
    );
  }
}
