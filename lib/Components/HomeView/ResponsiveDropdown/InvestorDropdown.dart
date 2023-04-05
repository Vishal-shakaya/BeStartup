import 'package:be_startup/Components/HomeView/ResponsiveDropdown/FounderDropdown.dart';
import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:wiredash/wiredash.dart';

class InvestorCustomDropdown extends StatefulWidget {
  var SwitchToFounder;
  var CreateStatup;
  var profile_image;
  var SwitchSettingView;

  InvestorCustomDropdown({
      required this.CreateStatup,
      required this.SwitchToFounder,
      required this.profile_image,
      required this.SwitchSettingView,
      Key? key})
      : super(key: key);

  @override
  State<InvestorCustomDropdown> createState() => _InvestorCustomDropdownState();
}

class _InvestorCustomDropdownState extends State<InvestorCustomDropdown> {
  var socialAuth = Get.put(MySocialAuth());

  double dropdown_width = 0.08;

  double profile_menu_width = 51;

  double profile_menu_height = 51;

  double profile_menu_radiud = 30;



  LogoutUser() async {
    print('Logout user ');
    try {
      await socialAuth.Logout();
    } catch (e) {
      print('logut user error $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    profile_menu_width = 51;

    profile_menu_height = 51;

    profile_menu_radiud = 30;

    // DEFAULT :
    if (context.width > 1600) {
      profile_menu_width = 51;

      profile_menu_height = 51;

      profile_menu_radiud = 30;

      print('Greator then 1600');
    }

    if (context.width < 1600) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      dropdown_width = 0.11;
      print('1500');
    }

    if (context.width < 1200) {
      profile_menu_radiud = 30;

      profile_menu_width = 48;

      profile_menu_height = 48;

      dropdown_width = 0.13;
      print('1200');
    }

    if (context.width < 1100) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.14;
      print('1100');
    }

    if (context.width < 1000) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.15;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.20;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 700) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.20;
      print('700');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      profile_menu_radiud = 21;

      profile_menu_width = 40;

      profile_menu_height = 40;

      dropdown_width = 0.20;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      profile_menu_radiud = 30;

      profile_menu_width = 30;

      profile_menu_height = 30;

      print('480');
    }

    return FulscreenDropdown(context);
  }

  Container FulscreenDropdown(BuildContext context) {
    return Container(
        width: context.width * dropdown_width,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
              dropdownDecoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(7)),
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
                ...InvestorMenuItems.thirdItem.map(
                  (item) => DropdownMenuItem<MenuItem>(
                    value: item,
                    child: InvestorMenuItems.buildItem(item),
                  ),
                ),
              ],
              onChanged: (value) async {
                switch (value) {
                  case InvestorMenuItems.profile:
                    await widget.SwitchToFounder();
                    break;

                  case InvestorMenuItems.settings:
                    await widget.SwitchSettingView();
                    break;

                  case InvestorMenuItems.logout:
                    await LogoutUser();
                    break;

                  case InvestorMenuItems.feedback:
                    Wiredash.of(context).show(inheritMaterialTheme: true);
                    break;
                }
              },
              // openWithLongPress: true,
              // customItemsHeights: [8],
              customButton: Container(
                margin: EdgeInsets.only(top: context.height * 0.01),
                child: CircleAvatar(
                  // backgroundColor: Colors.orange.shade100,
                  radius: profile_menu_radiud,

                  child: ClipOval(
                    child: CachedNetworkImage(
                      key: UniqueKey(),
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
  final IconData? icon;

  const MenuItem({
    required this.text,
    this.icon,
  });
}

////////////////////////////////////
/// Founder Menu Items
////////////////////////////////////
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
  static const List<MenuItem> thirdItem = [feedback];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);

  static const settings = MenuItem(text: 'settings', icon: Icons.settings);

  static const logout = MenuItem(text: 'logout', icon: Icons.logout);

  static const feedback =
      MenuItem(text: 'feedback', icon: Icons.feedback_outlined);

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
          style: TextStyle(color: input_text_color, fontSize: 16),
        ),
      ],
    );
  }
}
