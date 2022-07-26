import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Backend/HomeView/HomeStore.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/ExploreAlert.dart';
import 'package:be_startup/Components/HomeView/SearhBar/SearchBar.dart';
import 'package:be_startup/Components/Widgets/InvestorDialogAlert/AddInvestorDialogAlert.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeHeaderSection extends StatefulWidget {
  Function changeView;
  HomeHeaderSection({required this.changeView, Key? key}) : super(key: key);
  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
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

  var exploreStore = Get.put(ExploreCatigoryStore(), tag: 'explore_store');
  var socialAuth = Get.put(MySocialAuth(), tag: 'social_auth');
  var userStore = Get.put(UserStore(), tag: 'user_store');

  // SUBMIT DATE AND CATIGORY :
  var catigories = [];
  SubmitExploreCatigory(context) async {
    exploreStore.SetCatigory(catigories);
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
  String? selectedValue;
    //////////////////////////////////////
    /// Investor Dialog : 
    //////////////////////////////////////
    ShowDialog(context) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          alignment: Alignment.center,
          // title:  MileDialogHeading(context),
          content: SizedBox(
            width: mem_dialog_width,
            child: AddInvestorDialogAlert(
              form_type: InvestorFormType.create,
            ),
          ),
        ));
    }


  //////////////////////////////
  /// ADD INVESTOR :   
  //////////////////////////////  
  AddInvestor(context) {
    ShowDialog(context);
  }

  //////////////////////////
  // Explore Topics
  //////////////////////////
  ExploreFunction() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: ExploreCatigoryAlert());
        });
  }

  //////////////////////////////////////////////////////////
  /// Create Startup Url  :
  //////////////////////////////////////////////////////////
    CreateStatup() async {
      await ClearStartupSlideCached();
      Get.toNamed(create_business_detail_url);
    }

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

                      // Dropdown menu :   
                      DropDownMenu(context, AddInvestor, CreateStatup)
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
            ? Icon(
                Icons.bookmark,
                size: 28,
              )
            : Icon(
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
          ? Icon(
              Icons.home,
              size: 28,
            )
          : Icon(
              Icons.home_outlined,
              size: 28,
            ));
  }




////////////////////////////////////////
/// Dropdown Menu : 
////////////////////////////////////////
  Container DropDownMenu(BuildContext context, Null AddInvestor(dynamic context), Future<Null> CreateStatup()) {
    return Container(
                      width: context.width * 0.08,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        items: [
                          ...MenuItems.firstItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                          // const DropdownMenuItem<Divider>(enabled: true, child:Divider(height: 0.1,)),
                          ...MenuItems.secondItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ],
                        onChanged: (value)  async {
                          // MenuItems.onChanged(context, value as MenuItem);
                          switch (value) {
                            case MenuItems.profile:
                              widget.changeView(HomePageViews.profileView);
                              setState(() {
                                is_home_view = false;
                                is_save_view = false;
                              });
                              //Do something
                              break;
                            case MenuItems.investor:
                               await AddInvestor(context);
                              //Do something
                              break;
                            case MenuItems.startup:
                             await  CreateStatup();
                              //Do something
                              break;
                            case MenuItems.settings:
                              widget.changeView(HomePageViews.settingView);
                              setState(() {
                                is_home_view = false;
                                is_save_view = false;
                              });
                              //Do something
                              break;
                            case MenuItems.logout:
                              //Do something
                              await  socialAuth.Logout();
                              break;
                          }
                        },
                        openWithLongPress: true,
                        customItemsHeight: 8,
                        customButton: Container(
                          margin: EdgeInsets.only(top: context.height * 0.01),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(temp_avtar_image, scale: 1),
                          ),
                        ),
                      )),
                    );
  }

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
              icon: Icon(
                Icons.wb_incandescent_sharp,
                size: 15,
              ),
              label: Text('Explore')),
        ));
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    profile,
    investor,
    startup,
    settings
  ];
  static const List<MenuItem> secondItems = [logout];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);
  static const investor =
      MenuItem(text: 'investor', icon: Icons.add_box_outlined);
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
