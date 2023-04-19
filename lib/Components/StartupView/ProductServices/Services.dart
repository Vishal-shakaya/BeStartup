import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import './ProductDetailDialog.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:url_launcher/url_launcher.dart';

class Services extends StatefulWidget {
  var service;
  Services({
    this.service,
    Key? key,
  }) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  double image_cont_width = 0.20;
  double phone_image_cont_width = 0.20;

  double image_cont_height = 0.27;
  double phone_image_cont_height = 0.27;

  double image_radius = 15;
  double phone_image_radius = 15;

  double desc_cont_width = 0.41;
  double phone_desc_cont_width = 0.41;

  double desc_cont_height = 0.25;
  double phone_desc_cont_height = 0.25;

  double image_radius_width = 2;
  double phone_image_radius_width = 2;

  double mem_dialog_width = 0.60;
  double phone_mem_dialog_width = 0.60;

  double bottom_spacer = 50;
  double phone_bottom_spacer = 50;

  double product_desc_padd = 10;
  double phone_product_desc_padd = 10;

  double product_desc_left_marg = 0.05;
  double phone_product_desc_left_marg = 0.05;

  double product_left_radius = 20;
  double phone_product_left_radius = 20;

  double product_right_radius = 20;
  double phone_product_right_radius = 20;

  double product_title_fontSize = 20;
  double phone_product_title_fontSize = 20;

  double product_desc_fontSize = 14;
  double phone_product_desc_fontSize = 14;

  double product_desc_word_spacing = 2;
  double phone_product_desc_word_spacing = 2;

  double product_desc_text_height = 1.8;
  double phone_product_desc_text_height = 1.8;

  int product_desc_maxlines = 5;
  int phone_product_desc_maxlines = 5;

  double imp_links_width = 0.35;
  double phone_imp_links_width = 0.35;

  double img_link_height = 50;
  double phone_img_link_height = 50;

  double play_icon_padd = 5.0;
  double phone_play_icon_padd = 5.0;

  double play_icon_radius = 12;
  double phone_play_icon_radius = 12;

  double play_icon_fontSize = 25;
  double phone_play_icon_fontSize = 25;

  double link_icon_radius = 8;
  double phone_link_icon_radius = 8;

  double product_title_bottom_padding = 5;
  double phone_product_title_bottom_padding = 5;

  double phone_prod_top_margin = 0.01;

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

  // Redirect to youtube video :
  YoutubeLink() async {
    var url = widget.service['youtube_link'];
    url = Uri.parse(url);
    final resp = await launchInBrowser(url);
  }

  // Redirect user to detail page ;
  DocumentLink() async {
    var url = widget.service['content_link'];
    url = Uri.parse(url);
    final resp = await launchInBrowser(url);
  }

