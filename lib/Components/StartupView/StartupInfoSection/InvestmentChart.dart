import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:google_fonts/google_fonts.dart';



class InvestmentChart extends StatelessWidget {
  const InvestmentChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double invest_btn_width = 150;
  double invest_btn_height = 37;

  double static_sec_width = 210;
  double static_sec_height = 205; 

    return Container(
            width: static_sec_width,
            height: static_sec_height,

            padding: EdgeInsets.all(10),
            
            child: Card(
              elevation: 5,
              shadowColor: primary_light,
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
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StaticRow(title: 'Team', value: "50"),
                    StaticRow(title: 'Vision', value: "50"),
                    StaticRow(title: 'Investor', value: "50"),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: InkWell(
                        highlightColor: primary_light_hover,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                        onTap: () {},
                        child: Card(
                          elevation: 10,
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
                              'Invest now',
                              style: TextStyle(
                                  letterSpacing: 2.5,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ),
          );
  }

    Container StaticRow({title, value}) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(7),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          AutoSizeText.rich(
            TextSpan(
                text: title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(),
                  color: light_color_type3,
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
                  color: light_color_type3,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}