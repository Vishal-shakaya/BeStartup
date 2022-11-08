import 'package:be_startup/Utils/Images.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BusinessTycoonSection extends StatefulWidget {
  BusinessTycoonSection({Key? key}) : super(key: key);

  @override
  State<BusinessTycoonSection> createState() => _BusinessTycoonSectionState();
}

class _BusinessTycoonSectionState extends State<BusinessTycoonSection> {
  double video_player_width = 0.70;

  double video_player_height = 0.70;

  double video_model_player_width = 0.70;

  double video_model_player_height = 0.70;

  double heading_fontSize = 32;

  double service_bottom_height = 0.04;

  double service_top_height = 0.10;

  double pitch_cont_bottom_margin = 0.10;

  late VideoPlayerController _controller;

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

  var playserVolume = true;

  var autoPlay = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(businessTycoonVideo,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
    _controller.setVolume(0.0);
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    video_model_player_width = 0.70;
    video_model_player_height = 0.70;
    service_top_height = 0.10;

    // DEFAULT :
    if (context.width > 1700) {
      video_model_player_width = 0.70;
      video_model_player_height = 0.70;

      service_top_height = 0.10;
      print('1700');
    }
    // DEFAULT :
    if (context.width < 1700) {
      print('1700');
    }

    // DEFAULT :
    if (context.width < 1600) {
      video_model_player_width = 0.70;
      video_model_player_height = 0.70;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      video_model_player_width = 0.75;
      video_model_player_height = 0.60;
      print('1500');
    }

    if (context.width < 1200) {
      service_top_height = 0.06;
      video_model_player_width = 0.90;
      video_model_player_height = 0.50;
      print('1200');
    }

    if (context.width < 1300) {
      // video_player_width = 0.90;
      // video_player_height = 0.40;
      print('1300');
    }

    if (context.width < 1000) {
      service_top_height = 0.05;
      video_model_player_width = 0.90;
      video_model_player_height = 0.40;
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
      service_top_height = 0.05;

      video_model_player_width = 0.90;

      video_model_player_height = 0.35;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      service_top_height = 0.02;
      video_model_player_width = 0.90;

      video_model_player_height = 0.35;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      video_model_player_width = 0.97;
      video_model_player_height = 0.99;
      print('480');
    }

////////////////////////////////////////////
    /// HEADING FONTSIZE :
////////////////////////////////////////////

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

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: context.width * 1,
            height: context.height * 0.80,
            alignment: Alignment.center,
            color: Colors.black,
            
            margin: EdgeInsets.only(
              top: context.height * 0.05,
              bottom: context.height * 0.20,
            ),
            
            child: Container(
              // margin: EdgeInsets.only(
              //   bottom: context.height * 0.01,
              //   top: context.height * 0.01,
              // ),
            
              width: context.width * 0.80,
              height: context.height * 0.80,
              child: _controller.value.isInitialized
                  
                  ? Column(
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
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
