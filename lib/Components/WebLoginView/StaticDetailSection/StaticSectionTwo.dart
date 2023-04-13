import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StatiSectionTwo extends StatefulWidget {
  const StatiSectionTwo({Key? key}) : super(key: key);

  @override
  State<StatiSectionTwo> createState() => _StatiSectionTwoState();
}

class _StatiSectionTwoState extends State<StatiSectionTwo> {

  CarouselController buttonCarouselController = CarouselController();

  double member_Section_fonsize = 200;

  double profile_image_radius = 70;

  double spacer = 5;

  double name_fonSize = 16;
  double contact_icon_fonSize = 16;

  double contact_fontSiz = 11;

  double ford_back_iconSize = 24;

  double community_section_top_margin = 0.03;
  double community_text_top_margin = 0.02;
  double community_text_fontSize = 28;

  double community_cont_height = 0.30;
  double community_cont_width = 1;
  double community_cont_top_margin = 0.06; 

  double profile_bottom_margin = 0.02; 
  double member_name_bottom_margin = 0.01; 





  @override
  Widget build(BuildContext context) {
     
     member_Section_fonsize = 200;

     profile_image_radius = 70;

     spacer = 5;

     name_fonSize = 16;
     contact_icon_fonSize = 16;

     contact_fontSiz = 11;

     ford_back_iconSize = 24;

     community_section_top_margin = 0.03;
     community_text_top_margin = 0.02;
     community_text_fontSize = 28;

     community_cont_height = 0.30;
     community_cont_width = 1;
     community_cont_top_margin = 0.06; 

     profile_bottom_margin = 0.02; 
     member_name_bottom_margin = 0.01; 


		// DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
      }
  
    if (context.width < 1700) {
    member_Section_fonsize = 200;

     profile_image_radius = 70;

     spacer = 5;

     name_fonSize = 16;
     contact_icon_fonSize = 16;

     contact_fontSiz = 11;

     ford_back_iconSize = 24;

     community_section_top_margin = 0.03;
     community_text_top_margin = 0.02;
     community_text_fontSize = 28;

     community_cont_height = 0.25;
     community_cont_width = 1;
     community_cont_top_margin = 0.06; 

     profile_bottom_margin = 0.02; 
     member_name_bottom_margin = 0.01; 

      print('1700');
      }
  
    if (context.width < 1600) {
    member_Section_fonsize = 200;

     profile_image_radius = 65;

     spacer = 5;

     name_fonSize = 16;
     contact_icon_fonSize = 16;

     contact_fontSiz = 11;

     ford_back_iconSize = 24;

     community_section_top_margin = 0.03;
     community_text_top_margin = 0.02;
     community_text_fontSize = 28;

     community_cont_height = 0.25;
     community_cont_width = 1;
     community_cont_top_margin = 0.05; 

     profile_bottom_margin = 0.02; 
     member_name_bottom_margin = 0.01; 
      print('1600');
      }

    // PC:
    if (context.width < 1500) {
    member_Section_fonsize = 200;

     profile_image_radius = 65;

     spacer = 5;

     name_fonSize = 14;
     contact_icon_fonSize = 16;

     contact_fontSiz = 11;

     ford_back_iconSize = 24;

     community_section_top_margin = 0.03;
     community_text_top_margin = 0.02;
     community_text_fontSize = 25;

     community_cont_height = 0.25;
     community_cont_width = 1;
     community_cont_top_margin = 0.05; 

     profile_bottom_margin = 0.02; 
     member_name_bottom_margin = 0.01; 
      print('1500');
      }

    if (context.width < 1200) {
      member_Section_fonsize = 200;

      profile_image_radius = 60;

      spacer = 5;

      name_fonSize = 14;
      contact_icon_fonSize = 16;

      contact_fontSiz = 11;

      ford_back_iconSize = 24;

      community_section_top_margin = 0.03;
      community_text_top_margin = 0.02;
      community_text_fontSize = 23;

      community_cont_height = 0.23;
      community_cont_width = 1;
      community_cont_top_margin = 0.05; 

      profile_bottom_margin = 0.02; 
      member_name_bottom_margin = 0.01; 
      print('1200');
      }
    
