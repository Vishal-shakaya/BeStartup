import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileStoryThumbnail extends StatelessWidget {
  var user_id;
  ProfileStoryThumbnail({
    required this.user_id,
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
    final resp = await startupConnector.FetchThumbnail(user_id: user_id);
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
     image_cont_width = 0.30;
     image_cont_height = 0.15;

     image_thumb_width = 0.30;
     image_thumb_height = 0.14;

		////////////////////////////////////
    /// RESPONSIVENESS : 
    ////////////////////////////////////
		// DEFAULT :
    if (context.width > 1500) {
      image_cont_width = 0.30;
      image_cont_height = 0.15;

      image_thumb_width = 0.30;
      image_thumb_height = 0.14;
      print('Greator then 1500');
      }

    // PC:
    if (context.width < 1500) {
      print('1500');
      }

    if (context.width < 1200) {
      image_cont_width = 0.40;
      image_cont_height = 0.15;

      image_thumb_width = 0.40;
      image_thumb_height = 0.14;
      print('1200');
      }
    
    if (context.width < 1000) {
        image_cont_width = 0.65;
        image_cont_height = 0.15;

        image_thumb_width = 0.65;
        image_thumb_height = 0.14;
        print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        image_cont_width = 0.80;
        image_cont_height = 0.15;

        image_thumb_width = 0.80;
        image_thumb_height = 0.14;
        print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
        image_cont_width = 0.85;
        image_cont_height = 0.15;

        image_thumb_width = 0.85;
        image_thumb_height = 0.14;
        print('640');
      }

    // PHONE:
    if (context.width < 480) {
        image_cont_width = 0.95;
        image_cont_height = 0.15;

        image_thumb_width = 0.85;
        image_thumb_height = 0.14;
      print('480');
      }


    return Container(
      margin: EdgeInsets.only(top: context.height * 0.02),
      
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
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
