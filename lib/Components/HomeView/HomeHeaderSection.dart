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

  // Explore Section
  double explore_btn_width = 90;

  double explore_btn_height = 30;

  double explore_icon_fontSize = 15;

  double explore_text_fontSize = 13;

  double explore_cont_top_margin = 24;

  double explore_cont_right_margin = 0.05;

  // Menu Bar :
  double mem_dialog_width = 900;

  double menu_section_left_margin = 0.07;

  double menu_section_height = 0.04;

  double menu_section_width = 0.14;

  double profile_menu_width = 51;

  double profile_menu_height = 51;

  double profile_menu_radiud = 30;

  double profile_menu_top_margin = 12;

  double dropdown_menu_font_and_iconSize = 22;

  double search_and_menu_spacer = 0.20;

  double menu_section_padding = 5;

  double home_and_save_icon_fontSize = 28;

  double home_and_save_icon_top_margin = 05;

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

    Widget exploreButton = ExploreButton(context, ExploreFunction);

    //////////////////////////////////////
    /// INVESTOR ITEMS :
    //////////////////////////////////////
    // SwitchInvestorToFounder() async {
    //   print('Switch to founder ');
    // }

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////

    header_sec_width = 1;
    header_sec_height = 0.10;

    con_button_width = 80;
    con_button_height = 40;
    con_btn_top_margin = 40;

    // Explore Section
    explore_btn_width = 90;

    explore_btn_height = 30;

    explore_icon_fontSize = 15;

    explore_text_fontSize = 13;

    explore_cont_top_margin = 24;

    explore_cont_right_margin = 0.05;

    // Menu Bar :
    mem_dialog_width = 900;

    menu_section_left_margin = 0.07;

    menu_section_height = 0.04;

    menu_section_width = 0.14;

    profile_menu_width = 51;

    profile_menu_height = 51;

    profile_menu_radiud = 30;

    profile_menu_top_margin = 12;

    dropdown_menu_font_and_iconSize = 22;

    search_and_menu_spacer = 0.20;

    menu_section_padding = 5;

    home_and_save_icon_fontSize = 28;

    home_and_save_icon_top_margin = 5;

    // DEFAULT :
    if (context.width > 1600) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.05;

      // Menu Bar :
      search_and_menu_spacer = 0.20;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.07;

      menu_section_height = 0.04;

      menu_section_width = 0.14;

      menu_section_padding = 5;

      profile_menu_width = 51;

      profile_menu_height = 51;

      profile_menu_radiud = 30;

      profile_menu_top_margin = 12;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 28;

      home_and_save_icon_top_margin = 5;

      print('Greator then 1600');
    }

    if (context.width < 1600) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.05;

      // Menu Bar :
      search_and_menu_spacer = 0.22;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.07;

      menu_section_height = 0.05;

      menu_section_width = 0.17;

      menu_section_padding = 5;

      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      profile_menu_top_margin = 12;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 27;

      home_and_save_icon_top_margin = 5;

      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.05;

      // Menu Bar :
      search_and_menu_spacer = 0.28;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.07;

      menu_section_height = 0.06;

      menu_section_width = 0.19;

      menu_section_padding = 5;

      profile_menu_radiud = 30;

      profile_menu_width = 48;

      profile_menu_height = 48;

      profile_menu_top_margin = 12;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 27;

      home_and_save_icon_top_margin = 10;
      print('1200');
    }

    if (context.width < 1100) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.05;

      // Menu Bar :
      search_and_menu_spacer = 0.28;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.06;

      menu_section_height = 0.06;

      menu_section_width = 0.20;

      menu_section_padding = 5;

      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      profile_menu_top_margin = 5;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 27;

      home_and_save_icon_top_margin = 10;
      print('1100');
    }

    if (context.width < 1000) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.08;

      // Menu Bar :
      search_and_menu_spacer = 0.33;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.06;

      menu_section_height = 0.07;

      menu_section_width = 0.22;

      menu_section_padding = 5;

      profile_menu_radiud = 35;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 27;

      profile_menu_top_margin = 5;

      home_and_save_icon_top_margin = 4;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.08;

      // Menu Bar :
      search_and_menu_spacer = 0.35;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.06;

      menu_section_height = 0.08;

      menu_section_width = 0.24;

      menu_section_padding = 5;

      profile_menu_radiud = 30;

      profile_menu_width = 40;

      profile_menu_height = 40;

      profile_menu_top_margin = 0;

      dropdown_menu_font_and_iconSize = 20;

      home_and_save_icon_fontSize = 25;

      home_and_save_icon_top_margin = 0;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 700) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 13;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.04;

      // Menu Bar :
      search_and_menu_spacer = 0.38;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.06;

      menu_section_height = 0.08;

      menu_section_width = 0.28;

      menu_section_padding = 5;

      profile_menu_radiud = 30;

      profile_menu_width = 40;

      profile_menu_height = 40;

      profile_menu_top_margin = 5;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 27;

      home_and_save_icon_top_margin = 0;
      print('700');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 12;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.08;

      // Menu Bar :
      search_and_menu_spacer = 0.35;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.06;

      menu_section_height = 0.10;

      menu_section_width = 0.29;

      menu_section_padding = 5;

      profile_menu_radiud = 30;

      profile_menu_width = 40;

      profile_menu_height = 40;

      profile_menu_top_margin = 5;

      dropdown_menu_font_and_iconSize = 22;

      home_and_save_icon_fontSize = 25;

      home_and_save_icon_top_margin = 0;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      header_sec_width = 1;
      header_sec_height = 0.10;

      con_button_width = 80;
      con_button_height = 40;
      con_btn_top_margin = 40;

      // Explore Section
      explore_btn_width = 90;

      explore_btn_height = 30;

      explore_icon_fontSize = 15;

      explore_text_fontSize = 12;

      explore_cont_top_margin = 24;

      explore_cont_right_margin = 0.08;

      // Menu Bar :
      search_and_menu_spacer = 0.35;

      mem_dialog_width = 900;

      menu_section_left_margin = 0.04;

      menu_section_height = 1;

      menu_section_width = 0.35;

      menu_section_padding = 1;

      profile_menu_radiud = 30;

      profile_menu_width = 35;

      profile_menu_height = 30;

      profile_menu_top_margin = 2;

      dropdown_menu_font_and_iconSize = 20;

      home_and_save_icon_fontSize = 22;

      home_and_save_icon_top_margin = 2;

      exploreButton = Container();
      print('480');
    }

    return Container(
      width: context.width * header_sec_width,
      height: context.height * header_sec_height,
      // color: my_theme_background_color,

      child: Card(
        elevation: 1,
        shadowColor: Colors.grey,
        child: Container(
          height: context.height * header_sec_height,
          color: my_theme_background_color,
          alignment: Alignment.topCenter,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey.shade300)
          // ),

          // 1 ADD EXPLORE BUTTON FOR SELECT CATIGORIES :
          // 2 ADD SEARCH BAR FOR SEARCH SEPCIFIC STARTUP [ BY CEO NAME , STARTUP NAME ] :

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show Explore Button only
              // if screen size greator then 450; 
              exploreButton,

              // Space :
              Container(
                width: context.width * search_and_menu_spacer,
              ),

              // Menu Icon :
              Container(
                  margin: EdgeInsets.only(
                    left: context.width * menu_section_left_margin,
                  ),
                  height: context.width * menu_section_height,
                  width: context.width * menu_section_width,
                  color: my_theme_background_color,
                  padding: EdgeInsets.all(menu_section_padding),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Container SaveStartupLink() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: IconButton(
          onPressed: () {
            setState(() {
              is_home_view = false;
              is_save_view = true;
            });
            widget.changeView(HomePageViews.safeStory);
          },
          icon: is_save_view
              ? Icon(
                  Icons.bookmark,
                  size: home_and_save_icon_fontSize,
                )
              : Icon(
                  Icons.bookmark_border_outlined,
                  size: home_and_save_icon_fontSize,
                )),
    );
  }

  Container StartupViewLink() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: IconButton(
          onPressed: () {
            setState(() {
              is_home_view = true;
              is_save_view = false;
            });
            widget.changeView(HomePageViews.storyView);
          },
          icon: is_home_view
              ? Icon(
                  Icons.home,
                  size: home_and_save_icon_fontSize,
                )
              : Icon(
                  Icons.home_outlined,
                  size: home_and_save_icon_fontSize,
                )),
    );
  }

