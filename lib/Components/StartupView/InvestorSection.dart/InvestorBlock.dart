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

  double mem_dialog_width = 600;

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
    // MEMBER DETAIL DIALOG BLOK :
    MemberDetailDialogView() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeleteInvestorButton(),
                    CloseDialogButton(context),
                  ],
                ),
              ),
              content: SizedBox(
                width: mem_dialog_width,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: context.width * 0.12,
        height: context.height * 0.21,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      width: 200,
                      child: Column(
                        children: [
                          // Spacer
                          const SizedBox(
                            height: 5,
                          ),

                          // Member Name Block :
                          MemName(),

                          // Spacer :
                          const SizedBox(
                            height: 5,
                          ),

                          // Contact and email adderss :
                          MemContact()
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
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
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
                fontSize: 16,
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
          icon: const Icon(
            Icons.cancel,
            color: Colors.grey,
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
      elevation: 3,
      shadowColor: Colors.red,
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(80),
          right: Radius.circular(80),
        ),
      ),
      child: Container(
          child: CircleAvatar(
        radius: 55,
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
              fontWeight: FontWeight.w900, color: Colors.black87, fontSize: 16))
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
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12))
    ])));
  }

/////////////////////////////////////////
  /// Member Contact :
/////////////////////////////////////////
  Container MemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon :
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade800,
            size: 16,
          ),
        ),

        // Tect :
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: widget.investor['email'] ?? '',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueGrey.shade700,
                  fontSize: 11))
        ])),
      ],
    ));
  }
}
