import 'dart:convert';

import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:video_player/video_player.dart';

import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPitchSection extends StatefulWidget {
  var pitch;
  var path;
  IntroPitchSection({required this.path, required this.pitch, Key? key})
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
  late VideoPlayerController _controller;
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
    _controller = VideoPlayerController.network(widget.pitch,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
    // _controller.setVolume(0.0);
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
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
            child: _controller.value.isInitialized
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: context.width * 0.75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_controller.value.isPlaying) {
                                          _controller.pause();
                                          defaultPlayPauseIcon = pauseIcon;
                                        } else {
                                          _controller.play();
                                          defaultPlayPauseIcon = playIcon;
                                        }
                                      });
                                    },
                                    icon: defaultPlayPauseIcon),
                              ),

                              IconButton(
                                  onPressed: () {
                                    EditPitchUrl();
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 25,
                                    color: Colors.blueGrey.shade400,
                                  ))
                              // Container(
                              //   child: IconButton(
                              //       onPressed: () {
                              //         print(
                              //             'volument ${_controller.value.volume}');
                              //         setState(() {
                              //           if (_controller.value.volume == 1) {
                              //             playserVolume = false;
                              //             _controller.setVolume(0.0);
                              //             defaultvolumneMuteIcon =
                              //                 volumneMuteIcon;
                              //           }
                              //           if (_controller.value.volume == 0) {
                              //             playserVolume = true;
                              //             _controller.setVolume(1.0);
                              //             defaultvolumneMuteIcon = volumeUpIcon;
                              //           }
                              //         });
                              //       },
                              //       icon: defaultvolumneMuteIcon),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                            width: context.width * 0.80,
                            height: context.height * 0.75,
                            child: VideoPlayer(_controller)),
                      ],
                    ),
                  )
                : Container(),
          ),
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