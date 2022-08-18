
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/StartupView/StartupViewConnector.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ionicons/ionicons.dart';

class StartupDetailButtons extends StatefulWidget {
  var user_id;
  var startup_id;
  var is_saved; 
  StartupDetailButtons({
    required this.user_id,
    required this.startup_id,
    required this.is_saved, 
    Key? key,
  }) : super(key: key);

  @override
  State<StartupDetailButtons> createState() => _StartupDetailButtonsState();
}

class _StartupDetailButtonsState extends State<StartupDetailButtons> {
  bool is_saved = false;
  var startupViewConnector = Get.put(StartupViewConnector());
  var startupState = Get.put(StartupDetailViewState());
  var userState = Get.put(UserState());

  /// It checks if the startup is already saved by the user,
  /// if yes then it unsaves it, if no then it
  /// saves it
  LikeUnlikeStartupProcess() async {
    final resp = await startupViewConnector.LikeStartup(
      startup_id: widget.startup_id,
      user_id: widget.user_id,
    );

    /// Updaet UI to Saved
    if (resp['response']) {
      setState(() {
        is_saved = true;
      });
    }

    // If startup already save then Unsave :
    if (resp['code'] == 101) {
      final unsave_resp = await startupViewConnector.UnLikeStartup(
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


///////////////////////////////////////
  /// Send Mail to founder
  /// Add Default field :
  /// 1 founder mail
  /// 2 Title : Subject
  /// 3 body : message
///////////////////////////////////////
  Future<void> SendMail() async {
    final founder_mail = await startupState.GetFounderMail() ?? '';

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    // Create url :
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '$founder_mail',
      query: encodeQueryParameters(<String, String>{
        'subject': '$startupInterestSubject',
        'body': '$startupInterestBody'
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw 'Could not launch $emailLaunchUri';
    }
  }


  // SET DEFAULT STATE : 
  @override
  void initState() {
    // TODO: implement initState
    is_saved = widget.is_saved;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 3),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //////////////////////////////////////////////
              // Like Button save SUP to investor profile :
              //////////////////////////////////////////////
              Card(
                elevation: 4,
                shadowColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    tooltip: 'Save for Later Review',
                    onPressed: () async {
                      await LikeUnlikeStartupProcess();
                    },
                    icon: is_saved == true
                        ? const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.redAccent,
                            size: 23,
                          )
                        : const Icon(
                            CupertinoIcons.heart,
                            color: Colors.redAccent,
                            size: 23,
                          )),
              ),

              /////////////////////////////////////////
              // Mail Button  Send to to Founder :
              /////////////////////////////////////////
              Card(
                elevation: 4,
                shadowColor: Colors.blueAccent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                    tooltip: 'Send Mail Now ',
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      await SendMail();
                    },
                    icon: const Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.blueAccent,
                      size: 23,
                    )),
              ),
            ],
          ),
        ));
  }
}
