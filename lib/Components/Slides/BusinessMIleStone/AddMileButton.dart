import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/Slides/BusinessMIleStone/MileStoneTag.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
/////////////////////////////////
/// ADD MILE STONE :
/////////////////////////////////
class AddMileButton extends StatefulWidget {
  AddMileButton({Key? key}) : super(key: key);

  @override
  State<AddMileButton> createState() => _AddMileButtonState();
}

class _AddMileButtonState extends State<AddMileButton> {
  final formKey = GlobalKey<FormBuilderState>();
  Color suffix_icon_color = Colors.blueGrey.shade300;
  int maxlines = 7;

  double addbtn_top_margin = 0.05;
  double con_button_width = 90;
  double con_button_height = 38;
  double con_btn_top_margin = 10;


  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////
  SubmitMileForm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      print('form submited');
      // final heading = formKey.currentState!.value['prod_head'];
    }
  }

  /// RESET FORM :
  ResetMileForm() {
    formKey.currentState!.reset();
  }

 ////////////////////////////////////
  /// ADD MILE STONE :
  /// 1.Tag filed  max char 50 allow:
  /// 2.Description filed :
  ////////////////////////////////////
  @override
  AddMileStone() {
  showDialog(
      context: context,
      builder: (context) => 
      AlertDialog(
        alignment: Alignment.center,
        // title:  MileDialogHeading(context),
        content:SizedBox(
          width:900,
          child: MileDialog(context)) ,
      ));
  }



  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.height * addbtn_top_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(flex: 1, child: Container()),
          Container(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(primary_light)),
              onPressed: () {
                AddMileStone();
              },
              icon: Icon(Icons.add),
              label: Text('Add')))
        ],
      ),
    );
  }


  AutoSizeText MileDialogHeading(BuildContext context) {
    return AutoSizeText.rich(TextSpan(
        style: context.textTheme.headline2,
        children: [
          TextSpan(text: 'Define Milestone')
          ])
        );
  }
 FractionallySizedBox MileDialog(BuildContext context) {
   return FractionallySizedBox(
      widthFactor: 0.7,
      heightFactor: 0.55,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, 
    
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 10,),  
                  // HEADING : 
                 MileDialogHeading(context),


                  //////////////////////////////////
                  // FORM : 
                  // 1.TAG INPUT FILED  : 
                  // 2.DESCRIPTION INPUT FILED:   
                  //////////////////////////////////
                  FormBuilder(
                    key:formKey, 
                    autovalidateMode:AutovalidateMode.disabled, 
                    child: Container(
                      width:context.width * 0.3, 
                      height:context.height * 0.42, 
                      // padding:EdgeInsets.all(20),
                      child: Column(
                      children: [
                        SizedBox(height: 20,),
                         FormBuilderTextField(
                          textAlign: TextAlign.center,
                          name: 'mile_tag',
                          maxLength:50,
                          style: Get.textTheme.headline2,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(context, 3,
                                errorText: 'At least 3 char allow'), 
                      
                            FormBuilderValidators.maxLength(context, 50,
                                errorText: 'Max 50 char allow')
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Title',
                            contentPadding: EdgeInsets.all(16),
                            hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade300),
                      
                            suffix: InkWell(
                              onTap: () {
                                ResetMileForm();
                              },
                              child: Container(
                                child: Icon(
                                  Icons.cancel_outlined,
                                  color: suffix_icon_color,
                                ),
                              ),
                            ),
                      
                            // focusColor:Colors.pink,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 2, color: primary_light)),
                          ),
                        ),
                      
                        SizedBox(height: 40,), 
          
                         FormBuilderTextField(
                          name: 'mile_desc',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 16,
                          ),
                          maxLength:200 ,
                          scrollPadding: EdgeInsets.all(10),
                          maxLines: maxlines,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(context, 40,
                                errorText: 'At least 50 char allow')
                          ]),
                          decoration: InputDecoration(
                              helperText: 'min allow 50 ',
                              hintText: "Milestone detail",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey.shade200,
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                              contentPadding: EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(width: 1.5, color: Colors.blueGrey.shade200)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(width: 2, color: primary_light)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                        ) ,
                      
                //////////////////////
                /// SUBMIT BUTTON
                //////////////////////
              Container(
              margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 0),
              child: InkWell(
                highlightColor: primary_light_hover,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)),
                onTap: () {
                  
                },
                child: Card(
                  elevation: 10,
                  shadowColor: light_color_type3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    width: con_button_width,
                    height: con_button_height,
                    decoration: BoxDecoration(
                        color: primary_light,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20))),
                    child: const Text(
                      'submit',
                      style: TextStyle(
                          letterSpacing: 2.5,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
                      
                      ],
                  ),
                )), 

              ],
                    ),
            ),
          ),
        ),
      ),
    );
 }
}
