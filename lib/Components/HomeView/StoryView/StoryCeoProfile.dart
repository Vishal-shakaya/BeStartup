import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class StoryCeoProfile extends StatefulWidget {
  var user_id;
  StoryCeoProfile({
    required this.user_id,
    Key? key,
  }) : super(key: key);

  @override
  State<StoryCeoProfile> createState() => _StoryCeoProfileState();
}

class _StoryCeoProfileState extends State<StoryCeoProfile> {
  final startupConnector = Get.put(StartupViewConnector());
  final founderStore = Get.put(FounderStore());

  var startup_logo;
  var founder_profile;
  String? founder_name;

  FlipCardController con = FlipCardController();

  double profile_top_pos = 0.14;
  double profile_left_pos = 0.01;
  double profile_logo_radius = 45;

  double founder_fontSize = 13;

  ////////////////////////////////////
  /// GET REQUIRED PARAMATERS :
  ////////////////////////////////////
  GetLocalStorageData() async {
    var bus_resp;
    var found_resp;
    try {
      bus_resp =
          await startupConnector.FetchBusinessDetail(user_id: widget.user_id);

      found_resp = await founderStore.FetchFounderDetailandContact(
          user_id: widget.user_id);

      // Business Success Handler :
      if (bus_resp['response']) {
        startup_logo = bus_resp['data']['logo'];
      }

      // Business Error Handler :
      if (!bus_resp['response']) {
        startup_logo = bus_resp['data'];
      }

      ////////////////////////////////////
      /// Founder detail handler :
      ////////////////////////////////////

      // Founder Success Handler :
      if (found_resp['response']) {
        founder_profile = found_resp['data']['picture'];
        founder_name = found_resp['data']['name'];
      }

      // Founder Error Handler :
      if (!found_resp['response']) {
        founder_profile = found_resp['data'];
      }

      return '';
    } catch (e) {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profile_top_pos = 0.14;
    profile_left_pos = 0.01;
    profile_logo_radius = 45;
    founder_fontSize = 13;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      profile_top_pos = 0.14;
      profile_left_pos = 0.01;
      profile_logo_radius = 45;
      founder_fontSize = 13;
      print('1500');
    }

    if (context.width < 1400) {
      profile_top_pos = 0.14;
      profile_left_pos = 0.01;
      profile_logo_radius = 42;
      founder_fontSize = 13;

      print('1400');
    }

    if (context.width < 1200) {
      profile_top_pos = 0.14;
      profile_left_pos = 0.01;
      profile_logo_radius = 40;
      founder_fontSize = 13;
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
      profile_top_pos = 0.14;
      profile_left_pos = 0.01;
      profile_logo_radius = 38;
      founder_fontSize = 12;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      profile_top_pos = 0.14;
      profile_left_pos = 0.01;
      profile_logo_radius = 35;
      founder_fontSize = 12;
      print('480');
    }

    /////////////////////////////////////
    /// SET REQUIREMENTS :
    /////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Container(
                  child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blueGrey[100],
              )),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  //////////////////////////////////
  /// MAIN METHOD :
  //////////////////////////////////
  Positioned MainMethod(BuildContext context) {
    return Positioned(
      top: context.height * profile_top_pos,
      left: context.width * profile_left_pos,
      child: FlipCard(
        onTapFlipping: true,
        controller: con,
        rotateSide: RotateSide.left,
        frontWidget: StartupLogo(),
        backWidget: CeoDetail(),
      ),
    );
  }

///////////////////////////////////////
  /// CEO DETIAL :
///////////////////////////////////////
  Column CeoDetail() {
    return Column(
      children: [
        InkWell(
          radius: 100,
          onTap: () {
            con.flipcard();
          },
          child: Card(
            elevation: 4,
            shadowColor: Colors.blueGrey.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
            child: Container(
                child: CircleAvatar(
              radius: profile_logo_radius,
              backgroundColor: Colors.blueGrey[100],
              foregroundImage: NetworkImage(founder_profile, scale: 1),
            )),
          ),
        ),

        // Container Name :
        Container(
            margin: EdgeInsets.only(top: 10),
            child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline5, children: [
              TextSpan(
                  text: founder_name.toString().capitalizeFirst,
                  style: TextStyle(color: startup_profile_color, fontSize: 13))
            ])))
      ],
    );
  }

//////////////////////////////////////
  /// STARTUP DETAIL :
//////////////////////////////////////
  Column StartupLogo() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            con.flipcard();
          },
          child: Card(
            elevation: 4,
            shadowColor: Colors.blueGrey.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
            child: Container(
                child: CircleAvatar(
              radius: profile_logo_radius,
              backgroundColor: Colors.blueGrey[100],
              foregroundImage: NetworkImage(startup_logo, scale: 1),
            )),
          ),
        ),

        // Container Name :
        Container(
            margin: EdgeInsets.only(top: 10),
            child: AutoSizeText.rich(
                TextSpan(style: Get.textTheme.headline5, children: [
              TextSpan(
                  text: ''.capitalizeFirst,
                  style: TextStyle(
                      color: Colors.black, fontSize: founder_fontSize))
            ])))
      ],
    );
  }
}
