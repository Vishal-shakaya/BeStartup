import 'dart:convert';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';

import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Components/StartupView/IntroPitch/IntroPitch.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ProductSection.dart';
import 'package:be_startup/Components/StartupView/ProductServices/ServiceSection.dart';
import 'package:be_startup/Components/StartupView/StartupInfoSection/StartupInfoSection.dart';
import 'package:be_startup/Components/StartupView/StartupVisionSection/StartupVisionSection.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupView extends StatefulWidget {
  StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  String? pageParam = Get.parameters['data'];

  var founderStore = Get.put(FounderStore());

  var detailViewState = Get.put(StartupDetailViewState());

  var startupConnector = Get.put(StartupViewConnector());

  var pitch;

  var is_admin;

  late YoutubePlayerController _controller;

  var autoPlay = true;

  double page_width = 0.90;

  double video_player_width = 0.70;

  double video_player_height = 0.70;

  double video_model_player_width = 0.70;

  double video_model_player_height = 0.70;

  PlayPitchVideo(context) {
    _controller.close();
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titlePadding: const EdgeInsets.all(0),
              // title: Container(
              //     decoration: const BoxDecoration(color: Colors.transparent),
              //     alignment: Alignment.topRight,
              //     child: IconButton(
              //         onPressed: () {
              //           Navigator.of(context).pop();
              //         },
              //         icon: Icon(
              //           Icons.cancel_rounded,
              //           color: cancel_btn_color,
              //           size: 18,
              //         ))),
              contentPadding: const EdgeInsets.all(0.0),
              insetPadding: const EdgeInsets.all(0.0),
              content: Container(
                  alignment: Alignment.center,
                  width: context.width * video_model_player_width,
                  height: context.height * video_model_player_height,
                  child: YoutubePlayerControllerProvider(
                    controller: _controller,
                    child: YoutubePlayer(
                      controller: _controller,
                    ),
                  )));
        });
  }

  HomeNavButton() {
    Get.toNamed(home_page_url);
  }

  BackNavButton() {
    Get.toNamed(home_page_url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var decode_data = jsonDecode(pageParam!);
    GetLocalStorageData() async {
      is_admin = decode_data['is_admin'];
      await detailViewState.SetFounderId(id: decode_data['user_id']);
      await detailViewState.SetIsUserAdmin(admin: decode_data['is_admin']);

      final found_resp = await founderStore.FetchFounderDetailandContact(
          user_id: decode_data['user_id']);

      if (found_resp['response']) {
        final registor_mail = found_resp['data']['email'];
        final primary_mail = found_resp['data']['primary_mail'];

        var mail = await CheckAndGetPrimaryMail(
            primary_mail: primary_mail, default_mail: registor_mail);

        await detailViewState.SetFounderMail(mail: mail);

        // GET STARTUP PICH VIDEO :
        var resp = await startupConnector.FetchBusinessPitch(
            user_id: decode_data['user_id']);
        if (resp['response']) {
          if (resp['data']['pitch'] == null || resp['data']['pitch'] == '') {
            pitch = default_pitch;
          } else {
            pitch = resp['data']['pitch'];
            _controller = YoutubePlayerController(
              params: const YoutubePlayerParams(
                  showControls: true,
                  mute: false,
                  showFullscreenButton: true,
                  loop: false,
                  strictRelatedVideos: true,
                  enableJavaScript: true,
                  color: 'red'),
            );

            _controller.loadVideo(pitch);
            _controller.setSize(context.width * video_player_width,
                context.height * video_player_height);
          }
        }

        if (!resp['response']) {
          pitch = default_pitch;
        }
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading Startup Details');
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    // OPEN INTOR VIDOE MODEL :
    Future.delayed(Duration.zero, () => PlayPitchVideo(context));

    page_width = 0.90;

    video_player_width = 0.70;

    video_player_height = 0.70;

    video_model_player_width = 0.70;

    video_model_player_height = 0.70;

    // DEFAULT :
    if (context.width > 1700) {
      page_width = 0.90;

      video_player_width = 0.70;

      video_player_height = 0.70;

      video_model_player_width = 0.70;

      video_model_player_height = 0.70;

      print('1700');
    }
    // DEFAULT :
    if (context.width < 1700) {
      print('1700');
    }

    // DEFAULT :
    if (context.width < 1600) {
      page_width = 0.90;

      video_player_width = 0.70;

      video_player_height = 0.70;

      video_model_player_width = 0.70;

      video_model_player_height = 0.70;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      video_player_width = 0.65;

      video_player_height = 0.65;

      video_model_player_width = 0.65;

      video_model_player_height = 0.65;
      print('1500');
    }

    if (context.width < 1200) {
      page_width = 0.90;

      video_player_width = 0.70;

      video_player_height = 0.70;
      print('1200');
    }

    if (context.width < 1300) {
      page_width = 0.90;
      print('1300');
    }

    if (context.width < 1000) {
      video_player_width = 0.85;

      video_player_height = 0.85;
      video_model_player_width = 0.85;

      video_model_player_height = 0.85;
      print('1000');
    }

    if (context.width < 950) {
      // video_player_width = 0.85;

      // video_player_height = 0.85;
      // video_model_player_width = 0.85;

      // video_model_player_height = 0.85;
      print('950');
    }

    // TABLET :
    if (context.width < 800) {
      video_player_width = 0.90;

      video_player_height = 0.90;

      video_model_player_width = 0.90;
      ;

      video_model_player_height = 0.90;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      video_player_width = 0.90;

      video_player_height = 0.80;

      video_model_player_width = 0.90;

      video_model_player_height = 0.80;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      page_width = 1;

      video_player_width = 0.97;

      video_player_height = 0.99;

      video_model_player_width = 0.97;

      video_model_player_height = 0.99;
      print('480');
    }

    return Container(
      padding: const EdgeInsets.all(5),
      color: my_theme_background_color,
      width: context.width * page_width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // CONTAIN :
                // 1 THUMBNAIL :
                // 2 PROFILE PICTURE :
                // 3 TABS :
                // 4 INVESTMENT CHART :
                StartupInfoSection(),

                // VISION SECTION :
                // 1 HEADING :
                // 2 STARTUP VISION DESCRIPTION:
                const StartupVisionSection(),

                // PRODUCT AND SERVIVES :
                const ProductSection(),

                // SERVICE SECTION :
                ServiceSection(),

                IntroPitchSection(
                  pitch: pitch,
                ),

                is_admin == true ? InvestorSection() : Container()
              ],
            ),
          ),
          
          Positioned(
              bottom: 0,
              right: 10,
              child: InkWell(
                onTap: () {
                  HomeNavButton();
                },
                child: Card(
                  color: primary_light,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
     /// A back button that is placed on the screen.
          // Positioned(
          //     bottom: 70,
          //     right: 10,
          //     child: InkWell(
          //       onTap: () {
          //         BackNavButton();
          //       },
          //       child: Card(
          //         color: Colors.blueGrey.shade500,
          //         elevation: 5,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(50)),
          //         child: Container(
          //           width: 40,
          //           height: 40,
          //           child: Icon(
          //             Icons.arrow_back_rounded,
          //             size: 25,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ))
        ],
      ),
    );
  }
}
