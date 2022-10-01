import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/StartupInvestor/StartupInvestorStore.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/CreateInvestorDialog.dart';
import 'package:be_startup/Components/StartupView/MemberDetailDialog.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestorBlock extends StatefulWidget {
  var investor;
  var is_admin;
  InvestorBlock({required this.is_admin, required this.investor, Key? key})
      : super(key: key);

  @override
  State<InvestorBlock> createState() => _InvestorBlockState();
}

class _InvestorBlockState extends State<InvestorBlock> {
  var startupInvestorStore = Get.put(StartupInvestorStore());
  var my_context = Get.context;

  double member_dialog_width = 0.33;

  double member_card_radius = 20;

  double invest_block_width = 0.12;

  double invest_block_height = 0.21;

  double invest_box_width = 0.10;

  double invest_spacer = 5;

  double invest_block_padding = 10;

  double invest_block_radius = 10;

  double profile_border_radius = 80;

  double profile_elevation = 3;

  double profile_radius = 55;

  double invest_name_fontSize = 14;

  double invest_pod_fontSize = 12;

  double invest_contact_padd = 5.0;

  double invest_contact_iconSize = 16;

  double invest_mail_fontSize = 11;

  double delete_margin_top = 0.02;

  double delete_cont_width = 100;

  double delete_fontSize = 14;

  double close_icon_fontSize = 20;

  double inset_padding_hor = 40.0;

  double inset_padding_ver = 25.0;

/////////////////////////////////////////////////////////////////
  /// The function is called when the user clicks on
  /// the delete button. It calls the DeleteInvestor()
  /// function in the store. The store then calls the
  ///  DeleteInvestor() function in the API. The API then
  /// calls the DeleteInvestor() function in the database.
  ///  The database then deletes the investor from the
  /// database
/////////////////////////////////////////////////////////////////
  DeleteInvestor() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    final resp = await startupInvestorStore.DeleteInvestor(
        inv_id: widget.investor['id']);

    print('Delete Investor Reponse $resp');

    // Success Hadler :
    if (resp['response']) {
      Navigator.of(context).pop();
    }

