import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/AppState/UserStoreName.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/HomeView/ExploreSection/ExploreAlert.dart';
import 'package:be_startup/Components/HomeView/HomeHeaderSection.dart';
import 'package:be_startup/Components/HomeView/SearhBar/SearchBar.dart';
import 'package:be_startup/Components/HomeView/SettingsView/UserSettings.dart';
import 'package:be_startup/Components/HomeView/StoryView/StoryHandler.dart';
import 'package:be_startup/Components/HomeView/UserProfileView/UserProfileHandler.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  dynamic mainViewWidget = StoryListView();
  var founderStore = Get.put(FounderStore());
  var investorConnector = Get.put(InvestorConnector());

  final userState = Get.put(UserState());
  final userStore = Get.put(UserStore());
  var view = HomePageViews.storyView;
  var user_id;

  var catigory;
  var date_range;

  var user_name;
  var user_profile;
  var primary_mail;
  var registor_mail;
  var default_mail;
  var phoneNo;
  var otherContact;

  var home_icon = Icons.home;
  var save_icon = Icons.bookmark_outline;

  var usertype;
  double page_width = 0.80;
  double page_height = 0.90;

  double explore_top_margin = 0.83;
  double explore_left_margin = 0.40;
  double explore_icon_size = 18;
  double explore_btn_radius = 20;

  SetHomeView(changeView) async {
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

    if (changeView == HomePageViews.exploreView) {
      setState(() {
        view = HomePageViews.exploreView;
      });

      // setState(() {
      //   view = HomePageViews.exploreView;
      // });
    }
  }

  // Explore Dialog :
  ExploreFunction(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: my_dialog_color,
                        size: 18,
                      ))),
              content: ExploreCatigoryAlert(
                changeView: SetHomeView,
              ));
        });
  }

  // LOADING SPINNER :
  var spinner = Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    padding: EdgeInsets.all(8),
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: dartk_color_type3,
      strokeWidth: 5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1700) {
      explore_top_margin = 0.83;
      explore_left_margin = 0.40;
      explore_icon_size = 18;
      explore_btn_radius = 20;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      explore_top_margin = 0.83;
      explore_left_margin = 0.45;
      explore_icon_size = 18;
      explore_btn_radius = 20;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      explore_top_margin = 0.83;
      explore_left_margin = 0.40;
      explore_icon_size = 18;
      explore_btn_radius = 20;
      print('480');
    }

    ///////////////////////////////////////////
    /// ASSIGNING VIEW  :
    /// DEFAULT VIEW IS STORYVIEW :
    ///////////////////////////////////////////

    if (view == HomePageViews.profileView) {
      home_icon = Icons.home_outlined;
      save_icon = Icons.bookmark_border_outlined;
      mainViewWidget = UserProfileView();
    }

    if (view == HomePageViews.safeStory) {
      home_icon = Icons.home_outlined;
      save_icon = Icons.bookmark;
      mainViewWidget = StoryListView(
        is_save_page: true,
      );
    }

    if (view == HomePageViews.exploreView) {
      home_icon = Icons.home;
      save_icon = Icons.bookmark_border_outlined;
      mainViewWidget = StoryListView(
        is_explore: true,
      );
    }

    if (view == HomePageViews.storyView) {
      home_icon = Icons.home;
      save_icon = Icons.bookmark_border_outlined;
      mainViewWidget = StoryListView(
        is_save_page: false,
      );
    }

    if (view == HomePageViews.settingView) {
      home_icon = Icons.home_outlined;
      save_icon = Icons.bookmark_border_outlined;
      mainViewWidget = UserSettings(
        usertype: usertype,
      );
    }

    ///////////////////////////////////////////
    /// GET REQUIRED PARAM :
    ///////////////////////////////////////////
    GetLocalStorageData() async {
      var phoneno;
      var profile_image;
      var username;
      var position;
      final authUser = FirebaseAuth.instance.currentUser;
      final userType = await userState.GetUserType();
      user_id = authUser?.uid;

      // Investor Handler :
      if (userType == UserStoreName.investor) {
        final invest_resp =
            await investorConnector.FetchInvestorDetailandContact(
                user_id: user_id);
        // Investor Success Handler :
        if (invest_resp['response']) {
          print(invest_resp['data']);
          print(' [ SETUP INVESTOR DETAIL ] ');

          user_profile = invest_resp['data']['userDetail']['picture'];
          user_name = invest_resp['data']['userDetail']['name'];
          registor_mail = invest_resp['data']['userDetail']['email'];

          primary_mail = invest_resp['data']['userContect']['primary_mail'];
          phoneNo = invest_resp['data']['userContect']['phone_no'];
          otherContact = invest_resp['data']['userContect']['other_contact'];

          primary_mail = await CheckAndGetPrimaryMail(
              primary_mail: primary_mail, default_mail: registor_mail);

          await userState.SetProfileImage(image: user_profile);
          await userState.SetProfileName(name: user_name);
          await userState.SetDefaultUserMail(mail: registor_mail);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetPhoneNo(number: phoneNo);
          await userState.SetOtherContact(contact: otherContact);
          await userState.SetPrimaryMail(mail: primary_mail);
        }
        usertype = UserType.investor;
        // Founder Error Handler :
        if (!invest_resp['response']) {
          print(' ****** Fetch Investor Profile Error [ HomeView ]******** ');
          print(invest_resp);
        }
      }

      // Founder Handler :
      if (userType == UserStoreName.founder) {
        print(user_id);
        final found_resp = await founderStore.FetchFounderDetailandContact(
            user_id: user_id);

        if (found_resp['response']) {
          final pure_data = found_resp['data'];

          user_profile = pure_data['picture']?? temp_avtar_image;
          user_name = pure_data['name'];
          registor_mail = pure_data['email'];

          primary_mail = pure_data['primary_mail'];
          phoneNo = pure_data['phone_no'];
          otherContact = pure_data['other_contact'];

          primary_mail = await CheckAndGetPrimaryMail(
              primary_mail: primary_mail, default_mail: registor_mail);

          await userState.SetProfileImage(image: user_profile);
          await userState.SetProfileName(name: user_name);
          await userState.SetDefaultUserMail(mail: registor_mail);
          await userState.SetPrimaryMail(mail: primary_mail);
          await userState.SetPhoneNo(number: phoneNo);
          await userState.SetOtherContact(contact: otherContact);
          await userState.SetPrimaryMail(mail: primary_mail);
        }

        usertype = UserType.founder;
        // Founder Error Handler :
        if (!found_resp['response']) {
          print('****** Fetch Founder Profile Error  [ HomeView ]******** ');
          print(found_resp);
        }
      }
    }



