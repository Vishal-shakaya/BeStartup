import 'package:be_startup/Backend/Auth/SocialAuthStore.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/CreateInvestorDialog.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:wiredash/wiredash.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FounderCustomFullScreenDropDown extends StatefulWidget {
  var SwitchToFounder;
  var CreateStatup;
  var profile_image;
  var SwitchSettingView;

  FounderCustomFullScreenDropDown(
      {required this.CreateStatup,
      required this.SwitchToFounder,
      required this.profile_image,
      required this.SwitchSettingView,
      Key? key})
      : super(key: key);

  @override
  State<FounderCustomFullScreenDropDown> createState() =>
      _FounderCustomFullScreenDropDownState();
}

class _FounderCustomFullScreenDropDownState
    extends State<FounderCustomFullScreenDropDown> {
  var socialAuth = Get.put(MySocialAuth());

  double dropdown_width = 0.08;

  double profile_menu_width = 51;

  double profile_menu_height = 51;

  double profile_menu_radiud = 30;

  double dropdonw_heightpx800 = 0.22;

  double investor_dialog_width = 0.40;

  // Investor dialog Width :
  MemberDetailDialogView({form_type, context}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
            title: Container(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  )),
            ),
            content: SizedBox(
              width: context.width * investor_dialog_width,
              child: InvestorDialog(
                form_type: form_type,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    profile_menu_width = 51;

    profile_menu_height = 51;

    profile_menu_radiud = 30;

    investor_dialog_width = 0.40; 

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
      investor_dialog_width = 0.45; 
      print('1500');
    }
    if (context.width < 1400) {
      dropdown_width = 0.11;
      investor_dialog_width = 0.50; 
      print('1500');
    }

    if (context.width < 1200) {
      profile_menu_radiud = 30;

      profile_menu_width = 48;

      profile_menu_height = 48;

      dropdown_width = 0.13;
      
      investor_dialog_width = 0.60; 
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

      investor_dialog_width = 0.65; 
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.16;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 700) {
      profile_menu_radiud = 25;

      profile_menu_width = 45;

      profile_menu_height = 45;

      dropdown_width = 0.16;
      print('700');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      profile_menu_radiud = 21;

      profile_menu_width = 40;

      profile_menu_height = 40;

      dropdown_width = 0.23;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      profile_menu_radiud = 20;

      profile_menu_width = 35;

      profile_menu_height = 35;
      dropdown_width = 0.30;

      print('480');
    }

    if (context.width < 800) {
      return DropdownPixel800(context);
    }

    if (context.width < 480) {
      return DropdownPixel480(context);
    } else {
      return FulscreenDropdown(context);
    }
  }

  Container FulscreenDropdown(BuildContext context) {
    return Container(
      width: context.width * dropdown_width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        dropdownDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(7)),
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

          //  DropdownMenuItem<Container>(child:Container(height: 1,)),
          ...FounderMenuItems.thirdItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          // FounderMenuItems.onChanged(context, value as MenuItem);
          switch (value) {
            case FounderMenuItems.profile:
              widget.SwitchToFounder();
              break;

            case FounderMenuItems.add_investor:
              MemberDetailDialogView(
                  context: context, form_type: InvestorFormType.create);
              break;

            case FounderMenuItems.settings:
              widget.SwitchSettingView()();
              break;

            case FounderMenuItems.logout:
              socialAuth.Logout();
              break;

            case FounderMenuItems.feedback:
              Wiredash.of(context).show(inheritMaterialTheme: false ,feedbackOptions: WiredashFeedbackOptions(), options: WiredashFeedbackOptions());
              break;
          }
        },
        customButton: Container(
          margin: const EdgeInsets.only(top: 0),
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

  Container DropdownPixel800(BuildContext context) {
    return Container(
      width: context.width * dropdown_width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        dropdownDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(7)),
        items: [
          ...FounderMenuItemsPixel800.firstItems.map((item) {
            return DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel800.buildItem(item),
            );
          }),

          // const DropdownMenuItem<Divider>(enabled: true, child:Divider(height: 0.1,)),
          ...FounderMenuItemsPixel800.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel800.buildItem(item),
            ),
          ),

          //  DropdownMenuItem<Container>(child:Container(height: 1,)),
          ...FounderMenuItemsPixel800.thirdItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel800.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          // FounderMenuItems.onChanged(context, value as MenuItem);
          switch (value) {
            case FounderMenuItems.profile:
              widget.SwitchToFounder();
              break;

            case FounderMenuItems.add_investor:
              MemberDetailDialogView(
                  context: context, form_type: InvestorFormType.create);
              break;

            case FounderMenuItems.settings:
              widget.SwitchSettingView()();
              break;

            case FounderMenuItems.logout:
              socialAuth.Logout();
              break;

            case FounderMenuItems.feedback:
              Wiredash.of(context).show(inheritMaterialTheme: true);
              break;
          }
        },
        dropdownMaxHeight: context.height * dropdonw_heightpx800,
        customButton: Container(
          margin: const EdgeInsets.only(top: 0),
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

  Container DropdownPixel480(BuildContext context) {
    return Container(
      width: context.width * dropdown_width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        dropdownDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(7)),
        items: [
          ...FounderMenuItemsPixel480.firstItems.map((item) {
            return DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel480.buildItem(item),
            );
          }),

          // const DropdownMenuItem<Divider>(enabled: true, child:Divider(height: 0.1,)),
          ...FounderMenuItemsPixel480.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel480.buildItem(item),
            ),
          ),

          //  DropdownMenuItem<Container>(child:Container(height: 1,)),
          ...FounderMenuItemsPixel480.thirdItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: FounderMenuItemsPixel480.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          // FounderMenuItems.onChanged(context, value as MenuItem);
          switch (value) {
            case FounderMenuItems.profile:
              widget.SwitchToFounder();
              break;

            case FounderMenuItems.add_investor:
              MemberDetailDialogView(
                  context: context, form_type: InvestorFormType.create);
              break;

            case FounderMenuItems.settings:
              widget.SwitchSettingView();
              break;

            case FounderMenuItems.logout:
              socialAuth.Logout();
              break;

            case FounderMenuItems.feedback:
              Wiredash.of(context).show(inheritMaterialTheme: true);
              break;
          }
        },
        customButton: Container(
          margin: const EdgeInsets.only(top: 0),
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
class FounderMenuItems {
  // First Item List :
  static const List<MenuItem> secondItems = [logout];

  // Second Item List :
  static const List<MenuItem> firstItems = [
    profile,
    add_investor,
    // investor,
    // startup,
    settings,
  ];

  // THIRD ITEM LIST :
  static const List<MenuItem> thirdItems = [feedback];
  static const profile = MenuItem(text: 'profile', icon: Icons.person);
  static const add_investor =
      MenuItem(text: 'Investor', icon: Icons.add_box_outlined);

  // static const startup =
  //     MenuItem(text: 'startup', icon: Icons.add_box_outlined);

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

class FounderMenuItemsPixel800 {
  // First Item List :
  static const List<MenuItem> secondItems = [logout];

  // Second Item List :
  static const List<MenuItem> firstItems = [
    profile,
    add_investor,
    // investor,
    // startup,
    settings,
  ];

  // THIRD ITEM LIST :
  static const List<MenuItem> thirdItems = [feedback];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);
  static const add_investor =
      MenuItem(text: 'Investor', icon: Icons.add_box_outlined);
  // static const startup =
  //     MenuItem(text: 'startup', icon: Icons.add_box_outlined);

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
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(
          item.text,
          style: TextStyle(color: input_text_color, fontSize: 14),
        ),
      ],
    );
  }
}

class FounderMenuItemsPixel480 {
  // First Item List :
  static const List<MenuItem> secondItems = [logout];

  // Second Item List :
  static const List<MenuItem> firstItems = [
    profile,
    add_investor,
    // investor,
    // startup,
    settings,
  ];

  // THIRD ITEM LIST :
  static const List<MenuItem> thirdItems = [feedback];

  static const profile = MenuItem(text: 'profile', icon: Icons.person);
  static const add_investor =
      MenuItem(text: 'Investor', icon: Icons.add_box_outlined);
  // static const startup =
  //     MenuItem(text: 'startup', icon: Icons.add_box_outlined);

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
          size: 13,
        ),
        const SizedBox(width: 10),
        Text(
          item.text,
          style: TextStyle(color: input_text_color, fontSize: 12),
        ),
      ],
    );
  }
}
