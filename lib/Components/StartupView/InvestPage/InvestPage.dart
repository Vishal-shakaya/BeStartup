import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/DetailViewState.dart';
import 'package:be_startup/AppState/PageState.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({Key? key}) : super(key: key);

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  var startupConnector =
      Get.put(StartupViewConnector(), tag: "startup_connector");
  var detailViewState = Get.put(StartupDetailViewState());

  var why_text;

  double notice_cont_width = 0.20;

  double notice_block_padding = 20;

  double invest_btn_width = 300;

  double invest_btn_height = 50;

  double page_width = 0.80;

  var startup_id;
  ////////////////////////////////
  /// GET REQUIREMENTS :
  ////////////////////////////////
  GetLocalStorageData() async {
    startup_id = await detailViewState.GetStartupId();

    try {
      final resp =
          await startupConnector.FetchBusinessWhy(startup_id: startup_id);
      why_text = resp['data']['why_text'];
      return why_text;
    } catch (e) {
      return why_text;
    }
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////
    /// SET REQUIREMENTS :
    ////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Startup Vision',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context,) {

    return Container(
    
      child: Container(
        width: context.width * 0.50,
        height: context.height * 0.38,
    
        child: SingleChildScrollView(
    
          child: Column(
            children: [
              // HEADING :
              SizedBox(
                height: context.height * 0.01,
              ),
              StartupHeaderText(
                title: 'Invest',
                font_size: 35,
              ),

              // Edit BUtton
              EditButton(context),

              // SubHeading :
              Container(
                child: StartupHeaderText(
                  title: 'Why you invest in us !',
                  font_size: 15,
                ),
              ),

              SizedBox(
                height: context.height * 0.02,
              ),

              // VISION TEXT:
              Description(context),

              SizedBox(
                height: context.height * 0.05,
              ),

              StartupHeaderText(
                title: 'Terms & Conditions',
                font_size: 19,
              ),
              // Notice Section :
              NoticeContainer(context, notice_block_padding, notice_cont_width),

              // Invet Button :
              SizedBox(
                height: context.height * 0.05,
              ),
              InvestButton(invest_btn_width, invest_btn_height)
            ],
          ),
        ),
      ),
    );
  }

  Container EditButton(BuildContext context) {
    return Container(
      width: context.width * 0.48,
      alignment: Alignment.topRight,
      child: Container(
        width: 90,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: border_color)),
        child: TextButton.icon(
            onPressed: () {
              Get.toNamed(create_business_whyInvest_url);
            },
            icon: Icon(
              Icons.edit,
              size: 15,
            ),
            label: Text('Edit')),
      ),
    );
  }

  ClipPath Description(BuildContext context) {
    return ClipPath(
      child: Card(
        elevation: 1,
        shadowColor: shadow_color1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15),
          right: Radius.circular(15),
        )),
        child: Container(
            width: context.width * 0.45,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: border_color),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15), right: Radius.circular(15))),
            child: AutoSizeText.rich(
              TextSpan(
                  text: why_text,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type3,
                      fontSize: 15,
                      height: 1.8,
                      fontWeight: FontWeight.w600)),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.headline2,
              textAlign: TextAlign.left,
            )),
      ),
    );
  }

  InkWell InvestButton(double invest_btn_width, double invest_btn_height) {
    return InkWell(
      highlightColor: primary_light_hover,
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20), right: Radius.circular(20)),
      onTap: () {},
      child: Card(
        elevation: 10,
        shadowColor: light_color_type3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          width: invest_btn_width,
          height: invest_btn_height,
          decoration: BoxDecoration(
              color: primary_light,
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20), right: Radius.circular(20))),
          child: const Text(
            'Invest now',
            style: TextStyle(
                letterSpacing: 2.5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Container NoticeContainer(
      BuildContext context, notice_block_padding, notice_cont_width) {
    return Container(
      padding: EdgeInsets.all(notice_block_padding),
      margin: EdgeInsets.only(top: context.height * 0.02),
      decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10), right: Radius.circular(10))),
      child: Visibility(
          visible: true,
          child: Container(
              width: context.width * notice_cont_width,
              child: AutoSizeText.rich(TextSpan(
                  style: TextStyle(wordSpacing: 1, color: Colors.black),
                  children: [TextSpan(text: thumbnail_important_text)])))),
    );
  }
}
