import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Loader/Shimmer/HomeView/StartupThumbnailShimmer.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class StoryThumbnail extends StatefulWidget {
  var startup_id;
  StoryThumbnail({
    required this.startup_id,
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

  ///////////////////////////////////////////////
  /// GET REQUIREMENTS ;
  ///////////////////////////////////////////////
    GetLocalStorageData() async {
      try {
        final resp = await startupView_connector.FetchThumbnail(
            startup_id: widget.startup_id);
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
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(19),
        right: Radius.circular(19),
      )),
      child: Container(
          height: context.height * image_cont_height,
          width: context.width * image_cont_width,
          padding: EdgeInsets.all(2),

          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
          ),
          
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(
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