  @override
  Widget build(BuildContext context) {
      image_cont_width = 0.20;
    image_cont_height = 0.27;

    image_radius = 15;

    desc_cont_width = 0.41;
    desc_cont_height = 0.25;

    image_radius_width = 2;

    mem_dialog_width = 0.60;

    bottom_spacer = 50;

    product_desc_padd = 10;

    product_desc_left_marg = 0.05;

    product_left_radius = 20;

    product_right_radius = 20;

    product_title_fontSize = 20;

    product_desc_fontSize = 14;

    product_desc_word_spacing = 2;

    product_desc_text_height = 1.8;

    product_desc_maxlines = 5;

    imp_links_width = 0.35;

    img_link_height = 50;

    play_icon_padd = 5.0;

    play_icon_radius = 12;

    play_icon_fontSize = 25;

    link_icon_radius = 8;

    product_title_bottom_padding = 0;
    phone_prod_top_margin = 0.01;
    // DEFAULT :
    if (context.width > 1700) {
      image_cont_width = 0.20;
      image_cont_height = 0.27;

      image_radius = 15;

      desc_cont_width = 0.41;
      desc_cont_height = 0.25;

      image_radius_width = 2;

      mem_dialog_width = 0.60;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.05;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 14;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 5;

      imp_links_width = 0.35;

      img_link_height = 50;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 25;

      link_icon_radius = 8;
      product_title_bottom_padding = 0;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      image_cont_width = 0.22;
      image_cont_height = 0.27;

      image_radius = 15;

      desc_cont_width = 0.42;
      desc_cont_height = 0.25;

      image_radius_width = 2;

      mem_dialog_width = 0.60;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.03;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 14;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 5;

      imp_links_width = 0.35;

      img_link_height = 50;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 25;

      link_icon_radius = 8;
      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
      image_cont_width = 0.23;
      image_cont_height = 0.27;

      image_radius = 15;

      desc_cont_width = 0.45;
      desc_cont_height = 0.25;

      image_radius_width = 2;

      mem_dialog_width = 0.70;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.03;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 14;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 5;

      imp_links_width = 0.35;

      img_link_height = 50;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 25;

      link_icon_radius = 8;
      print('1500');
    }

    if (context.width < 1300) {
      image_cont_width = 0.23;
      image_cont_height = 0.25;

      image_radius = 15;

      desc_cont_width = 0.45;
      desc_cont_height = 0.25;

      image_radius_width = 2;

      mem_dialog_width = 0.70;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.03;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 14;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 5;

      imp_links_width = 0.35;

      img_link_height = 50;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 25;

      link_icon_radius = 8;
      print('1300');
    }

    if (context.width < 1200) {
      image_cont_width = 0.28;
      image_cont_height = 0.23;

      image_radius = 15;

      desc_cont_width = 0.47;
      desc_cont_height = 0.23;

      image_radius_width = 2;

      mem_dialog_width = 0.80;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.03;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 14;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 4;

      imp_links_width = 0.35;

      img_link_height = 50;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 25;

      link_icon_radius = 8;
      print('1200');
    }

    if (context.width < 1000) {
      image_cont_width = 0.31;
      image_cont_height = 0.21;

      image_radius = 15;

      desc_cont_width = 0.47;
      desc_cont_height = 0.20;

      image_radius_width = 2;

      mem_dialog_width = 0.80;

      bottom_spacer = 50;

      product_desc_padd = 10;

      product_desc_left_marg = 0.03;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 13;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 4;

      imp_links_width = 0.35;

      img_link_height = 35;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 20;

      link_icon_radius = 6;

      product_title_bottom_padding = 5;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      image_cont_width = 0.34;
      image_cont_height = 0.20;

      image_radius = 12;

      desc_cont_width = 0.52;
      desc_cont_height = 0.20;

      image_radius_width = 2;

      mem_dialog_width = 0.95;

      bottom_spacer = 40;

      product_desc_padd = 10;

      product_desc_left_marg = 0.02;

      product_left_radius = 20;

      product_right_radius = 20;

      product_title_fontSize = 20;

      product_desc_fontSize = 12;

      product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;

      product_desc_maxlines = 4;

      imp_links_width = 0.60;

      img_link_height = 35;

      play_icon_padd = 5.0;

      play_icon_radius = 12;

      play_icon_fontSize = 20;

      link_icon_radius = 6;

      product_title_bottom_padding = 5;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      image_cont_width = 0.34;

      phone_image_cont_width = 0.50;

      image_cont_height = 0.27;
      phone_image_cont_height = 0.20;

      image_radius = 15;
      phone_image_radius = 15;

      desc_cont_width = 0.41;
      phone_desc_cont_width = 0.80;

      desc_cont_height = 0.25;
      phone_desc_cont_height = 0.20;

      image_radius_width = 2;
      phone_image_radius_width = 2;

      mem_dialog_width = 0.98;
      phone_mem_dialog_width = 0.60;

      bottom_spacer = 50;
      phone_bottom_spacer = 50;

      product_desc_padd = 10;
      phone_product_desc_padd = 10;

      product_desc_left_marg = 0.05;
      phone_product_desc_left_marg = 0.00;

      product_left_radius = 20;
      phone_product_left_radius = 10;

      product_right_radius = 20;
      phone_product_right_radius = 10;

      product_title_fontSize = 16;
      phone_product_title_fontSize = 16;

      product_desc_fontSize = 14;
      phone_product_desc_fontSize = 12;

      product_desc_word_spacing = 2;
      phone_product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;
      phone_product_desc_text_height = 1.8;

      product_desc_maxlines = 5;
      phone_product_desc_maxlines = 4;

      imp_links_width = 0.35;
      phone_imp_links_width = 0.80;

      img_link_height = 50;
      phone_img_link_height = 35;

      play_icon_padd = 5.0;
      phone_play_icon_padd = 2.0;

      play_icon_radius = 12;
      phone_play_icon_radius = 12;

      play_icon_fontSize = 25;
      phone_play_icon_fontSize = 20;

      link_icon_radius = 8;
      phone_link_icon_radius = 7;

      product_title_bottom_padding = 5;
      phone_product_title_bottom_padding = 5;
      phone_prod_top_margin = 0.01;

      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      image_cont_width = 0.34;

      phone_image_cont_width = 0.60;

      image_cont_height = 0.27;
      phone_image_cont_height = 0.22;

      image_radius = 15;
      phone_image_radius = 15;

      desc_cont_width = 0.41;
      phone_desc_cont_width = 0.90;

      desc_cont_height = 0.25;
      phone_desc_cont_height = 0.23;

      image_radius_width = 2;
      phone_image_radius_width = 2;

      mem_dialog_width = 1;
      phone_mem_dialog_width = 1;

      bottom_spacer = 50;
      phone_bottom_spacer = 50;

      product_desc_padd = 10;
      phone_product_desc_padd = 10;

      product_desc_left_marg = 0.05;
      phone_product_desc_left_marg = 0.00;

      product_left_radius = 20;
      phone_product_left_radius = 10;

      product_right_radius = 20;
      phone_product_right_radius = 10;

      product_title_fontSize = 16;
      phone_product_title_fontSize = 15;

      product_desc_fontSize = 14;
      phone_product_desc_fontSize = 12;

      product_desc_word_spacing = 2;
      phone_product_desc_word_spacing = 2;

      product_desc_text_height = 1.8;
      phone_product_desc_text_height = 1.8;

      product_desc_maxlines = 5;
      phone_product_desc_maxlines = 4;

      imp_links_width = 0.35;
      phone_imp_links_width = 0.80;

      img_link_height = 50;
      phone_img_link_height = 20;

      play_icon_padd = 5.0;
      phone_play_icon_padd = 2.0;

      play_icon_radius = 12;
      phone_play_icon_radius = 12;

      play_icon_fontSize = 25;
      phone_play_icon_fontSize = 18;

      link_icon_radius = 8;
      phone_link_icon_radius = 6;

      product_title_bottom_padding = 5;
      phone_product_title_bottom_padding = 4;

      phone_prod_top_margin = 0.02;
      print('480');
    }

    // PRODUT DEATIL DIALOG :
    ProductDetailView() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            // contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(12),
              title: Container(
                alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.blueGrey.shade800,
                        size: 18,
                      ))),
              content: SizedBox(
                  width: context.width * mem_dialog_width,
                  child: ProductDetailDialog(
                    heading: widget.service['title'].toString().capitalizeFirst,
                    detail: widget.service['description'],
                    image: widget.service['image_url'],
                  ))));
    }


    Widget mainProductWrap = Wrap(
      children: [
        ProductDescription(context, desc_cont_width, desc_cont_height),

        // Produt Dialog :
        InkWell(
            onTap: () {
              ProductDetailView();
            },

            // PRODUCT iMAGE :
            child: ProductImage(context, image_cont_width, image_cont_height)),
        // DESCRIPTION :
      ],
    );

    Widget phoneProductColumn = Column(
      children: [
        // Produt Dialog :
        InkWell(
            onTap: () {
              ProductDetailView();
            },
            // PRODUCT iMAGE :
            child: PhoneProductImage(
                context, phone_image_cont_width, phone_image_cont_height)),

        // DESCRIPTION :
        PhoneProductDescription(
            context, phone_desc_cont_width, phone_desc_cont_height)
      ],
    );

    if (context.width < 640) {
      mainProductWrap = phoneProductColumn;
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            mainProductWrap,
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Container ProductDescription(
      BuildContext context, double desc_cont_width, double desc_cont_height) {
    return Container(
        padding: EdgeInsets.all(product_desc_padd),
        margin: EdgeInsets.only(right: context.width * product_desc_left_marg),
        width: context.width * desc_cont_width,
        height: context.height * desc_cont_height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(product_left_radius),
              right: Radius.circular(product_right_radius),
            ),
            border: Border.all(width: 1, color: startup_container_border_color)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: product_title_bottom_padding),
                child: RichText(
                  text: TextSpan(children: [
                    // Heading Texct :
                    TextSpan(
                      text: widget.service['title'],
                      style: GoogleFonts.robotoSlab(
                        color: startup_title_text_color,
                        fontSize: product_title_fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        
              // Description:
              Container(
                child: AutoSizeText.rich(
                  TextSpan(
                    text: widget.service['description'],
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                        color: startup_text_color,
                        fontSize: product_desc_fontSize,
                        fontWeight: FontWeight.w600,
                        wordSpacing: product_desc_word_spacing,
                        height: product_desc_text_height),
                  ),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: product_desc_maxlines,
                ),
              ),
        
              // Important Links :
              Container(
                  width: context.width * imp_links_width,
                  height: img_link_height,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ////////////////////////////////
                      // Video Play Button :
                      ////////////////////////////////
                      Padding(
                        padding: EdgeInsets.all(play_icon_padd),
                        child: Tooltip(
                          message: 'play video',
                          child: IconButton(
                              onPressed: () async {
                                await YoutubeLink();
                              },
                              icon: GlowIcon(Icons.play_circle_fill,
                                  blurRadius: play_icon_radius,
                                  color: Colors.red.shade300,
                                  size: play_icon_fontSize)),
                        ),
                      ),
        
                      /////////////////////////
                      // Content Link:
                      /////////////////////////
                      Padding(
                        padding: EdgeInsets.all(play_icon_padd),
                        child: Tooltip(
                          message: 'content detail',
                          child: IconButton(
                              onPressed: () async {
                                await DocumentLink();
                              },
                              icon: GlowIcon(
                                Icons.link_rounded,
                                blurRadius: link_icon_radius,
                                color: Colors.blue.shade300,
                                size: play_icon_fontSize,
                              )),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Card ProductImage(
      BuildContext context, double image_cont_width, double image_cont_height) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(image_radius),
          right: Radius.circular(image_radius),
        ),
      ),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(image_radius),
            right: Radius.circular(image_radius),
          ),
          child: Image.network(widget.service['image_url'],
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.cover),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(image_radius),
              right: Radius.circular(image_radius),
            ),
            border: Border.all(
                width: image_radius_width, color: Colors.grey.shade200)),
      ),
    );
  }

  Container PhoneProductDescription(BuildContext context,
      double phone_desc_cont_width, double phone_desc_cont_height) {
    return Container(
        padding: EdgeInsets.all(phone_product_desc_padd),
        margin: EdgeInsets.only(
            top: context.height * phone_prod_top_margin,
            right: context.width * phone_product_desc_left_marg),
    
        width: context.width * phone_desc_cont_width,
        height: context.height * phone_desc_cont_height,
       
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(phone_product_left_radius),
              right: Radius.circular(phone_product_right_radius),
            ),
            border: Border.all(width: 1, color:startup_container_border_color)),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(bottom: phone_product_title_bottom_padding),
              child: RichText(
                text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: widget.service['title'],
                    style: GoogleFonts.robotoSlab(
                      color: startup_title_text_color,
                      fontSize: phone_product_title_fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Description:
            Container(
              child: AutoSizeText.rich(
                TextSpan(
                  text: widget.service['description'],
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: startup_text_color,
                      fontSize: phone_product_desc_fontSize,
                      fontWeight: FontWeight.w600,
                      wordSpacing: phone_product_desc_word_spacing,
                      height: phone_product_desc_text_height),
                ),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: phone_product_desc_maxlines,
              ),
            ),

            // Important Links :
            Container(
                width: context.width * phone_imp_links_width,
                height: phone_img_link_height,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ////////////////////////////////
                    // Video Play Button :
                    ////////////////////////////////
                    Padding(
                      padding: EdgeInsets.all(play_icon_padd),
                      child: Tooltip(
                        message: 'play video',
                        child: IconButton(
                            onPressed: () async {
                              await YoutubeLink();
                            },
                            icon: GlowIcon(Icons.play_circle_fill,
                                blurRadius: phone_play_icon_radius,
                                color: Colors.red.shade300,
                                size: phone_play_icon_fontSize)),
                      ),
                    ),

                    /////////////////////////
                    // Content Link:
                    /////////////////////////
                    Padding(
                      padding: EdgeInsets.all(play_icon_padd),
                      child: Tooltip(
                        message: 'content detail',
                        child: IconButton(
                            onPressed: () async {
                              await DocumentLink();
                            },
                            icon: GlowIcon(
                              Icons.link_rounded,
                              blurRadius: phone_link_icon_radius,
                              color: Colors.blue.shade300,
                              size: phone_play_icon_fontSize,
                            )),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  Card PhoneProductImage(BuildContext context, double phone_image_cont_width,
      double phone_image_cont_height) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(phone_image_radius),
          right: Radius.circular(phone_image_radius),
        ),
      ),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(phone_image_radius),
            right: Radius.circular(phone_image_radius),
          ),
          child: Image.network(widget.service['image_url'],
              width: context.width * phone_image_cont_width,
              height: context.height * phone_image_cont_height,
              fit: BoxFit.fill),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(phone_image_radius),
              right: Radius.circular(phone_image_radius),
            ),
            border: Border.all(
                width: phone_image_radius_width, color: Colors.grey.shade200)),
      ),
    );
  }
}
