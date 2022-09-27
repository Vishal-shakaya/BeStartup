import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailDialog extends StatefulWidget {
  var heading;
  var detail;
  var image;

  ProductDetailDialog({this.heading, this.detail, this.image, Key? key})
      : super(key: key);

  @override
  State<ProductDetailDialog> createState() => _ProductDetailDialogState();
}

class _ProductDetailDialogState extends State<ProductDetailDialog> {
  // Image width and height :
  double image_cont_width = 0.17;
  double image_cont_height = 0.28;
  double image_cont_padd = 1;
  double image_radius = 20;

  double width_factor = 0.9;
  double height_factor = 0.60;

  double header_bottom_space = 0.05;
  double image_desc_space = 0.02;
  double heading_desc_height_space = 0.02;

  int image_flext = 3;
  int detail_flex = 6;

  int header_flex = 1;
  double header_fontSize = 20;

  double detail_height = 0.31;

  double desc_cont_padd = 10;
  double desc_cont_radius = 15;

  double desc_fontSize = 14;
  double desc_wordSpace = 2;
  double desc_height = 1.8;

  double desc_cont_width = 0.60;
  double desc_cont_height = 0.25;

  double heading_fontSize = 25;

//////////////////////////////////////
  // Phone Responsives Var :
//////////////////////////////////////

  double phone_image_cont_width = 0.17;
  double phone_image_cont_height = 0.28;
  double phone_image_cont_padd = 1;
  double phone_image_radius = 20;

  double phone_width_factor = 0.9;
  double phone_height_factor = 0.60;

  double phone_header_bottom_space = 0.05;
  double phone_image_desc_space = 0.02;
  double phone_heading_desc_height_space = 0.02;

  int phone_image_flext = 3;
  int phone_detail_flex = 6;

  int phone_header_flex = 1;
  double phone_header_fontSize = 20;

  double phone_detail_height = 0.31;

  double phone_desc_cont_padd = 10;
  double phone_desc_cont_radius = 15;

  double phone_desc_fontSize = 14;
  double phone_desc_wordSpace = 2;
  double phone_desc_height = 1.8;

  double phone_desc_cont_width = 0.60;
  double phone_desc_cont_height = 0.25;

  double phone_heading_fontSize = 25;