//////////////////////////////////////////
  // Explore Button :
//////////////////////////////////////////
  Container ExploreButton(BuildContext context, Null ExploreFunction()) {
    return Container(
      margin: EdgeInsets.only(
          top: 0, right: context.width * explore_cont_right_margin),
      child: Card(
        elevation: 3,
        shadowColor: my_theme_shadow_color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        
        child: Container(
          width: explore_btn_width,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: my_theme_shadow_color)),
          child: TextButton.icon(
              onPressed: () {
                ExploreFunction();
              },
              icon: Icon(
                Icons.wb_incandescent_sharp,
                size: explore_icon_fontSize,
                color: my_theme_icon_color,
              ),
              label: Text(
                'Explore',
                style: TextStyle(
                    color: my_theme_icon_color,
                    fontSize: explore_text_fontSize),
              )),
        ),
      ),
    );
  }

  // Container RoundedExploreButton(BuildContext context, Null ExploreFunction()) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 24, right: context.width * 0.02),

  //     child: Card(
  //       elevation: 4,
  //       shadowColor: my_theme_shadow_color,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       child: CircleAvatar(
  //         radius: 15,
  //         child: IconButton(
  //             onPressed: () {
  //               ExploreFunction();
  //             },
  //             color: Colors.transparent,
  //             icon: Icon(
  //               Icons.wb_incandescent_sharp,
  //               size: 14,
  //               color: my_theme_icon_color,
  //             )),
  //       ),
  //     ),
  //   );
  // }

////////////////////////////////////////
  ///  Founder Dropdown Menu :
////////////////////////////////////////
  Container FounderDropDownMenu(
      {BuildContext? context, CreateStatup, is_investor}) {
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
          margin: EdgeInsets.only(top: 0),
          child: CircleAvatar(
            // backgroundColor: Colors.orange.shade100,
            radius: profile_menu_radiud,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.profile_image,
                fit: BoxFit.cover,
                width: profile_menu_width,
                height: profile_menu_height,
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
                  radius: profile_menu_radiud,

                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.profile_image,
                      fit: BoxFit.cover,
                      width: profile_menu_width,
                      height: profile_menu_height,
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
          color: input_text_color,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: input_text_color,
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
  static double width=100; 
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
          color: input_text_color,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: input_text_color,
          ),
        ),
      ],
    );
  }
}
