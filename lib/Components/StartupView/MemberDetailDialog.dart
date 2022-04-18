import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorTeam/TeamMemberProfileImage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberDetailDialog extends StatefulWidget {
  MemberDetailDialog({Key? key}) : super(key: key);

  @override
  State<MemberDetailDialog> createState() => _MemberDetailDialogState();
}

class _MemberDetailDialogState extends State<MemberDetailDialog> {
  double con_button_width = 55;
  double con_button_height = 30;
  double con_btn_top_margin = 10;

  double formfield_width = 400;
  double contact_formfield_width = 400;
  double contact_text_margin_top = 0.05;


  // CLOSE DIALOG :
  CloseDialog(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.60,
      child: Container(
        padding:EdgeInsets.all(15),
        color:Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SPACING : 
              SizedBox( height: 10,),

              // MODEL HEADING : 
              HeaderText(context),

             // PROFILE IMAG AND INFO : 

                  Container(
                  child: Row(
                children: [
                  Expanded(  
                    flex: 5,
                    child:TeamMemberProfileImage()
                    ),
                  Expanded(
                      flex: 5,
                      child: Container(
                        width: formfield_width,
                        alignment: Alignment.center,
                        
                        child: Container(
                          width: contact_formfield_width,
                          child: Column(
                            children: [
                              MemberInfoBlock('Vishal Shakaya'), 
                              MemberInfoBlock('Manager'), 
                              MemberInfoBlock('shakayavishal009@gamil.com'), 

                            ],
                          ),
                        ),
                      )
                            
                    ), 
                ],
              )),
               
              MemDescription(), 
            ],
          ),
        ), 
      ),
    );
  }

  Container MemDescription() {
    return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top:20),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: border_color )
              ),
                child: AutoSizeText.rich(
        
                  TextSpan(
                    text: long_string,
                    style:GoogleFonts.robotoSlab(
                      textStyle: TextStyle(),
                      color: light_color_type1,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ) 
                  ),
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 10,
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
                  style:GoogleFonts.robotoSlab(
                    textStyle: TextStyle(),
                    color: light_color_type1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ) 
                
                ),
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
