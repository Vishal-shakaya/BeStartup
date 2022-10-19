import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top:50),
        height:context.height *0.30,
        color:  Get.isDarkMode? Colors.blueGrey.shade700: Colors.blueGrey.shade900,
        child:Column(
          children: [
            Container(
              height: context.height*0.20,
              child: Row(
                children: [
               
                  // Logo and Social Button : 
                  Expanded(
                    flex:3, 
                    child: Container(
                      alignment:Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      
                        children: [
                          
                          // Startup Icon Block : 
                          Container(
                            margin: EdgeInsets.only(top:context.height*0.02),
                            child: Image.asset(logo_image,
                              height: 100,
                              width: 250,
                              fit: BoxFit.contain),
                          ),
                          
                          // Startup Socail Button : 
                          Container(
                            width: context.width*0.11,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top:context.height*0.02),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: (){}, 
                                  icon:FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    size: 16,
                                    color: Colors.blueGrey.shade100, )), 
                                IconButton(
                                  onPressed: (){}, 
                                  icon:FaIcon(
                                    FontAwesomeIcons.twitter,
                                    size: 16,
                                    color: Colors.blueGrey.shade100, )), 
                                IconButton(
                                  onPressed: (){}, 
                                  icon:FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: 16,
                                    color: Colors.blueGrey.shade100, )), 
                                IconButton(
                                  onPressed: (){}, 
                                  icon:FaIcon(
                                    FontAwesomeIcons.linkedinIn,
                                    size: 16,
                                    color: Colors.blueGrey.shade100, )), 
                                IconButton(
                                  onPressed: (){}, 
                                  icon:FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: 16,
                                    color: Colors.blueGrey.shade100,)), 
                              ],
                            ),
                          ), 


                        ],
                      ),
                    )),

                  //  
                  Expanded(flex:3, child: Column()), 
                  Expanded(flex:3, child: Column()), 
                ],
              ),
            ), 
            
            // Copyright and licence:  
            Container(
              height:context.height *0.10,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Container(
                      child:RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:copyright_text,
                              style:GoogleFonts.robotoSlab(
                                color: Colors.blueGrey.shade100,
                                fontSize: 16,  
                                letterSpacing: 2
                              )
                            )
                          ]
                        ))
                    )
                ]
              ),
            ),
          ],
        ) 
    );
  }
}
