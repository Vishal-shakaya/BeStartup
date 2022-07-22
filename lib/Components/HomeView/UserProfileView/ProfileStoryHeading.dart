import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';

class ProfileStoryHeading extends StatelessWidget {
  var startup_name='';
  ProfileStoryHeading({
    required this.startup_name,
    Key? key,
  }) : super(key: key);

  //////////////////////////////////////
  /// GET REQUIREMTNS:
  //////////////////////////////////////
  GetLocalStorageData() async {
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
                    baseColor: shimmer_base_color,
                    highlightColor: shimmer_highlight_color,
                    child: MainMethod(context)));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  //////////////////////////////////
  /// SET REQUIRED PARAM :
  //////////////////////////////////
   MainMethod(BuildContext context) {
    return Container(
      width: context.width * 0.30,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: context.height * 0.03),
      child: AutoSizeText.rich(
        TextSpan(
            text: startup_name.toString().capitalize,
            style: TextStyle(fontSize: 18)),
        style: context.textTheme.headline2,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