    // Error Handler :
    if (!resp['response']) {
      Get.showSnackbar(MyCustSnackbar(
          type: MySnackbarType.error,
          title: 'Unable to delete',
          width: snack_width));
    }
  }

  @override
  Widget build(BuildContext context) {

    // DEFAULT :
    if (context.width > 1700) {
      member_dialog_width = 0.37;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 55;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 5.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;

      inset_padding_hor = 40.0;

      inset_padding_ver = 25.0;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      member_dialog_width = 0.37;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 55;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;

      inset_padding_hor = 40.0;

      inset_padding_ver = 25.0;
      print('1700');
    }

    if (context.width < 1600) {
      member_dialog_width = 0.38;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 55;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      member_dialog_width = 0.40;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 55;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1500');
    }

    if (context.width < 1400) {
      member_dialog_width = 0.42;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 45;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1400');
    }
    if (context.width < 1300) {
      member_dialog_width = 0.48;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 45;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1300');
    }

    if (context.width < 1200) {
      member_dialog_width = 0.50;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_border_radius = 80;

      profile_elevation = 3;

      profile_radius = 45;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1200');
    }

    if (context.width < 1000) {
      member_dialog_width = 0.60;

      member_card_radius = 20;

      invest_block_width = 0.12;

      invest_block_height = 0.21;

      invest_box_width = 0.10;

      invest_spacer = 5;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_elevation = 0;

      profile_radius = 48;

      profile_border_radius = 80;

      invest_name_fontSize = 14;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      member_dialog_width = 0.65;

      member_card_radius = 20;

      invest_block_width = 0.15;

      invest_block_height = 0.23;

      invest_box_width = 0.20;

      invest_spacer = 4;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_elevation = 0;

      profile_border_radius = 4;

      profile_radius = 40;

      invest_name_fontSize = 13;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 100;

      delete_fontSize = 14;

      close_icon_fontSize = 20;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      member_dialog_width = 0.80;

      member_card_radius = 20;

      invest_block_width = 0.20;

      invest_block_height = 0.25;

      invest_box_width = 0.20;

      invest_spacer = 4;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_elevation = 0;

      profile_border_radius = 4;

      profile_radius = 40;

      invest_name_fontSize = 13;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.02;

      delete_cont_width = 80;

      delete_fontSize = 13;

      close_icon_fontSize = 20;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      member_dialog_width = 0.98;

      member_card_radius = 20;

      invest_block_width = 0.25;

      invest_block_height = 0.26;

      invest_box_width = 0.20;

      invest_spacer = 2;

      invest_block_padding = 10;

      invest_block_radius = 10;

      profile_elevation = 0;

      profile_border_radius = 4;

      profile_radius = 30;

      invest_name_fontSize = 13;

      invest_pod_fontSize = 12;

      invest_contact_padd = 3.0;

      invest_contact_iconSize = 16;

      invest_mail_fontSize = 11;

      delete_margin_top = 0.01;

      delete_cont_width = 70;

      delete_fontSize = 12;

      close_icon_fontSize = 20;

      inset_padding_hor = 15.0;

      inset_padding_ver = 10.0;
      print('480');
    }

    // MEMBER DETAIL DIALOG BLOK :
    MemberDetailDialogView() {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(2),
              insetPadding: EdgeInsets.symmetric(
                  horizontal: inset_padding_hor, vertical: inset_padding_ver),
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.is_admin==false?Container(): DeleteInvestorButton(),
                    CloseDialogButton(context),
                  ],
                ),
              ),
              content: SizedBox(
                width: context.width * member_dialog_width,
                child: widget.is_admin
                    ? InvestorDialog(
                        form_type: InvestorFormType.edit,
                        member: widget.investor,
                      )
                    : MemberDetailDialog(investor: widget.investor),
              )));
    }

    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(member_card_radius)),
      ),
      child: Container(
        width: context.width * invest_block_width,
        height: context.height * invest_block_height,
        alignment: Alignment.center,
        padding: EdgeInsets.all(invest_block_padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(invest_block_radius)),
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: 'Tap For More Detail',
              child: InkWell(
                hoverColor: Colors.transparent,
                radius: 20,
                onTap: () {
                  MemberDetailDialogView();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image :
                    ProfileImage(),

                    // Postition:
                    SizedBox(
                      width: context.width * invest_box_width,
                      child: Column(
                        children: [
                          // Spacer
                          SizedBox(
                            height: invest_spacer,
                          ),

                          // Member Name Block :
                          MemName(),

                          // Spacer :
                          SizedBox(
                            height: invest_spacer,
                          ),

                          // Contact and email adderss :
                          // MemContact()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container DeleteInvestorButton() {
    return Container(
      margin: EdgeInsets.only(top: context.height * delete_margin_top),
      alignment: Alignment.center,
      width: delete_cont_width,
      
      decoration: BoxDecoration(
        color:delete_background_btn_color,
        borderRadius: BorderRadius.circular(15),
      ),
      
      child: TextButton(
          onPressed: () {
            DeleteInvestor();
          },
          child: Text(
            'Delete',
            style: TextStyle(
                color: Colors.red.shade400,
                fontSize: delete_fontSize,
                fontWeight: FontWeight.w600),
          )),
    );
  }

  Container CloseDialogButton(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.grey,
            size: close_icon_fontSize,
          )),
    );
  }

  //////////////////////////////////////
  /// Member Description :
  //////////////////////////////////////
  Card MemDescription(
      BuildContext context, mem_desc_block_width, mem_desc_block_height) {
    return Card(
      shadowColor: Colors.red,
      elevation: 5,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: ' 😎 Managing Director',
                    style: GoogleFonts.robotoSlab(
                      textStyle: TextStyle(),
                      color: light_color_type2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                    ),
                  ),
                ])),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: context.width * 0.15,
            height: context.height * 0.12,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  // Heading Texct :
                  TextSpan(
                    text: long_string,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(),
                      color: light_color_type3,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                    ),
                  ),
                ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card ProfileImage() {
    return Card(
      elevation: profile_elevation,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(profile_border_radius)),
      child: Container(
          child: CircleAvatar(
        radius: profile_radius,
        backgroundColor: Colors.blueGrey[100],
        foregroundImage: NetworkImage(widget.investor['image'] ?? temp_logo),
      )),
    );
  }

//////////////////////////////////////
  /// Mem Name  Method :
//////////////////////////////////////
  Container MemName() {
    return Container(
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: widget.investor['name'] ?? '',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: invest_name_fontSize))
    ])));
  }

  //////////////////////////////////
  // Member Position Method :
  //////////////////////////////////
  Container MemPosition() {
    return Container(
        // margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
      TextSpan(
          text: '@${widget.investor['position']}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: invest_pod_fontSize))
    ])));
  }

/////////////////////////////////////////
  /// Member Contact :
/////////////////////////////////////////
  Container MemContact() {
    return Container(
        child: Wrap(
      children: [
        // Icon :
        Padding(
          padding: EdgeInsets.only(right: invest_contact_padd),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade800,
            size: invest_contact_iconSize,
          ),
        ),

        // Text :
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.investor['email'] ?? '',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: invest_mail_fontSize))
        ])),
      ],
    ));
  }
}
