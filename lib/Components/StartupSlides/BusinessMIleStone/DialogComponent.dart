import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:auto_size_text/auto_size_text.dart';

/////////////////////////////////
/// MILESTONE DIALOG HEADING :
/// /////////////////////////////
Row MileDialogHeading(context, CloseMilestoneDialog) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topRight,
           ),
        ),
      
      IconButton(
          onPressed: () {
            CloseMilestoneDialog();
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.blueGrey.shade800,
          ))
    ],
  );
}

/////////////////////////////////////////
// MILESTONE TAG INPUT SECTION :
/////////////////////////////////////////
FormBuilderTextField MilestoneTagInput(
    {context, ResetMileForm, default_title, info_dialog}) {
  return FormBuilderTextField(
    enabled: !info_dialog,
    initialValue: default_title,
    textAlign: TextAlign.center,
    name: 'mile_tag',
    maxLength: 50,
    style: Get.theme.textTheme.headline2,
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
            color: Colors.grey.shade400,
            size: 18,
          ),
        ),
      ),

      // focusColor:Colors.pink,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: primary_light)),
    ),
  );
}

/////////////////////////////////////////
// MILE STONE DESCRIPTION SECTION :
/////////////////////////////////////////
FormBuilderTextField MilestoneDescInput(
    {context, maxlines, default_description, info_dialog}) {
  return FormBuilderTextField(
    enabled: !info_dialog,
    initialValue: default_description,
    name: 'mile_desc',
    style: GoogleFonts.robotoSlab(
      fontSize: 16,
    ),
    maxLength: 1000,
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
  );
}

//////////////////////////////////////////////
/// SUBMIT BUTTON :
//////////////////////////////////////////////
Container MilestoneDialogSubmitButton(
    {required SubmitMileForm,
    con_btn_top_margin,
    con_button_height,
    con_button_width}) {
  return Container(
    margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 0),
    child: InkWell(
      highlightColor: primary_light_hover,
      borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20), right: Radius.circular(20)),
      onTap: () {
        SubmitMileForm();
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
                  left: Radius.circular(20), right: Radius.circular(20))),
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
  );
}
