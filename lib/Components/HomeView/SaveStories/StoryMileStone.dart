import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_container/tab_container.dart';


class SaveStoryMileStone extends StatefulWidget {
  SaveStoryMileStone({Key? key}) : super(key: key);

  @override
  State<SaveStoryMileStone> createState() => _SaveStoryMileStoneState();
}

class _SaveStoryMileStoneState extends State<SaveStoryMileStone> {
  late final TabContainerController _controller;
    @override
    void initState() {
      _controller = TabContainerController(length: 4);
      super.initState();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: context.width*0.40,
      height: context.height*0.24,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
        child: TabContainer(
          childPadding: EdgeInsets.all(30),
          controller: _controller,
          color: Colors.orange.shade200,
          tabEdge: TabEdge.left,
          tabExtent: context.width*0.10,
          
          children: [
            MileDescriptionSection(
              context:context, 
              description:long_string, 
              title: 'Hello this is first startup',
              dy_height: context.height*0.02 ), 
            MileDescriptionSection(
              context:context, 
              description:long_string, 
              title: 'Hello this is first startup',
              dy_height: context.height*0.02 ), 
            MileDescriptionSection(
              context:context, 
              description:long_string, 
              title: 'Hello this is first startup',
              dy_height: context.height*0.02 ), 
            MileDescriptionSection(
              context:context, 
              description:long_string, 
              title: 'Hello this is first startup',
              dy_height: context.height*0.02 ), 
           
          ], 
          tabs: [
           MiltTitleTab(title:'hello this is first startup'), 
           MiltTitleTab(title:'hello this is first startup'), 
           MiltTitleTab(title:'hello this is first startup'), 
           MiltTitleTab(title:'hello this is first startup'), 
          ]),
      );
  }

// MILESTONE SIDE BAR TITLE TAB  : 
// REQUIRED PARAM : Title 
  AutoSizeText MiltTitleTab({title}) {
    return AutoSizeText.rich(
          TextSpan(
            text:title,
            style:GoogleFonts.robotoSlab(
                  textStyle: TextStyle(),
                  color: light_color_type4,
                  fontSize: 13,
                )
            ), 
            style: Get.textTheme.headline2,
        );
  }


// MILESTONE DESCRIPTION COLUMN : 
// 1 REQUIRED PARAM :  TITLE AND DESCRIPTION ,  
  Container MileDescriptionSection({context, description,title,dy_height}) {
    return Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
          
                Container(
                 alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(bottom:dy_height),
                  child: AutoSizeText.rich(
                            TextSpan(
                              text:title,
                              style:GoogleFonts.openSans(
                                    textStyle: TextStyle(),
                                    color: light_color_type1,
                                    fontSize: 15,
                                    height:1.6
                                  )
                              ), 
                              style: Get.textTheme.headline2,
                              textAlign: TextAlign.left,
                          ),
                ),
          
                AutoSizeText.rich(
                          TextSpan(
                            text:description,
                            style:GoogleFonts.openSans(
                                  textStyle: TextStyle(),
                                  color: light_color_type1,
                                  fontSize: 13,
                                  height:1.6, 
                                  wordSpacing: 2
                                )
                            ), 
                            style: Get.textTheme.headline2,
                            // textAlign: TextAlign.center,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                        ),
              ],
            ),
          ),
        );
  }
}