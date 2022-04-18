import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_container/tab_container.dart';

class StartupMileStone extends StatefulWidget {
  const StartupMileStone({Key? key}) : super(key: key);

  @override
  State<StartupMileStone> createState() => _StartupMileStoneState();
}

class _StartupMileStoneState extends State<StartupMileStone> {
   late final TabContainerController _controller;

    @override
    void initState() {
      _controller = TabContainerController(length: 3);
      super.initState();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width*0.55,
      height: context.height*0.45,
      margin: EdgeInsets.only(bottom: 50,top:10),
      child: TabContainer(
        childPadding: EdgeInsets.all(50),
        controller: _controller,
        color: Colors.orange.shade200,
        tabEdge: TabEdge.left,
        tabExtent: context.width*0.15,

        
        children: [
          MileDescriptionSection(
            context:context, 
            description:long_string, 
            title: 'hello this is first startup',
            dy_height: context.height*0.02 ), 
          MileDescriptionSection(
            context:context, 
            description:long_string, 
            title: 'hello this is first startup',
            dy_height: context.height*0.02 ), 
          MileDescriptionSection(
            context:context, 
            description:long_string, 
            title: 'hello this is first startup',
            dy_height: context.height*0.02 ), 
         
        ], 
        tabs: [
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
                  fontSize: 16,
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
                                  fontSize: 20,
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
                                fontSize: 15,
                                height:1.6, 
                                wordSpacing: 2
                              )
                          ), 
                          style: Get.textTheme.headline2,
                          // textAlign: TextAlign.center,
                      ),
            ],
          ),
        );
  }
}