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

  //////////////////////////////////////////////
  /// SOCIAL URLS :
  //////////////////////////////////////////////
  var youtube_url = 'https://www.youtube.com/channel/UCrBv8I0p1uAg-mVvHqn9K4A';
  var linkdiln_url =
      'https://www.linkedin.com/showcase/bestartup007/?viewAsMember=true';
  var instagram_url = 'https://www.instagram.com/besupofficial/';
  var facebook_url = 'https://www.facebook.com/profile.php?id=10008751034330';
  var twitter_url = 'https://twitter.com/BeSupOfficial';

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
    return Container(
        margin: EdgeInsets.only(top: 50),
        height: context.height * 0.30,
        color: Get.isDarkMode
            ? Colors.blueGrey.shade700
            : Colors.blueGrey.shade900,
        child: Column(
          children: [
            Container(
              height: context.height * 0.22,
              child: Row(
                children: [
                  // Logo and Social Button :
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Startup Icon Block :
                            Container(
                              margin:
                                  EdgeInsets.only(top: context.height * 0.02),
                              child: Image.asset(logo_image,
                                  height: 100, width: 250, fit: BoxFit.contain),
                            ),

                            // Startup Socail Button :
                            Container(
                              width: context.width * 0.11,
                              alignment: Alignment.centerRight,
                              margin:
                                  EdgeInsets.only(top: context.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        onPressed: () {
                                          DocumentLink(url: facebook_url);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebookF,
                                          size: 16,
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
                                        onPressed: () {
                                          DocumentLink(url: twitter_url);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.twitter,
                                          size: 16,
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
                                        onPressed: () {
                                          DocumentLink(url: instagram_url);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.instagram,
                                          size: 16,
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
                                        onPressed: () {
                                          DocumentLink(url: linkdiln_url);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.linkedinIn,
                                          size: 16,
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
                                        onPressed: () {
                                          DocumentLink(url: youtube_url);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          size: 16,
                                          color: youtubeColor,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),

                  /////////////////////////////////
                  ///  Complany Section :
                  /////////////////////////////////
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          // HEADER TEXT :
                          HeaderText(context, 'Company'),

                          // Feedback Text Link :
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
                                  height: context.height * 0.02,
                                  text: 'feedback',
                                  size: 15,
                                  color: feedbackColor)),

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
                                    height: context.height * 0.02,
                                    text: 'about us',
                                    size: 15,
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
                                height: context.height * 0.02,
                                text: 'feature',
                                size: 15,
                                color: featureColor),
                          ),
                        ],
                      )),

                  //////////////////////////////////////
                  /// CONTACT SECTION :
                  //////////////////////////////////////
                  Expanded(
                      flex: 3,
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
                                  height: context.height * 0.02,
                                  text: 'Indaia , New Delhi, 110059',
                                  size: 15,
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
                                  height: context.height * 0.02,
                                  text: 'official@bestartup.site',
                                  size: 17,
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
                                  height: context.height * 0.02,
                                  text: '+91 7065121120',
                                  size: 17,
                                  color: phonenoColor)),
                        ],
                      )),
                ],
              ),
            ),

            /////////////////////////////////////
            // Copyright and licence:
            /////////////////////////////////////
            Container(
              height: context.height * 0.07,
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
                            fontSize: 15,
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
      ),
    );
  }

  Container HeaderText(BuildContext context, text) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.04),
      child: AutoSizeText(
        '$text',
        style: GoogleFonts.merriweather(
          textStyle: TextStyle(),
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
