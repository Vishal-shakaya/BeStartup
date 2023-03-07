import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/StartupThumbnailShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class StoryThumbnail extends StatefulWidget {
  var user_id; 
  StoryThumbnail({
    required this.user_id, 
    Key? key,
  }) : super(key: key);

  @override
  State<StoryThumbnail> createState() => _StoryThumbnailState();
}

class _StoryThumbnailState extends State<StoryThumbnail> {
  var startupView_connector = Get.put(StartupViewConnector());

  double image_cont_width = 0.46;
  double image_cont_height = 0.18;

  double image_thumb_width = 0.46;
  double image_thumb_height = 0.15;

  var final_data = '';

  @override
  Widget build(BuildContext context) {
    image_cont_width = 0.46;
    image_cont_height = 0.18;

    image_thumb_width = 0.46;
    image_thumb_height = 0.15;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      image_cont_width = 0.46;
      image_cont_height = 0.18;

      image_thumb_width = 0.46;
      image_thumb_height = 0.15;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      image_cont_width = 0.55;
      image_cont_height = 0.18;

      image_thumb_width = 0.55;
      image_thumb_height = 0.15;
      print('1500');
    }

    if (context.width < 1400) {
      image_cont_width = 0.60;
      image_cont_height = 0.18;

      image_thumb_width = 0.60;
      image_thumb_height = 0.15;
      print('1400');
    }

    if (context.width < 1200) {
      image_cont_width = 0.65;
      image_cont_height = 0.18;

      image_thumb_width = 0.65;
      image_thumb_height = 0.15;
      print('1200');
    }

    if (context.width < 1000) {
      image_cont_width = 0.75;
      image_cont_height = 0.18;

      image_thumb_width = 0.75;
      image_thumb_height = 0.15;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      image_cont_width = 0.90;
      image_cont_height = 0.18;

      image_thumb_width = 0.90;
      image_thumb_height = 0.15;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      image_cont_width = 0.95;
      image_cont_height = 0.18;

      image_thumb_width = 0.95;
      image_thumb_height = 0.15;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    ///////////////////////////////////////////////
    /// GET REQUIREMENTS ;
    ///////////////////////////////////////////////
    GetLocalStorageData() async {
      try {
        final resp =
            await startupView_connector.FetchThumbnail(user_id:widget.user_id);
        if (resp['response']) {
          final_data = resp['data']['thumbnail'];
        }

        // Error Handler :
        if (!resp['response']) {
          final_data = resp['data'];
        }
        return final_data;
      } catch (e) {
        return final_data;
      }
    }

    /////////////////////////////////////
    /// SET REQUIREMENTS :
    /////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: StartupThumbnailShimmer(context),
            );
          }

          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(
            context,
          );
        });
  }

  Card MainMethod(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: my_theme_shadow_color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(19),
        right: Radius.circular(19),
      )),
      child: Container(
          height: context.height * image_cont_height,
          width: context.width * image_cont_width,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(19),
              right: Radius.circular(19),
            ),
            child: Image.network(
              final_data,
              width: context.width * image_thumb_width,
              height: context.height * image_thumb_height,
              fit: BoxFit.cover,
              scale: 1,
            ),
          )),
    );
  }
}