  // CLOSE DIALOG :
  CloseDialog(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    image_cont_width = 0.17;
    image_cont_height = 0.28;
    image_cont_padd = 1;
    image_radius = 20;

    width_factor = 0.9;
    height_factor = 0.50;

    header_bottom_space = 0.05;
    image_desc_space = 0.02;
    heading_desc_height_space = 0.02;

    image_flext = 3;
    detail_flex = 6;

    header_flex = 1;
    header_fontSize = 20;

    detail_height = 0.31;

    desc_cont_padd = 10;
    desc_cont_radius = 15;

    desc_cont_width = 0.60;
    desc_cont_height = 0.25;

    desc_fontSize = 13;
    desc_wordSpace = 2;
    desc_height = 1.8;

    // DEFAULT :
    if (context.width > 1700) {
      image_cont_width = 0.17;
      image_cont_height = 0.28;
      image_cont_padd = 1;
      image_radius = 20;
      detail_height = 0.33;

      width_factor = 0.9;
      height_factor = 0.50;

      header_bottom_space = 0.05;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      image_cont_width = 0.17;
      image_cont_height = 0.28;
      image_cont_padd = 1;
      image_radius = 20;

      width_factor = 0.9;
      height_factor = 0.50;
      detail_height = 0.33;

      header_bottom_space = 0.02;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('1700');
    }

    if (context.width < 1600) {
      width_factor = 0.99;
      height_factor = 0.50;

      image_cont_width = 0.17;
      image_cont_height = 0.28;
      image_cont_padd = 1;
      image_radius = 20;

      detail_height = 0.33;

      header_bottom_space = 0.05;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      width_factor = 1;
      height_factor = 0.50;

      image_cont_width = 0.17;
      image_cont_height = 0.28;
      image_cont_padd = 1;
      image_radius = 20;

      detail_height = 0.33;

      header_bottom_space = 0.05;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      desc_cont_width = 0.60;
      desc_cont_height = 0.25;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('1500');
    }

    if (context.width < 1300) {
      width_factor = 1;
      height_factor = 0.50;

      image_cont_width = 0.17;
      image_cont_height = 0.25;
      image_cont_padd = 1;
      image_radius = 20;

      detail_height = 0.33;

      header_bottom_space = 0.05;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      desc_cont_width = 0.60;
      desc_cont_height = 0.25;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('1300');
    }

    if (context.width < 1200) {
      width_factor = 1;
      height_factor = 0.50;

      image_cont_width = 0.17;
      image_cont_height = 0.25;
      image_cont_padd = 1;
      image_radius = 20;

      detail_height = 0.33;

      header_bottom_space = 0.05;
      image_desc_space = 0.02;
      heading_desc_height_space = 0.02;

      desc_cont_width = 0.60;
      desc_cont_height = 0.25;

      image_flext = 3;
      detail_flex = 6;

      header_flex = 1;
      header_fontSize = 20;

      desc_cont_padd = 10;
      desc_cont_radius = 15;

      desc_fontSize = 13;
      desc_wordSpace = 2;
      desc_height = 1.8;
      print('1200');
    }

    if (context.width < 1000) {
      width_factor = 1;
      height_factor = 0.80;

      phone_image_cont_width = 0.45;
      phone_image_cont_height = 0.28;

      phone_image_cont_padd = 1;
      phone_image_radius = 20;

      phone_header_bottom_space = 0.05;
      phone_image_desc_space = 0.02;
      phone_heading_desc_height_space = 0.02;

      phone_image_flext = 3;
      phone_detail_flex = 6;

      phone_header_flex = 1;
      phone_header_fontSize = 20;

      phone_detail_height = 0.30;
      phone_desc_cont_radius = 15;
      phone_desc_cont_width = 0.60;
      phone_desc_cont_height = 0.23;

      // phone_desc_cont_padd = 10;

      phone_desc_fontSize = 15;
      phone_desc_wordSpace = 2;
      phone_desc_height = 1.8;

      phone_heading_fontSize = 25;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      width_factor = 0.95;
      height_factor = 0.80;

      phone_image_cont_width = 0.45;
      phone_image_cont_height = 0.28;

      phone_image_cont_padd = 1;
      phone_image_radius = 20;

      phone_header_bottom_space = 0.05;
      phone_image_desc_space = 0.02;
      phone_heading_desc_height_space = 0.02;

      phone_image_flext = 3;
      phone_detail_flex = 6;

      phone_header_flex = 1;
      phone_header_fontSize = 20;

      phone_detail_height = 0.30;
      phone_desc_cont_radius = 15;
      phone_desc_cont_width = 0.70;
      phone_desc_cont_height = 0.23;

      // phone_desc_cont_padd = 10;

      phone_desc_fontSize = 15;
      phone_desc_wordSpace = 2;
      phone_desc_height = 1.8;

      phone_heading_fontSize = 25;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      width_factor = 0.95;
      height_factor = 0.80;

      phone_image_cont_width = 0.56;
      phone_image_cont_height = 0.24;

      phone_image_cont_padd = 1;
      phone_image_radius = 10;

      phone_header_bottom_space = 0.05;
      phone_image_desc_space = 0.02;
      phone_heading_desc_height_space = 0.02;

      phone_image_flext = 3;
      phone_detail_flex = 6;

      phone_header_flex = 1;
      phone_header_fontSize = 20;

      phone_detail_height = 0.35;
      phone_desc_cont_radius = 15;
      phone_desc_cont_width = 0.70;
      phone_desc_cont_height = 0.28;

      // phone_desc_cont_padd = 10;

      phone_desc_fontSize = 15;
      phone_desc_wordSpace = 2;
      phone_desc_height = 1.8;

      phone_heading_fontSize = 20;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      width_factor = 1;
      height_factor = 0.82;

      phone_image_cont_width = 0.60;
      phone_image_cont_height = 0.24;

      phone_image_cont_padd = 1;
      phone_image_radius = 10;

      phone_header_bottom_space = 0.05;
      phone_image_desc_space = 0.02;
      phone_heading_desc_height_space = 0.02;

      phone_image_flext = 3;
      phone_detail_flex = 6;

      phone_header_flex = 1;
      phone_header_fontSize = 20;

      phone_detail_height = 0.33;
      phone_desc_cont_radius = 15;
      phone_desc_cont_width = 0.75;
      phone_desc_cont_height = 0.27;

      // phone_desc_cont_padd = 10;

      phone_desc_fontSize = 14;
      phone_desc_wordSpace = 2;
      phone_desc_height = 1.8;

      phone_heading_fontSize = 18;
      header_fontSize = 18;

      print('480');
    }

    Widget mainProduct = Row(
      children: [
        Expanded(
            flex: image_flext,
            child: ImageContainer(context, widget.image ?? temp_image)),

        SizedBox(
          width: context.width * image_desc_space,
        ),

        // PRODUCT DETAIL :
        Expanded(
            flex: detail_flex,
            child: Container(
              alignment: Alignment.topCenter,
              height: context.height * detail_height,
              child: Column(
                children: [
                  // Heading :
                  Heading(),

                  // Spacer :
                  SizedBox(
                    height: context.height * heading_desc_height_space,
                  ),

                  // DESCRIPTION
                  Description(),
                ],
              ),
            ))
      ],
    );

    Widget phoneProduct = Column(
      children: [
        PhoneImageContainer(context, widget.image ?? temp_image),

        SizedBox(
          height: context.width * phone_image_desc_space,
        ),

        // PRODUCT DETAIL :
        Container(
          alignment: Alignment.topCenter,
          height: context.height * phone_detail_height,
          child: Column(
            children: [
              // Heading :
              PhoneHeading(),

              // Spacer :
              SizedBox(
                height: context.height * phone_heading_desc_height_space,
              ),

              // DESCRIPTION
              PhoneDescription(),
            ],
          ),
        ),
      ],
    );

    if (context.width < 1000) {
      mainProduct = phoneProduct;
    }

    return FractionallySizedBox(
      key: GlobalKey(),
      widthFactor: width_factor,
      heightFactor: height_factor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Text :
            // HeaderText(context, 'Review'),

            mainProduct,

            SizedBox(
              height: context.height * header_bottom_space,
            ),
          ],
        ),
      ),
    );
  }

  Container Description() {
    return Container(
      height: context.height * desc_cont_height,
      width: context.width * desc_cont_width,
      padding: EdgeInsets.all(desc_cont_padd),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(desc_cont_radius),
          border: Border.all(color: Colors.grey.shade200)),
      child: SingleChildScrollView(
        child: AutoSizeText.rich(
          TextSpan(
              text: widget.detail ?? '',
              style: TextStyle(
                  fontSize: desc_fontSize,
                  wordSpacing: desc_wordSpace,
                  height: desc_height)),
          style: Get.theme.textTheme.headline5,
        ),
      ),
    );
  }

  Container Heading() {
    return Container(
      child: AutoSizeText.rich(
          TextSpan(
              text: widget.heading ?? '',
              style: TextStyle(
                  fontSize: heading_fontSize, color: map_text_color)),
          style: Get.theme.textTheme.headline2),
    );
  }

  Container ImageContainer(BuildContext context, final_image) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(image_radius),
                right: Radius.circular(image_radius)),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(image_radius),
            right: Radius.circular(image_radius),
          ),
          child: Image.network(final_image,
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.cover),
        ));
  }

  Row HeaderText(BuildContext context, String title) {
    return Row(
      children: [
        Expanded(
          flex: header_flex,
          child: Container(
            alignment: Alignment.topCenter,
            child: AutoSizeText.rich(
                TextSpan(style: Get.theme.textTheme.headline2, children: [
              TextSpan(
                  text: title,
                  style: TextStyle(
                      fontSize: header_fontSize, color: light_color_type3))
            ])),
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

  ///////////////////////////////////////
  /// Phone Methods :
  ///////////////////////////////////////
  Container PhoneDescription() {
    return Container(
      height: context.height * phone_desc_cont_height,
      width: context.width * phone_desc_cont_width,
      padding: EdgeInsets.all(phone_desc_cont_padd),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(phone_desc_cont_radius),
          border: Border.all(color: Colors.grey.shade200)),
      child: AutoSizeText.rich(
        TextSpan(
            text: widget.detail ?? '',
            style: TextStyle(
                fontSize: phone_desc_fontSize,
                wordSpacing: phone_desc_wordSpace,
                height: phone_desc_height)),
        style: Get.theme.textTheme.headline5,
      ),
    );
  }

  Container PhoneHeading() {
    return Container(
      child: AutoSizeText.rich(
          TextSpan(
              text: widget.heading ?? '',
              style: TextStyle(
                  fontSize: phone_heading_fontSize, color: light_color_type2)),
          style: Get.theme.textTheme.headline2),
    );
  }

  Container PhoneImageContainer(BuildContext context, final_image) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(phone_image_radius),
                right: Radius.circular(phone_image_radius)),
            border: Border.all(width: 2, color: Colors.grey.shade200)),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(phone_image_radius),
            right: Radius.circular(phone_image_radius),
          ),
          child: Image.network(final_image,
              width: context.width * phone_image_cont_width,
              height: context.height * phone_image_cont_height,
              fit: BoxFit.cover),
        ));
  }

  Row PhoneHeaderText(BuildContext context, String title) {
    return Row(
      children: [
        Expanded(
          flex: header_flex,
          child: Container(
            alignment: Alignment.topCenter,
            child: AutoSizeText.rich(
                TextSpan(style: Get.theme.textTheme.headline2, children: [
              TextSpan(
                  text: title,
                  style: TextStyle(
                      fontSize: phone_header_fontSize,
                      color: light_color_type3))
            ])),
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
