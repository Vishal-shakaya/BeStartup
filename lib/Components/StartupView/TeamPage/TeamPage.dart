import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/TeamPage/AllMembers.dart';
import 'package:be_startup/Components/StartupView/TeamPage/MemberBlock.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double page_width = 0.80;
    return Container(
      width: context.width * page_width,
      
      // TEAM MEMBER   SECTION :  
      child:Container(
        child:SingleChildScrollView(
          child: Column(
            children: [
              // Heading : 
              StartupHeaderText(title: 'Team Members',font_size: 32,),
              
              // Member List Section : 
              Column(
                children: [
                  Card(
                    elevation: 1,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10),

                    ),
                    child: Container(
                    width: context.width * 0.50,
                    height: context.height * 0.70,                  
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    
                    decoration: BoxDecoration(
                    // border: Border.all(color: border_color),
                    borderRadius:BorderRadius.circular(10),
                                  ), 
                    alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top:50),
                      child: SingleChildScrollView(
                        child: Column(
                           children: [
                             // Member Block : 
                             // Higher Order Member: 
                             MemberBlock(), 
                             MemberBlock(), 
                             MemberBlock(), 
                             MemberBlock(),
                        
                          
                           ], 
                        ),
                      ),
                    ),
                  ),

                  // Spacing : 
                  SizedBox(height:context.height*0.04),  
                  // Headign : 
                    StartupHeaderText(title: 'Members',font_size: 32,),
                  // ALL MEMBER LIST 
                    AllMembers()
                ],
              )
            ],
          ),
        )
      )  
    );
  }
  
}
