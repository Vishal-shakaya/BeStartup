import 'package:be_startup/Components/StartupSlides/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberInfoForm extends StatefulWidget {
  GlobalKey<FormBuilderState> formkey;
  MemberFormType? form_type;
  var member;
  MemberInfoForm({this.form_type, this.member, required this.formkey, Key? key})
      : super(key: key);

  @override
  State<MemberInfoForm> createState() => _MemberInfoFormState();
}

class _MemberInfoFormState extends State<MemberInfoForm> {
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double maxlines = 5;

  double formfield_width = 600;
  double contact_formfield_width = 600;

  double contact_text_margin_top = 0.05;

  double form_left_margin = 0.04;
  double form_top_margin = 0.01;

  double form_bottom_margin = 0.00;

  double form_fontSize = 16; 

  @override
  Widget build(BuildContext context) {
      form_fontSize = 16; 
      maxlines = 5;
      formfield_width = 600;
      contact_formfield_width = 600;
      contact_text_margin_top = 0.05;

      form_left_margin = 0.04;
      form_top_margin = 0.01;

    // DEFAULT :
    if (context.width > 1500) {
      print('greator then 1500');
      maxlines = 5;
      formfield_width = 600;
      contact_formfield_width = 600;
      contact_text_margin_top = 0.05;

      form_left_margin = 0.04;
      form_top_margin = 0.01;
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      form_fontSize = 15; 
      maxlines = 5;
      formfield_width = 550;
      contact_formfield_width = 550;
      contact_text_margin_top = 0.05;
      form_bottom_margin = 0.00;
      print('1200');
    }

    if (context.width < 1000) {
      maxlines = 5;
      formfield_width = 500;
      contact_formfield_width = 500;
      contact_text_margin_top = 0.05;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      form_fontSize = 14; 
      maxlines = 4;
      formfield_width = 400;
      contact_formfield_width = 400;
      contact_text_margin_top = 0.05;

      print('800');
    }

    if (context.width < 700) {
      maxlines = 4;
      formfield_width = 350;
      contact_formfield_width = 350;
      contact_text_margin_top = 0.05;

      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      form_fontSize = 13; 
      maxlines = 4;
      formfield_width = 340;
      contact_formfield_width = 340;
      contact_text_margin_top = 0.05;

      print('640');
    }

    if (context.width < 600) {
      maxlines = 4;
      formfield_width = 320;
      contact_formfield_width = 320;
      contact_text_margin_top = 0.05;

      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      maxlines = 8;
      formfield_width = 195;
      contact_formfield_width = 195;
      contact_text_margin_top = 0.05;

      form_left_margin = 0.00;
      form_top_margin = 0.01;
      form_bottom_margin = 0.01;

      form_fontSize = 13; 
      print('480');
    }

    return Container(
      width: formfield_width,
      margin: EdgeInsets.only(
          left: context.width * form_left_margin,
          top: context.width * form_top_margin,
          bottom: context.width * form_bottom_margin),

      alignment: Alignment.center,
      
      child: FormBuilder(
          key: widget.formkey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            
            child: Column(
              children: [
                // TAKE FOUNDER INOF:
                const SizedBox(
                  height: 25,
                ),
              
                SingleChildScrollView(
                  child: Column(
                    children: [
                   
                      Container(
                        width: contact_formfield_width,
                        child: InputField(
                            context: context,
                            name: 'meminfo',
                            hind_text: 'Member Detail',
                            error_text: 'member detail min len 20',
                            maxlines: maxlines,
                            inital_val: widget.form_type == MemberFormType.edit
                                ? widget.member['meminfo']
                                : ''),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  // Secondary Input field :
  FormBuilderTextField InputField(
      {context,
      maxlines,
      name,
      error_text,
      lable_text,
      hind_text,
      require = true,
      inital_val}) {
   
    return FormBuilderTextField(
      // enabled: !info_dialog,
      initialValue: inital_val != '' ? inital_val : '',
      name: name,
      style: GoogleFonts.robotoSlab(
        fontSize: form_fontSize,
      ),
      maxLength: 500,
      scrollPadding: EdgeInsets.all(10),
      maxLines: maxlines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 50,
            errorText: 'At least 50 char allow')
      ]),
      decoration: InputDecoration(
          helperText: 'min allow 50 ',
          hintText: hind_text,
          
          hintStyle: TextStyle(
            fontSize: form_fontSize,
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
}
