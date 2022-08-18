import 'package:be_startup/Backend/HomeView/HomeViewConnector.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SaveStoryButton extends StatefulWidget {
  var founder_id;
  var startup_id;
  SaveStoryButton(
      {required this.founder_id, required this.startup_id, Key? key})
      : super(key: key);

  @override
  State<SaveStoryButton> createState() => _SaveStoryButtonState();
}

class _SaveStoryButtonState extends State<SaveStoryButton> {
  var userState = Get.put(UserState());
  var homeviewConnector = Get.put(HomeViewConnector());
  bool is_saved = false;
  var user_id;

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////
    /// GET REQUIRED PARAM :
    /////////////////////////////////////////
    IsPostSaved() async {
      user_id = await userState.GetUserId();
      final resp = await homeviewConnector.IsStartupSaved(
        startup_id: widget.startup_id,
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
                size: 26,
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
    return SaveUnsaveIcon(
        is_saved: is_saved, user_id: user_id, startup_id: widget.startup_id);
  }
}

////////////////////////////
/// EXTERNAL WIDGET:
////////////////////////////
class SaveUnsaveIcon extends StatefulWidget {
  var user_id;
  var startup_id;
  var is_saved;
  SaveUnsaveIcon(
      {this.is_saved,
      required this.user_id,
      required this.startup_id,
      Key? key})
      : super(key: key);

  @override
  State<SaveUnsaveIcon> createState() => _SaveUnsaveIconState();
}

class _SaveUnsaveIconState extends State<SaveUnsaveIcon> {
  var homeviewConnector = Get.put(HomeViewConnector());
  bool is_saved = false;

  ///////////////////////////////////////////////////////////
  /// It checks if the startup is already saved, if it is,
  /// it unsaves it. If it isn't, it saves it
  ///////////////////////////////////////////////////////
  SavingPostProcess() async {
    final resp = await homeviewConnector.SaveStartup(
      startup_id: widget.startup_id,
      user_id: widget.user_id,
    );

    /////////////////////////////////////////////
    /// Updaet UI to Saved
    /////////////////////////////////////////////
    if (resp['response']) {
      setState(() {
        is_saved = true;
      });
    }

    ///////////////////////////////////////////
    // If startup already save then Unsave :
    ///////////////////////////////////////////
    if (resp['code'] == 101) {
      final unsave_resp = await homeviewConnector.UnsaveStartup(
        startup_id: widget.startup_id,
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
                      size: 26,
                      color: Colors.grey,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      SavingPostProcess();
                    },
                    icon: Icon(
                      Icons.bookmark_border_rounded,
                      size: 26,
                      color: Colors.grey,
                    ),
                  ))
      ],
    );
  }
}
