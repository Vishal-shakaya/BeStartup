import 'package:be_startup/Components/StartupSlides/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestorDetialForm extends StatefulWidget {
  GlobalKey<FormBuilderState>? formkey;
  Function ResetForm;
  InvestorFormType? form_type;
  var member;

  InvestorDetialForm(
      {this.form_type,
      this.member,
      required this.ResetForm,
      this.formkey,
      Key? key})
      : super(key: key);

  @override
  State<InvestorDetialForm> createState() => _TeamMemberDetailFormState();
}

class _TeamMemberDetailFormState extends State<InvestorDetialForm> {
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double formfield_width = 0.15;
  double contact_formfield_width = 0.15;
  double contact_text_margin_top = 0.05;

  double top_spacer = 20;
  double card_radius = 5;

  double inv_fontSize = 14;
  double content_padding = 16;

  double cancel_iconSize = 15; 


  @override
  Widget build(BuildContext context) {

     formfield_width = 0.15;
     contact_formfield_width = 0.15;
     contact_text_margin_top = 0.05;

     top_spacer = 20;
     card_radius = 5;

     inv_fontSize = 14;
     content_padding = 16;

     cancel_iconSize = 15; 


		// DEFAULT :
    if (context.width > 1700) {
        formfield_width = 0.15;
        contact_formfield_width = 0.15;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 14;
        content_padding = 16;

        cancel_iconSize = 15; 
        print('Greator then 1700');
      }
  
    if (context.width < 1700) {
        formfield_width = 0.15;
        contact_formfield_width = 0.15;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 14;
        content_padding = 16;

        cancel_iconSize = 15; 
      print('1700');
      }
  
    if (context.width < 1600) {
      print('1600');
      }

    // PC:
    if (context.width < 1400) {
        formfield_width = 0.15;
        contact_formfield_width = 0.15;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 14;
        content_padding = 16;

        cancel_iconSize = 15; 
      print('1400');
      }

    if (context.width < 1300) {
        formfield_width = 0.19;
        contact_formfield_width = 0.19;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 14;
        content_padding = 16;

        cancel_iconSize = 15; 
      print('1300');
      }

    // PC:
    if (context.width < 1500) {
      print('1500');
      }

    if (context.width < 1200) {
        formfield_width = 0.20;
        contact_formfield_width = 0.20;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 13;
        content_padding = 16;

        cancel_iconSize = 15; 
      print('1200');
      }
    
    if (context.width < 1000) {
        formfield_width = 0.22;
        contact_formfield_width = 0.22;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 13;
        content_padding = 16;

        cancel_iconSize = 15; 
        print('1000');
      }

    // TABLET :
    if (context.width < 800) {
        formfield_width = 0.24;
        contact_formfield_width = 0.24;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 12;
        content_padding = 16;

        cancel_iconSize = 15; 
      print('800');
      }

    // SMALL TABLET:
    if (context.width < 640) {
        formfield_width = 0.35;
        contact_formfield_width = 0.35;
        contact_text_margin_top = 0.05;

        top_spacer = 20;
        card_radius = 5;

        inv_fontSize = 12;
        content_padding = 15;

        cancel_iconSize = 15; 
      print('640');
      }

    // PHONE:
    if (context.width < 480) {
        formfield_width = 0.70;
        contact_formfield_width = 0.70;
        contact_text_margin_top = 0.02;

        top_spacer = 1;
        card_radius = 5;

        inv_fontSize = 12;
        content_padding = 5;

        cancel_iconSize = 14; 
        print('480');
      }
    return Container(
      width: context.width*formfield_width,
     
      alignment: Alignment.center,
     
      child: FormBuilder(
          key: widget.formkey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TAKE FOUNDER INOF:
                SizedBox(
                  height: top_spacer,
                ),
                Card(
                  shadowColor: my_theme_shadow_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(card_radius))),
                 
                  child: Column(
                 
                    children: [
                 
                      Container(
                        width: context.width*contact_formfield_width,
                     
                        child: Column(
                          children: [
                           
                           
                            SecondaryInputField(
                                // initial_value:widget.member['name'],
                                context: context,
                                name: 'name',
                                lable_text: 'Full name',
                                hind_text: 'enter name',
                                error_text: 'name field required',
                                initial_val:
                                    widget.form_type == InvestorFormType.edit
                                        ? widget.member['name']
                                        : ''),
                           
                           
                            SecondaryInputField(
                                context: context,
                                name: 'position',
                                lable_text: 'Position',
                                hind_text: 'type',
                                require: false,
                                initial_val:
                                    widget.form_type == InvestorFormType.edit
                                        ? widget.member['position']
                                        : ''),
                           
                           
                            SecondaryInputField(
                                context: context,
                                name: 'email',
                                lable_text: 'Email',
                                hind_text: 'contact email',
                                error_text: '',
                                require: false,
                                initial_val:
                                    widget.form_type == InvestorFormType.edit
                                        ? widget.member['email']
                                        : ''),
                          ],
                        ),
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
  FormBuilderTextField SecondaryInputField(
      {context,
      name,
      error_text,
      lable_text,
      hind_text,
      require = true,
      initial_val}) {
    return FormBuilderTextField(
      initialValue: initial_val != '' ? initial_val : '',
      textAlign: TextAlign.center,
      name: name,
    
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_text_color,
        fontSize: inv_fontSize,
        fontWeight: FontWeight.w600,
      ),
    
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.minLength(context, 1, errorText: error_text)]),
    
      decoration: InputDecoration(
        labelText: lable_text,
        labelStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: input_hind_color,
            fontSize: inv_fontSize,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(content_padding),
        hintStyle:
            TextStyle(fontSize: inv_fontSize, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            widget.ResetForm(name);
          },

          child: Container(
            child: Icon(
              Icons.close,
              color: close_model_color,
              size: cancel_iconSize,
            ),
          ),
        ),

        // focusColor:Colors.pink,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: primary_light)),
      ),
    );
  }
}
