import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
		// DEFAULT :
    if (context.width > 1700) {
      print('Greator then 1700');
      }
  
    if (context.width < 1700) {
      print('1700');
      }
  
    if (context.width < 1600) {
      print('1600');
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
      print('480');
      }


    return Container(
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
                          buttonCarouselController.previousPage();
                        },
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
                          buttonCarouselController.nextPage();
                        },
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
                    
                  ));
                }),

                options: CarouselOptions(
                    height: context.height * 0.67, viewportFraction: 1)),
          ),
        ],
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



  InkWell MemContact({required text, required icon, func}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        await func();
      },
      child: Container(
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
      )),
    );
  }
}
