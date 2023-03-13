import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPitchSection extends StatefulWidget {
  var pitch;

  IntroPitchSection({required this.pitch, Key? key}) : super(key: key);

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

  late YoutubePlayerController _controller;

  var autoPlay = true;

  @override
  void initState() {

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    _controller.loadVideo(widget.pitch);
    _controller.stopVideo();
    _controller.setSize(context.width * video_player_width,
        context.height * video_player_height);


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
          SizedBox(height: context.height * service_top_height),
          StartupHeaderText(
            title: 'Pitch | Intro ',
            font_size: heading_fontSize,
          ),
          SizedBox(height: context.height * service_bottom_height),
          Container(
            margin: EdgeInsets.only(
                bottom: context.height * pitch_cont_bottom_margin),
            width: context.width * video_model_player_width,
            height: context.height * video_model_player_height,
            child: YoutubePlayerControllerProvider(
              controller: _controller,
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