///////////////////////////////////////////
/// SET REQUIRED PARAM :
///////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return spinner;
          }
          if (snapshot.hasError) {
            return ErrorPage();
          }

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  ///////////////////////////////////////////
  /// MAIN METHOD :
  ///////////////////////////////////////////
  Container MainMethod(BuildContext context) {

    // Show Floating Explore Button :
    Widget exploreButton = Container();
    if (context.width < 640) {
      exploreButton = ExploreButton(context, ExploreFunction);
    }

    return Container(
        width: page_width,
        height: page_height,
        color: my_theme_background_color,
        margin: EdgeInsets.only(top: context.height * 0.02),
        child: Stack(
          children: [
            // 2. MAIN SECTION :
            Container(alignment: Alignment.center, child: mainViewWidget),

            // Header Section:
            HomeHeaderSection(
              profile_image: user_profile , 
              changeView: SetHomeView,
              usertype: usertype,
              home_icon: home_icon,
              save_icon: save_icon,
            ),

            // SEARCH BAR :
            BusinessSearchBar(),

            exploreButton
          ],
        ));
  }

/////////////////////////////////////////////
  /// External Method :
/////////////////////////////////////////////
  Positioned ExploreButton(BuildContext context, ExploreFunction) {
    return Positioned(
      top: context.height * explore_top_margin,
      left: context.height * explore_left_margin,
      child: Card(
        elevation: 5,
        shadowColor: my_theme_shadow_color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: explore_btn_radius,
          child: IconButton(
            tooltip: 'explore',
            splashRadius: 50,
            onPressed: () {
              ExploreFunction(context);
            },
            icon: Icon(
              Icons.wb_incandescent_sharp,
              size: explore_icon_size,
              color: my_theme_icon_color,
            ),
          ),
        ),
      ),
    );
  }
}
