import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class StoryInfoChart extends StatefulWidget {
  StoryInfoChart({Key? key}) : super(key: key);

  @override
  State<StoryInfoChart> createState() => _StoryInfoChartState();
}

class _StoryInfoChartState extends State<StoryInfoChart> {
    double invest_btn_width = 70;
    double invest_btn_height = 24;

    double static_sec_width = 150;
    double static_sec_height = 165; 
  @override
  Widget build(BuildContext context) {
    return  Positioned(
            top:context.height*0.18,
            left:context.width*0.38,
            child: Container(
              width: static_sec_width,
              height: static_sec_height,
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 1,
                // shadowColor: primary_light,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  StaticRow(title: 'Desire', value: "₹ 50"),
                  StaticRow(title: 'Achived', value: "₹ 30"),
                  StaticRow(title: 'Team', value: "5"),

                  // SUBMIT BUTTON: 
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: InkWell(
                      highlightColor: primary_light_hover,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        shadowColor: light_color_type3,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: invest_btn_width,
                          height: invest_btn_height,
                          decoration: BoxDecoration(
                              color: primary_light,
                              borderRadius:
                                  const BorderRadius.horizontal(
                                      left: Radius.circular(20),
                                      right:
                                          Radius.circular(20))),
                          child: const Text(
                            '₹',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 2.5,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
    Container StaticRow({title, value}) {
    return Container(
      width: 90,
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
                  fontSize: 12,
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