import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberDetailDialog extends StatelessWidget {
  var investor;
  MemberDetailDialog({this.investor, Key? key}) : super(key: key);

  int image_flext = 5;
  int detail_flex = 5;

  double width_fraction = 0.9;
  double height_fraction = 0.60; 

  double con_button_width = 55;
  double con_button_height = 30;
  double con_btn_top_margin = 10;

  double formfield_width = 400;
  double contact_formfield_width = 400;
  double contact_text_margin_top = 0.05;

  double image_radius = 70;
  double image_card_elevation = 5;

  double image_cont_height = 150;
  double image_cont_width = 160;

  double member_info_fontSize = 14;

  double member_desc_fontSize = 14;
  double member_desc_top_margin = 20;

  int member_desc_maxlines = 10;

  String upload_image_url = '';
  // CLOSE DIALOG :
  CloseDialog(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

       image_flext = 5;
       detail_flex = 5;

       width_fraction = 0.9;
       height_fraction = 0.60; 

       con_button_width = 55;
       con_button_height = 30;
       con_btn_top_margin = 10;

       formfield_width = 400;
       contact_formfield_width = 400;
       contact_text_margin_top = 0.05;

       image_radius = 70;
       image_card_elevation = 5;

       image_cont_height = 150;
       image_cont_width = 160;

       member_info_fontSize = 14;

       member_desc_fontSize = 14;
       member_desc_top_margin = 20;

       member_desc_maxlines = 10;

		// DEFAULT :
    if (context.width > 1700) {
        image_flext = 5;
        detail_flex = 5;

        width_fraction = 0.9;
        height_fraction = 0.60; 

        con_button_width = 55;
        con_button_height = 30;
        con_btn_top_margin = 10;

        formfield_width = 400;
        contact_formfield_width = 400;
        contact_text_margin_top = 0.05;

        image_radius = 70;
        image_card_elevation = 5;

        image_cont_height = 150;
        image_cont_width = 160;

        member_info_fontSize = 14;

        member_desc_fontSize = 14;
        member_desc_top_margin = 20;

        member_desc_maxlines = 10;
      print('Greator then 1700');
      }
  
    if (context.width < 1700) {
        image_flext = 5;
        detail_flex = 5;

        width_fraction = 0.9;
        height_fraction = 0.60; 

        con_button_width = 55;
        con_button_height = 30;
        con_btn_top_margin = 10;

        formfield_width = 400;
        contact_formfield_width = 400;
        contact_text_margin_top = 0.05;

        image_radius = 70;
        image_card_elevation = 5;

        image_cont_height = 150;
        image_cont_width = 160;

        member_info_fontSize = 14;

        member_desc_fontSize = 14;
        member_desc_top_margin = 20;

        member_desc_maxlines = 10;
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
        image_flext = 5;
        detail_flex = 5;

        width_fraction = 0.9;
        height_fraction = 0.50; 

        con_button_width = 55;
        con_button_height = 30;
        con_btn_top_margin = 10;

        formfield_width = 400;
        contact_formfield_width = 400;
        contact_text_margin_top = 0.05;

        image_radius = 60;
        image_card_elevation = 5;

        image_cont_height = 150;
        image_cont_width = 160;

        member_info_fontSize = 13;

        member_desc_fontSize = 13;
        member_desc_top_margin = 20;

        member_desc_maxlines = 10;
      print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
        image_flext = 5;
        detail_flex = 5;

        width_fraction = 0.9;
        height_fraction = 0.50; 

        con_button_width = 55;
        con_button_height = 30;
        con_btn_top_margin = 10;

        formfield_width = 400;
        contact_formfield_width = 400;
        contact_text_margin_top = 0.05;

        image_radius = 50;
        image_card_elevation = 0;

        image_cont_height = 120;
        image_cont_width = 120;

        member_info_fontSize = 12;

        member_desc_fontSize = 12;
        member_desc_top_margin = 20;

        member_desc_maxlines = 10;
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
        image_flext = 5;
        detail_flex = 5;

        width_fraction = 0.9;
        height_fraction = 0.50; 

        con_button_width = 55;
        con_button_height = 30;
        con_btn_top_margin = 10;

        formfield_width = 400;
        contact_formfield_width = 400;
        contact_text_margin_top = 0.05;

        image_radius = 50;
        image_card_elevation = 0;

        image_cont_height = 120;
        image_cont_width = 120;

        member_info_fontSize = 12;

        member_desc_fontSize = 12;
        member_desc_top_margin = 20;

        member_desc_maxlines = 10;
      print('480');
      }

    return FractionallySizedBox(
      widthFactor: width_fraction,
      heightFactor:height_fraction,
      child: Container(
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SPACING :
              const SizedBox(
                height: 10,
              ),

              // MODEL HEADING :
              // HeaderText(context),

              // PROFILE IMAG AND INFO :

              Container(
                  child: Row(
                children: [
                  // INVESTOR PROFILE IMAGE :
                  Expanded(
                      flex: image_flext,
                      child:
                          ProfileImage(image: investor['image'] ?? temp_logo)),

                  // INVESTOR DETAIL SECTION :
                  Expanded(
                      flex: detail_flex,
                      child: Container(
                        width: formfield_width,
                        alignment: Alignment.center,
                        child: Container(
                          width: contact_formfield_width,
                          child: Column(
                            children: [
                              MemberInfoBlock(investor['name'] ?? ''),
                              MemberInfoBlock(investor['position'] ?? ''),
                              MemberInfoBlock(investor['email'] ?? ''),
                            ],
                          ),
                        ),
                      )),
                ],
              )),

              MemDescription(investor['info'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Container ProfileImage({image}) {
    return Container(
        width: image_cont_height,
        height: image_cont_width,
        // alignment: Alignment.center,
        child: Stack(
          children: [
            Card(
                elevation: image_card_elevation,
                shadowColor: light_color_type3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(85.0),
                ),
                child: image != ''
                    ? CircleAvatar(
                        radius: image_radius,
                        backgroundColor: Colors.blueGrey[100],
                        foregroundImage: NetworkImage(image),
                      )
                    : CircleAvatar(
                        radius: image_radius,
                        backgroundColor: Colors.blueGrey[100],
                        child: AutoSizeText(
                          'profile picture',
                          style: TextStyle(
                              color: light_color_type3,
                              fontWeight: FontWeight.bold),
                        ))),
          ],
        ));
  }

  Container MemDescription(detail) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: member_desc_top_margin),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border_color)),
      
      child: SingleChildScrollView(
        child: AutoSizeText.rich(
          TextSpan(
              text: detail,
              style: GoogleFonts.robotoSlab(
                textStyle: TextStyle(),
                color: light_color_type1,
                fontSize: member_desc_fontSize,
                fontWeight: FontWeight.w400,
              )),
          overflow: TextOverflow.ellipsis,
          maxLines: member_desc_maxlines,
        ),
      ),
    );
  }

  Container MemberInfoBlock(title) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.topLeft,
      child: AutoSizeText.rich(
        TextSpan(
            text: '$title',
            style: GoogleFonts.robotoSlab(
              textStyle: TextStyle(),
              color: light_color_type1,
              fontSize: member_info_fontSize,
              fontWeight: FontWeight.w600,
            )),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Row HeaderText(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topCenter,
            child: AutoSizeText.rich(TextSpan(
                style: Get.theme.textTheme.headline2,
                children: [TextSpan(text: 'Comlete Info')])),
          ),
        ),
        IconButton(
            onPressed: () {
              CloseDialog(context);
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.blueGrey.shade800,
            ))
      ],
    );
  }
}