    if (context.width < 1000) {
         member_Section_fonsize = 200;

      profile_image_radius = 60;

      spacer = 5;

      name_fonSize = 14;
      contact_icon_fonSize = 16;

      contact_fontSiz = 11;

      ford_back_iconSize = 20;

      community_section_top_margin = 0.03;
      community_text_top_margin = 0.02;
      community_text_fontSize = 21;

      community_cont_height = 0.23;
      community_cont_width = 1;
      community_cont_top_margin = 0.04; 

      profile_bottom_margin = 0.02; 
      member_name_bottom_margin = 0.01; 
      print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        member_Section_fonsize = 200;

        profile_image_radius = 45;

        spacer = 5;

        name_fonSize = 13;
        contact_icon_fonSize = 16;

        contact_fontSiz = 11;

        ford_back_iconSize = 20;

        community_section_top_margin = 0.03;
        community_text_top_margin = 0.02;
        community_text_fontSize = 18;

        community_cont_height = 0.21;
        community_cont_width = 1;
        community_cont_top_margin = 0.02; 

        profile_bottom_margin = 0.02; 

        print('800');
      }
    if (context.width < 700) {
        member_Section_fonsize = 200;

        profile_image_radius = 45;

        spacer = 5;

        name_fonSize = 13;
        contact_icon_fonSize = 16;

        contact_fontSiz = 11;

        ford_back_iconSize = 18;

        community_section_top_margin = 0.03;
        community_text_top_margin = 0.02;
        community_text_fontSize = 18;

        community_cont_height = 0.21;
        community_cont_width = 1;
        community_cont_top_margin = 0.02; 

        profile_bottom_margin = 0.02; 

        print('700');
      }

    // SMALL TABLET:
    if (context.width < 640) {
        member_Section_fonsize = 200;

        profile_image_radius = 35;

        spacer = 5;

        name_fonSize = 12;
        contact_icon_fonSize = 16;

        contact_fontSiz = 11;

        ford_back_iconSize = 16;

        community_section_top_margin = 0.02;
        community_text_top_margin = 0.02;
        community_text_fontSize = 16;

        community_cont_height = 0.18;
        community_cont_width = 1;
        community_cont_top_margin = 0.02; 

        profile_bottom_margin = 0.02; 

      print('640');
      }

    // PHONE:
    if (context.width < 480) {
        member_Section_fonsize = 200;

        profile_image_radius = 30;

        spacer = 5;

        name_fonSize = 12;
        contact_icon_fonSize = 16;

        contact_fontSiz = 11;

        ford_back_iconSize = 14;

        community_section_top_margin = 0.01;
        community_text_top_margin = 0.01;
        community_text_fontSize = 16;

        community_cont_height = 0.15;
        community_cont_width = 1;
        community_cont_top_margin = 0.02; 

        profile_bottom_margin = 0.01; 

      }


    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: context.height * community_section_top_margin),
              child: Row(
                children: [
                  
                  // BACKWORD  BUTTON :
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                      buttonCarouselController.previousPage();},
                      icon: Icon(
                        CupertinoIcons.left_chevron,
                        size: ford_back_iconSize,
                      ))),
      
      
               
                  // COMMUNITY SECTION :
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                          top: context.height * community_text_top_margin),
                      child: RichText(
                          text: TextSpan(
                              style: GoogleFonts.robotoSlab(
                                color: light_color_type3,
                                fontSize: community_text_fontSize,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                              text: 'COMMUNITY')),
                    ),
                  ),
      
                
                
                  // FORWORD BUTTON:
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                      buttonCarouselController.nextPage();},
                      icon: Icon(
                        CupertinoIcons.right_chevron,
                        size: ford_back_iconSize,
                      ))),
                ],
              ),
            ),
      
      
      
            //  COMMUNITY SECTION :
            Container(
              height: context.height * community_cont_height,
              width: context.width * community_cont_width,
              margin: EdgeInsets.only(top: context.height * community_cont_top_margin),
              
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: 5,
                  itemBuilder: ((context, index, realIndex) {
                    return Container(
                        child: SingleChildScrollView(
                          child: Column(
                                              children: [
                          
                          ProfileImage(),
                          
                          SizedBox(
                            height: context.height * profile_bottom_margin,
                          ),
                          
                          MemName(
                              user_position: 'Founder', username: 'Vishal shakaya'),
                          
                          SizedBox(
                            height: context.height * member_name_bottom_margin,
                          ),
                              
                          MemContact(text: 'Founder', icon: Icons.person)
                                              ],
                                              
                                            ),
                        ));
                  }),
      
                  options: CarouselOptions(
                      height: context.height * 0.67, viewportFraction: 1)),
            ),
          ],
        ),
      ),
    );
  }



  Card ProfileImage() {
    return Card(
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(150),
          right: Radius.circular(150),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: profile_image_radius,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(temp_avtar_image),
      )),
    );
  }



  Tooltip MemName({required username, required user_position}) {
    return Tooltip(
      message: user_position,
      child: Container(
          child: AutoSizeText.rich(
              TextSpan(style: Get.textTheme.headline5, children: [
        TextSpan(
            text: username,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: home_profile_contact_color,
                fontSize: name_fonSize))
      ]))),
    );
  }



  Container MemContact({required text, required icon, func}) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            icon,
            color: Colors.orange.shade800,
            size: name_fonSize,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: text,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: home_profile_contact_color,
                  fontSize: name_fonSize))
        ])),
      ],
    ));
  }
}
