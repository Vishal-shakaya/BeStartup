import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SaveStoryButton extends StatefulWidget {
  var user_id;
  SaveStoryButton({required this.user_id, Key? key}) : super(key: key);

  @override
  State<SaveStoryButton> createState() => _SaveStoryButtonState();
}

class _SaveStoryButtonState extends State<SaveStoryButton> {
  var userState = Get.put(UserState());
  var homeviewConnector = Get.put(HomeViewConnector());
  var authUser = FirebaseAuth.instance.currentUser;
  var user_id;
  bool is_saved = false;
  double save_iconSize = 26;

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////
    /// GET REQUIRED PARAM :
    /////////////////////////////////////////
    IsPostSaved() async {
      user_id = authUser?.uid;
      final resp = await homeviewConnector.IsStartupSaved(
        user_id: user_id,
      );

      if (resp['code'] == 101) {
        is_saved = true;
      }
      if (resp['code'] == 111) {
        is_saved = false;
      }
    }

    /////////////////////////////////
    /// SET REQUIRED PARAM :
    /////////////////////////////////
    return FutureBuilder(
        future: IsPostSaved(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Container(
                  child: Icon(
                Icons.bookmark_border_rounded,
                size: save_iconSize,
                color: Colors.grey,
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
  MainMethod(BuildContext context) {
    return SaveUnsaveIcon(is_saved: is_saved, user_id: user_id);
  }
}

////////////////////////////
/// EXTERNAL WIDGET:
////////////////////////////
class SaveUnsaveIcon extends StatefulWidget {
  var user_id;
  var startup_id;
  var is_saved;
  SaveUnsaveIcon({this.is_saved, required this.user_id, Key? key})
      : super(key: key);

  @override
  State<SaveUnsaveIcon> createState() => _SaveUnsaveIconState();
}

class _SaveUnsaveIconState extends State<SaveUnsaveIcon> {
  var homeviewConnector = Get.put(HomeViewConnector());
  bool is_saved = false;
  double save_iconSize = 26;

  ///////////////////////////////////////////////////////////
  /// It checks if the startup is already saved, if it is,
  /// it unsaves it. If it isn't, it saves it
  ///////////////////////////////////////////////////////
  SavingPostProcess() async {
    final resp = await homeviewConnector.SaveStartup(
      user_id: widget.user_id,
    );
    print('Resp $resp');

    /// Updaet UI to Saved
    if (resp['response']) {
      setState(() {
        is_saved = true;
      });
    }

    // If startup already save then Unsave :
    if (resp['code'] == 101) {
      final unsave_resp = await homeviewConnector.UnsaveStartup(
        user_id: widget.user_id,
      );
      // Update UI :
      if (unsave_resp['response']) {
        setState(() {
          is_saved = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    is_saved = widget.is_saved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    save_iconSize = 26;

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    // DEFAULT :
    if (context.width > 1500) {
      save_iconSize = 26;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      save_iconSize = 23;
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      save_iconSize = 23;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            padding: EdgeInsets.all(1),
            margin: EdgeInsets.only(right: context.width * 0.02, top: 5),
            child: is_saved
                ? IconButton(
                    onPressed: () {
                      SavingPostProcess();
                    },
                    icon: Icon(
                      Icons.bookmark,
                      size: save_iconSize,
                      color: Colors.grey,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      SavingPostProcess();
                    },
                    icon: Icon(
                      Icons.bookmark_border_rounded,
                      size: save_iconSize,
                      color: Colors.grey,
                    ),
                  ))
      ],
    );
  }
}
