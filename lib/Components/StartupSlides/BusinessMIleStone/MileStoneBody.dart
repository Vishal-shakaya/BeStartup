import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessMileStoneStore.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/AddMileButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessMIleStone/MileStoneTag.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MileStoneBody extends StatefulWidget {
  const MileStoneBody({Key? key}) : super(key: key);

  @override
  State<MileStoneBody> createState() => _MileStoneBodyState();
}

class _MileStoneBodyState extends State<MileStoneBody> {
  double mile_cont_width = 0.70;
  double mile_cont_height = 0.70;

  double list_tile_width = 0.4;
  double list_tile_height = 0.30;

  double addbtn_top_margin = 0.05;

  double subhead_sec_width = 400;
  double subhead_sec_height = 80;

  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;

  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');
  late ConfettiController _controllerCenter;
  
  //////////////////////////////////////////
  /// Congress message animation : 
  //////////////////////////////////////////
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }


//////////////////////////
/// Initial State : 
//////////////////////////
  @override
  void initState() {
    pageParam = Get.parameters;
    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

// SHOW LOADING SPINNER :
  StartLoading() {
    var dialog = SmartDialog.showLoading(
      background: Colors.white,
      maskColorTemp: Color.fromARGB(146, 252, 250, 250),
      widget: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.orangeAccent,
      ));
    return dialog;
  }

  ErrorSnakbar(context) {
    Get.snackbar(
      '',
      '',
      margin: EdgeInsets.only(top: 10),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red.shade50,
      titleText: MySnackbarTitle(title: 'Error'),
      messageText: MySnackbarContent(message: 'Something went wrong'),
      maxWidth: context.width * 0.50,
    );
  }

// End Loading
  EndLoading() async {
    SmartDialog.dismiss();
  }


  ///////////////////////////////
  /// Update Milestone : 
  ///////////////////////////////
  UpdateMileStone() async {
    StartLoading();
    var resp = await mileStore.PersistMileStone();
    if (!resp['response']) {
      EndLoading();
    } else {
      EndLoading();
      Get.toNamed(vision_page_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    SubmitMileStone() async {
      StartLoading();
      var resp = await mileStore.PersistMileStone();
      if (!resp['response']) {
        EndLoading();
        ErrorSnakbar(context);
      } else {
        await EndLoading();
        _controllerCenter.play();
        CoolAlert.show(
            barrierDismissible: false,
            title: 'First Step Completed!!',
            text: 'Now you have to complete final step.',
            width: alert_width,
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
              _controllerCenter.stop();
              Get.toNamed(create_founder, preventDuplicates: false);
            },
            context: context,
            type: CoolAlertType.success);
      }
    }

    ////////////////////////////////
    /// RESPONSIVE BREAK  POINTS :
    /// DEFAULT 1500 :
    /// ///////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      print('greator then 1500');
      mile_cont_width = 0.70;
      mile_cont_height = 0.70;

      list_tile_width = 0.4;
      list_tile_height = 0.30;

      addbtn_top_margin = 0.05;

      subhead_sec_width = 400;
      subhead_sec_height = 80;
    }

    // PC:
    if (context.width < 1500) {
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
      print('640');
      list_tile_width = 0.6;
    }

    // PHONE:
    if (context.width < 480) {
      print('480');
    }

    var milestones;

    // return MainMethod(context, milestones, SubmitMileStone);
    // INITILIZE DEFAULT STATE :
// GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        final data = await mileStore.GetMileStonesList();
        milestones = data;
        return milestones;
      } catch (e) {
        return false;
      }
    }

    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Input Section',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data, SubmitMileStone);
          }
          return MainMethod(context, snapshot.data, SubmitMileStone);
        });
  }

  Column MainMethod(
    BuildContext context, 
    milestones, 
    Future<Null> SubmitMileStone()) {

    return Column(
     children: [
      Container(
          width: context.width * mile_cont_width,
          height: context.height * mile_cont_height,
          child: Column(children: [
            // SUBHEADING SECTION :
            SubHeadingSection(context),

            // ADD TAG BUTTON :
            AddMileButton(),

            // CONGRESS MESSAGE WITH SPARKEL:
            CongressMessage(),

            //////////////////////////////
            // LIST OF TAGS :
            // 1.Show milestone Info:
            // 2.Delete milestone :
            // 3.Edit MileStone :
            //////////////////////////////
            Container(
                width: context.width * list_tile_width,
                height: context.height * list_tile_height,
                margin: EdgeInsets.only(top: 10),
                child: Obx(
                  () {
                  return milestones == false
                    ? Container()
                    : ListView.builder(
                        itemCount: milestones.length,
                        itemBuilder: (context, intex) {
                        return MileStoneTag(
                          milestone: milestones[intex],
                          index: intex,
                          key: UniqueKey(),
                        );
                      });
                },
                ))
          ])),
      updateMode == true
          ? UpdateButton(context)
          : BusinessSlideNav(
              slide: SlideType.milestone,
              submitform: SubmitMileStone,
            )
      ],
    );
  }

  ///////////////////////////////////////////
  /// COMPONENT : 
  ///////////////////////////////////////////
  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await UpdateMileStone();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Update',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Stack CongressMessage() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            maxBlastForce: 50, // set a lower max blast force
            minBlastForce: 40,
            numberOfParticles: 25, // set a lower min blast force
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
      ],
    );
  }

  ////////////////////////
  /// SUBHEADING SECTION :
  /// /////////////////////
  Column SubHeadingSection(BuildContext context) {
    return Column(
      children: [
        // Important note :
        AutoSizeText('Why Milestone,s Important!',
            style: Get.textTheme.headline2),

        SafeArea(
          child: Container(
              alignment: Alignment.topCenter,
              width: subhead_sec_width,
              height: subhead_sec_height,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              // Decoration:
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10))),
              child: AutoSizeText.rich(
                TextSpan(children: [
                  TextSpan(
                      text: milestone_subHeading_text,
                      style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black))
                ]),
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
