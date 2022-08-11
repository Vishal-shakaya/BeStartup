import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class StoryCeoProfile extends StatefulWidget {
  var startup_id;
  var founder_id;

  StoryCeoProfile({
    required this.founder_id,
    required this.startup_id,
    Key? key,
  }) : super(key: key);


  @override
  State<StoryCeoProfile> createState() => _StoryCeoProfileState();
}


class _StoryCeoProfileState extends State<StoryCeoProfile> {
  var startupConnector = Get.put(StartupViewConnector());
  var founderConnector = Get.put(FounderConnector());
  var startup_logo;
  var founder_profile;
  String? founder_name;

  FlipCardController? _controller;

  double profile_top_pos = 0.14;
  double profile_left_pos = 0.01;




  ////////////////////////////////////
  /// GET REQUIRED PARAMATERS :
  ////////////////////////////////////
  GetLocalStorageData() async {
    var bus_resp;
    var found_resp;
    try {
      bus_resp = await startupConnector.FetchBusinessDetail(
          startup_id: widget.startup_id);

      found_resp = await founderConnector.FetchFounderDetailandContact(
          user_id: widget.founder_id);

      /////////////////////////////////
      /// Business Detial Handler :
      /////////////////////////////////

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
        founder_profile = found_resp['data']['userDetail']['picture'];
        founder_name = found_resp['data']['userDetail']['name'];
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
    _controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
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
        controller: _controller,
        front: StartupLogo(),
        back: CeoDetail(),
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
          onTap: () {
            _controller?.toggleCard();
          },
          child: Card(
            elevation: 5,
            shadowColor: light_color_type3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
            child: Container(
                child: CircleAvatar(
              radius: 45,
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
                  style: TextStyle(color: Colors.black, fontSize: 13))
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
            _controller?.toggleCard();
          },
          child: Card(
            elevation: 5,
            shadowColor: light_color_type3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
            child: Container(
                child: CircleAvatar(
              radius: 45,
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
                  style: TextStyle(color: Colors.black, fontSize: 13))
            ])))
      ],
    );
  }
}
