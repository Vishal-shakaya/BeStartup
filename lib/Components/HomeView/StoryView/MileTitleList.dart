import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MileTitleList extends StatefulWidget {
  var milestone;

  MileTitleList({ this.milestone, Key? key}) : super(key: key);

  @override
  State<MileTitleList> createState() => _MileTitleListState();
}

class _MileTitleListState extends State<MileTitleList> {
  Color select_color = dartk_color_type3;
  bool is_selected = true;
  double mile_width = 0.72;
  double mile_tab_fontSize = 14;
  
  ToogleColor() { 
    is_selected
        ? select_color = Colors.transparent
        : select_color = dartk_color_type3;
    is_selected = false;
  }

  @override
  Widget build(BuildContext context) {
      mile_width = 0.72;
      mile_tab_fontSize = 14;

		////////////////////////////////////
    /// RESPONSIVENESS : 
    ////////////////////////////////////
		// DEFAULT :
    if (context.width > 1500) {
        mile_width = 0.72;
        mile_tab_fontSize = 14;
      print('Greator then 1500');
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
      }

    // PHONE:
    if (context.width < 480) {
        mile_width = 0.72;
        mile_tab_fontSize = 12;
      print('480');
      }



    return FractionallySizedBox(
      widthFactor: mile_width,
      child: Container(
        margin: EdgeInsets.only(top:5),
        child: InkWell(
          onTap: () {
            setState(() {
              // ToogleColor();
            });
          },
          child: Container( 
            height:context.height*0.04,   
              decoration: BoxDecoration(
                color: select_color,
                borderRadius: BorderRadius.circular(15)
              ),
           
              child:  Container(
                alignment:Alignment.center,

                  child: AutoSizeText.rich(
                    TextSpan(
                        text: widget.milestone.toString().capitalizeFirst,
                        style: GoogleFonts.robotoSlab(
                          textStyle: TextStyle(),
                          color: mile_text_color,
                          fontSize: mile_tab_fontSize,
                        )),
                    style: Get.textTheme.headline2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                )),
        ),
      ),
    );
  }
}
