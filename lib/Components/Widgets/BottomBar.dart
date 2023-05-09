import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Color facebooHoverkColor = Colors.blue;
  Color twitterHoverColor = Colors.lightBlue.shade200;
  Color youtubeHoverColor = Colors.red;
  Color linkdilnHoverColor = Colors.blue.shade600;
  Color instagramHoverColor = Colors.pinkAccent;

  Color facebookColor = Colors.blueGrey.shade100;
  Color twitterColor = Colors.blueGrey.shade100;
  Color youtubeColor = Colors.blueGrey.shade100;
  Color linkdilnColor = Colors.blueGrey.shade100;
  Color instagramColor = Colors.blueGrey.shade100;

  Color defaultColor = Colors.blueGrey.shade100;
  Color linkDefaultColor = Colors.blueGrey.shade200;

  Color feedbackColor = Colors.blueGrey.shade200;
  Color aboutColor = Colors.blueGrey.shade200;
  Color featureColor = Colors.blueGrey.shade200;
  Color contactColor = Colors.blueGrey.shade200;

  Color officialMailColor = Colors.orangeAccent;
  Color phonenoColor = Colors.orangeAccent;

  Color secondaryLinkDefaultColor = Colors.orangeAccent;

  Color secondaryLinkActiveColor = Colors.orangeAccent.shade700;

  double header_text_fontSize = 25;
  double hearder_text_top_margin = 0.04;

  double bottomBar_top_margin = 0.05;
  double bottomBar_height = 0.30;

  double bottomBar_cont_height = 0.22;

  double logo_top_margin = 0.02;
  double logo_height = 100;
  double logo_width = 250;

  double social_cont_width = 0.20;
  double social_cont_top_margin = 0.02;
  double social_fontSize = 16;

  double comp_text_height = 0.02;
  double comp_text_fontSize = 15;

  double address_fontSize = 17;

  double license_height = 0.07;
  double license_fontSize = 12;

  //////////////////////////////////////////////
  /// SOCIAL URLS :
  //////////////////////////////////////////////
  var youtube_url = '';
  var linkdiln_url =
      '';
  var instagram_url = '';
  var facebook_url = '';
  var twitter_url = '';

  /////////////////////////////////////////////
  /// COMPANY SECTION :
  /////////////////////////////////////////////
  var team_url = 'https://www.linkedin.com/in/vishal-shakaya-0a5b561b1/';

  // Open link in web :
  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  // Redirect user to detail page ;
  DocumentLink({url}) async {
    url = Uri.parse(url);
    final resp = await launchInBrowser(url);
  }

  @override
  Widget build(BuildContext context) {
    header_text_fontSize = 25;
    hearder_text_top_margin = 0.04;

    bottomBar_top_margin = 0.05;
    bottomBar_height = 0.30;

    bottomBar_cont_height = 0.22;

    logo_top_margin = 0.02;
    logo_height = 100;
    logo_width = 250;

    social_cont_width = 0.20;
    social_cont_top_margin = 0.02;
    social_fontSize = 16;

    comp_text_height = 0.02;
    comp_text_fontSize = 15;

    address_fontSize = 17;

    license_height = 0.07;
    license_fontSize = 12;

    // DEFAULT :
    if (context.width > 1700) {
      header_text_fontSize = 25;
      hearder_text_top_margin = 0.04;

      bottomBar_top_margin = 0.05;
      bottomBar_height = 0.30;

      bottomBar_cont_height = 0.22;

      logo_top_margin = 0.02;
      logo_height = 100;
      logo_width = 250;

      social_cont_width = 0.20;
      social_cont_top_margin = 0.02;

      comp_text_height = 0.02;
      comp_text_fontSize = 15;

      address_fontSize = 17;

      license_height = 0.07;
      license_fontSize = 12;

      social_fontSize = 16; 
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
      header_text_fontSize = 22;
      hearder_text_top_margin = 0.04;

      bottomBar_top_margin = 0.05;
      bottomBar_height = 0.30;

      bottomBar_cont_height = 0.22;

      logo_top_margin = 0.02;
      logo_height = 80;
      logo_width = 220;

      social_cont_width = 0.25;
      social_cont_top_margin = 0.02;
      social_fontSize = 15; 

      comp_text_height = 0.02;
      comp_text_fontSize = 13;

      address_fontSize = 15;

      license_height = 0.07;
      license_fontSize = 12;

      print('1200');
    }

    if (context.width < 1000) {
      header_text_fontSize = 20;
      hearder_text_top_margin = 0.04;

      bottomBar_top_margin = 0.05;
      bottomBar_height = 0.30;

      bottomBar_cont_height = 0.22;

      logo_top_margin = 0.02;
      logo_height = 80;
      logo_width = 200;

      social_cont_width = 0.35;
      social_cont_top_margin = 0.02;
      social_fontSize = 14; 

      comp_text_height = 0.02;
      comp_text_fontSize = 13;

      address_fontSize = 14;

      license_height = 0.07;
      license_fontSize = 11;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      header_text_fontSize = 17;
      hearder_text_top_margin = 0.04;

      bottomBar_top_margin = 0.05;
      bottomBar_height = 0.30;

      bottomBar_cont_height = 0.22;

      logo_top_margin = 0.02;
      logo_height = 70;
      logo_width = 180;

      social_cont_width = 0.60;
      social_cont_top_margin = 0.02;
      social_fontSize = 13; 

      comp_text_height = 0.02;
      comp_text_fontSize = 13;

      address_fontSize = 14;

      license_height = 0.07;
      license_fontSize = 12;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      header_text_fontSize = 16;
      hearder_text_top_margin = 0.04;

      bottomBar_top_margin = 0.05;
      bottomBar_height = 0.30;

      bottomBar_cont_height = 0.22;

      logo_top_margin = 0.02;
      logo_height = 70;
      logo_width = 160;

      social_cont_width = 0.60;
      social_cont_top_margin = 0.02;
      social_fontSize = 12; 

      comp_text_height = 0.02;
      comp_text_fontSize = 12;

      address_fontSize = 12;

      license_height = 0.05;
      license_fontSize = 11;
      print('480');
    }

    return Container(
        margin: EdgeInsets.only(top: context.height * bottomBar_top_margin),
        height: context.height * bottomBar_height,
        color: Get.isDarkMode
            ? Colors.blueGrey.shade700
            : Colors.blueGrey.shade900,
        child: Column(
          children: [
            Container(
              height: context.height * bottomBar_cont_height,
              child: Row(
                children: [
                  // Logo and Social Button :
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Startup Icon Block :
                              Container(
                                margin: EdgeInsets.only(
                                    top: context.height * logo_top_margin),
                                child: Image.asset(logo_image,
                                    height: logo_height,
                                    width: logo_width,
                                    fit: BoxFit.contain),
                              ),
                        
                              // Startup Socail Button :
                              Container(
                                width: context.width * social_cont_width,
                                // alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(
                                    top: context.height * social_cont_top_margin),
                                child: Wrap(
                                  alignment : WrapAlignment.center,
                                  children: [
                                    // FACEBOOK LINK:
                                    MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          facebookColor = facebooHoverkColor;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          facebookColor = defaultColor;
                                        });
                                      },
                                      child: IconButton(
                                        padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            DocumentLink(url: facebook_url);
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.facebookF,
                                            size: social_fontSize,
                                            color: facebookColor,
                                          )),
                                    ),
                        
                                    // TWITTER LINK :
                                    MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          twitterColor = twitterHoverColor;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          twitterColor = defaultColor;
                                        });
                                      },
                                      child: IconButton(
                                         padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            DocumentLink(url: twitter_url);
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.twitter,
                                            size: social_fontSize,
                                            color: twitterColor,
                                          )),
                                    ),
                        
                                    // INSTAGRAM  LINK :
                                    MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          instagramColor = instagramHoverColor;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          instagramColor = defaultColor;
                                        });
                                      },
                                      child: IconButton(
                                         padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            DocumentLink(url: instagram_url);
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.instagram,
                                            size: social_fontSize,
                                            color: instagramColor,
                                          )),
                                    ),
                        
                                    // LINKEDIN LINK :
                                    MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          linkdilnColor = linkdilnHoverColor;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          linkdilnColor = defaultColor;
                                        });
                                      },
                                      child: IconButton(
                                         padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            DocumentLink(url: linkdiln_url);
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.linkedinIn,
                                            size: social_fontSize,
                                            color: linkdilnColor,
                                          )),
                                    ),
                        
                                    // YOUTUBE LINK :
                                    MouseRegion(
                                      onHover: (_) {
                                        setState(() {
                                          youtubeColor = youtubeHoverColor;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          youtubeColor = defaultColor;
                                        });
                                      },
                                      child: IconButton(
                                         padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            DocumentLink(url: youtube_url);
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.youtube,
                                            size: social_fontSize,
                                            color: youtubeColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),

                  /////////////////////////////////
                  ///  Complany Section :
                  /////////////////////////////////
                  Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // HEADER TEXT :
                            HeaderText(context, 'Company'),
                      
                            // Feedback Text Link :
         
                      
                            // About Text Link :
                            MouseRegion(
                                onHover: (_) {
                                  setState(() {
                                    aboutColor = defaultColor;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    aboutColor = linkDefaultColor;
                                  });
                                },
                                child: InkWell(
                                  onTap: () {
                                    DocumentLink(url: team_url);
                                  },
                                  child: InfoText(
                                      height: context.height * comp_text_height,
                                      text: 'about us',
                                      size: comp_text_fontSize,
                                      color: aboutColor),
                                )),
                      
                            // Feature Text Link :
                            MouseRegion(
                              onHover: (_) {
                                setState(() {
                                  featureColor = defaultColor;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  featureColor = linkDefaultColor;
                                });
                              },
                              child: InfoText(
                                  height: context.height * comp_text_height,
                                  text: 'feature',
                                  size: comp_text_fontSize,
                                  color: featureColor),
                            ),
                                MouseRegion(
                                onHover: (_) {
                                  setState(() {
                                    feedbackColor = defaultColor;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    feedbackColor = linkDefaultColor;
                                  });
                                },
                                child: InfoText(
                                    height: context.height * comp_text_height,
                                    text: 'feedback@sharkstartup.in',
                                    size: comp_text_fontSize,
                                    color: feedbackColor)),
                          ],
                        ),
                      )),

                  //////////////////////////////////////
                  /// CONTACT SECTION :
                  //////////////////////////////////////
                  Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Header Text :
                            HeaderText(context, 'Contact'),
                      
                            // Address Text :
                            MouseRegion(
                                onHover: (_) {
                                  setState(() {
                                    contactColor = defaultColor;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    contactColor = linkDefaultColor;
                                  });
                                },
                                child: InfoText(
                                    height: context.height * comp_text_height,
                                    text: 'Indaia , New Delhi, 110059',
                                    size: comp_text_fontSize,
                                    color: contactColor)),
                      
                            // Official Mail Address :
                            MouseRegion(
                                onHover: (_) {
                                  setState(() {
                                    officialMailColor = secondaryLinkActiveColor;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    officialMailColor = secondaryLinkDefaultColor;
                                  });
                                },
                                child: InfoText(
                                    height: context.height * comp_text_height,
                                    text: 'contact@sharkstartup.in',
                                    size: address_fontSize,
                                    color: officialMailColor)),
                      
                            // Officail Contact No :
                            MouseRegion(
                                onHover: (_) {
                                  setState(() {
                                    phonenoColor = secondaryLinkActiveColor;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    phonenoColor = secondaryLinkDefaultColor;
                                  });
                                },
                                child: InfoText(
                                    height: context.height * comp_text_height,
                                    text: '+91 7065121120',
                                    size: address_fontSize,
                                    color: phonenoColor)),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            /////////////////////////////////////
            // Copyright and licence:
            /////////////////////////////////////
            Container(
              height: context.height * license_height,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text: copyright_text,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.blueGrey.shade100,
                            fontSize: license_fontSize,
                            fontWeight: FontWeight.normal
                          ))
                    ])))
                  ]),
            ),
          ],
        ));
  }

  Container InfoText({height, text, color, size}) {
    return Container(
      margin: EdgeInsets.only(top: height),
      child: AutoSizeText(
        '$text',
        style: GoogleFonts.robotoSlab(
          textStyle: TextStyle(),
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w400,
        
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container HeaderText(BuildContext context, text) {
    return Container(
      margin: EdgeInsets.only(top: context.height * hearder_text_top_margin),
      child: AutoSizeText(
        '$text',
        style: GoogleFonts.merriweather(
          textStyle: TextStyle(),
          color: Colors.white,
          fontSize: header_text_fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
