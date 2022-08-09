import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileStoryThumbnail extends StatelessWidget {
  var startup_id;
  ProfileStoryThumbnail({
    required this.startup_id,
    Key? key,
  }) : super(key: key);

  var startupConnector = Get.put(StartupViewConnector());
  double image_cont_width = 0.30;
  double image_cont_height = 0.15;

  double image_thumb_width = 0.30;
  double image_thumb_height = 0.14;
  var thumbnail = '';
  ///////////////////////////
  /// GET REQUIREMENTS :
  ///////////////////////////
  GetLocalStorageData() async {
    final resp = await startupConnector.FetchThumbnail(startup_id: startup_id);
    if (resp['response']) {
      thumbnail = resp['data']['thumbnail'];
    }
    if (!resp['response']) {
      thumbnail = resp['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerModel(context);
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

///////////////////////////////
  /// Main Method
///////////////////////////////
  Container MainMethod(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.03),
      child: Card(
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
              child: Image.network(thumbnail,
                  width: context.width * image_thumb_width,
                  height: context.height * image_thumb_height,
                  fit: BoxFit.cover),
            )),
      ),
    );
  }

  Center ShimmerModel(BuildContext context) {
    return Center(
        child: Shimmer.fromColors(
            baseColor: shimmer_base_color,
            highlightColor: shimmer_highlight_color,
            child: Container(
              margin: EdgeInsets.only(top: context.height * 0.03),
              child: Card(
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
                ),
              ),
            )));
  }
}
