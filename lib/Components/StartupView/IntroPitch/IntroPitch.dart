import 'dart:convert';

import 'package:be_startup/Components/StartupView/IntroPitch/DataManger.dart';
import 'package:be_startup/Components/StartupView/IntroPitch/PitchVideoController.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPitchSection extends StatefulWidget {
  var pitch;
  var path;
  var HomeNavButton;
  IntroPitchSection(
      {required this.HomeNavButton,
      required this.path,
      required this.pitch,
      Key? key})
      : super(key: key);

  @override
  State<IntroPitchSection> createState() => _IntroPitchSectionState();
}

class _IntroPitchSectionState extends State<IntroPitchSection> {
  double video_player_width = 0.70;

  double video_player_height = 0.70;

  double video_model_player_width = 0.70;

  double video_model_player_height = 0.70;

  double heading_fontSize = 32;

  double service_bottom_height = 0.04;

  double service_top_height = 0.10;

  double pitch_cont_bottom_margin = 0.10;

  double video_pitch_width = 0.80;

  double video_pitch_height = 0.72;

  var is_admin;
  var user_id;

  var autoPlay = true;
  var playIcon = Icon(
    Icons.pause,
    size: 28,
    color: Colors.blueGrey.shade400,
  );
  var defaultPlayPauseIcon = Icon(
    Icons.pause,
    size: 28,
    color: Colors.blueGrey.shade400,
  );

  var pauseIcon = Icon(
    Icons.play_arrow_sharp,
    size: 28,
    color: Colors.blueGrey.shade400,
  );

  var volumneMuteIcon = Icon(Icons.volume_mute_rounded);
  var volumeUpIcon = Icon(Icons.volume_up_outlined);
  var defaultvolumneMuteIcon = Icon(Icons.volume_mute_rounded);

  late FlickManager flickManager;
  late DataManager? dataManager;
  // late DataManager? dataManager;

  var playserVolume = true;

  EditPitchUrl() {
    var pageParam = jsonEncode({
      'type': 'update',
      'is_admin': is_admin,
      'pitch': widget.pitch,
      'user_id': user_id,
      'path': widget.path ?? '',
    });
    Get.toNamed(create_business_pitcht_url, parameters: {'data': pageParam});
  }

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.pitch),
    );
    dataManager = DataManager(flickManager: flickManager, urls: [widget.pitch]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    heading_fontSize = 32;
    if (context.width > 1700) {
      heading_fontSize = 32;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1300) {
      heading_fontSize = 30;
      print('1300');
    }

    if (context.width < 1200) {
      heading_fontSize = 30;
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      heading_fontSize = 28;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      heading_fontSize = 28;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      heading_fontSize = 25;
      print('480');
    }

    ////////////////////////////////////////////
    ///  GET REQUIREMENTS :
    ////////////////////////////////////////////
    GetLocalStorageData() async {
      final pageParam = jsonDecode(Get.parameters['data']!);
      user_id = pageParam['user_id'];
      is_admin = pageParam['is_admin'];
    }

    ////////////////////////////////////////
    ///  SET REQUIREMENTS :
    ////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  SingleChildScrollView MainMethod(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.height * service_top_height),
          StartupHeaderText(
            title: 'Pitch | Intro ',
            font_size: heading_fontSize,
          ),
          SizedBox(height: context.height * service_bottom_height),
          Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: context.width * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Container(
                      //   child: IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           if (_controller.value.isPlaying) {
                      //             _controller.pause();
                      //             defaultPlayPauseIcon = pauseIcon;
                      //           } else {
                      //             _controller.play();
                      //             defaultPlayPauseIcon = playIcon;
                      //           }
                      //         });
                      //       },
                      //       icon: defaultPlayPauseIcon),
                      // ),

                      IconButton(
                          onPressed: () {
                            EditPitchUrl();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 25,
                            color: Colors.blueGrey.shade400,
                          ))
                    ],
                  ),
                ),
                Container(
                    width: context.width * video_pitch_width,
                    height: context.height * video_pitch_height,
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: FlickVideoWithControls(
                        controls: WebVideoControl(
                          dataManager: dataManager,
                        ),
                        videoFit: BoxFit.contain,
                        // aspectRatioWhenLoading: 4 / 3,
                      ),
                    )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
// YoutubePlayerControllerProvider(
//               controller: _controller,
//               child: YoutubePlayer(
//                 controller: _controller,
//               ),
//             ),