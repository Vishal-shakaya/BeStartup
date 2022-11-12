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
  double position_fontSize = 11;
  double contact_icon_fonSize = 16;

  double contact_fontSiz = 11;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: context.height * 0.03),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          buttonCarouselController.previousPage();
                        },
                        icon: Icon(CupertinoIcons.left_chevron))),
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: context.height * 0.02),
                    child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.robotoSlab(
                              color: light_color_type3,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                            text: 'COMMUNITY')),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          buttonCarouselController.nextPage();
                        },
                        icon: Icon(CupertinoIcons.right_chevron))),
              ],
            ),
          ),
          Container(
            height: context.height * 0.30,
            width: context.width * 30,
            margin: EdgeInsets.only(top: context.height * 0.06),
            child: CarouselSlider.builder(
                carouselController: buttonCarouselController,
                itemCount: 5,
                itemBuilder: ((context, index, realIndex) {
                  return Container(
                      child: Column(
                    children: [
                      ProfileImage(),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      MemName(
                          user_position: 'Founder', username: 'Vishal shakaya'),
                      SizedBox(
                        height: context.height * 0.01,
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
