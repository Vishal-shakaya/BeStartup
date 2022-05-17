import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoChart extends StatefulWidget {
  ProfileInfoChart({Key? key}) : super(key: key);

  @override
  State<ProfileInfoChart> createState() => _ProfileInfoChartState();
}

class _ProfileInfoChartState extends State<ProfileInfoChart> {
  double invest_btn_width = 100;
  double invest_btn_height = 30;

  double static_sec_width = 0.28;
  double static_sec_height = 0.12;
  double statis_row_width = 0.04;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.height * 0.24,
      left: context.width * 0.01,
      child: Container(
        width: context.width * static_sec_width,
        height: context.height * static_sec_height,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 1,
          // shadowColor: primary_light,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  StaticRow(title:'Team'), 
                  StaticRow(title:'10')
                ],), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  StaticRow(title:'Desire'), 
                  StaticRow(title:'₹ 5000')
                ],), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  StaticRow(title:'Achived'), 
                  StaticRow(title:'₹ 2000')
                ],), 
              ],
            )
          ),
        ),
      ),
    );
  }

  Container StaticRow({title, value}) {
    return Container(
      width: context.width*statis_row_width,
      padding: EdgeInsets.all(4),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          AutoSizeText.rich(
            TextSpan(
                text: title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: light_color_type2,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
          AutoSizeText.rich(
            TextSpan(
                text: value,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: light_color_type2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
