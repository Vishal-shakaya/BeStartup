import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestorInfoForm extends StatefulWidget {
  GlobalKey<FormBuilderState> formkey;
  InvestorFormType? form_type;
  var member;

  InvestorInfoForm(
      {this.form_type, this.member, required this.formkey, Key? key})
      : super(key: key);

  @override
  State<InvestorInfoForm> createState() => _MemberInfoFormState();
}

class _MemberInfoFormState extends State<InvestorInfoForm> {
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double maxlines = 5;
  double formfield_width =0.32;
  double contact_formfield_width =0.32;
  double contact_text_margin_top = 0.05;

  double info_cont_top_margin = 0.01;
  double top_spacer = 25;
  double form_textSize = 14;
  int max_length = 500;
  double scroll_padd = 10;
  double content_padding = 20;
  double input_radius = 15; 

  @override
  Widget build(BuildContext context) {
     maxlines = 5;
     formfield_width =0.32;
     contact_formfield_width =0.32;
     contact_text_margin_top = 0.05;

     info_cont_top_margin = 0.01;
     top_spacer = 25;
     form_textSize = 14;
     max_length = 500;
     scroll_padd = 10;
     content_padding = 20;
     input_radius = 15; 

    // DEFAULT :
    if (context.width > 1700) {
        maxlines = 5;
        formfield_width =0.32;
        contact_formfield_width =0.32;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 14;
        max_length = 500;
        
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('Greator then 1700');
    }

    if (context.width < 1700) {
        maxlines = 5;
        formfield_width =0.32;
        contact_formfield_width =0.32;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 14;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('1700');
    }

    if (context.width < 1600) {
        print('1600');
    }

    // PC:
    if (context.width < 1500) {
        maxlines = 5;
        formfield_width =0.34;
        contact_formfield_width =0.34;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 14;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('1500');
    }
    if (context.width < 1400) {
        maxlines = 5;
        formfield_width =0.36;
        contact_formfield_width =0.36;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 14;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('1400');
    }

    if (context.width < 1300) {
        maxlines = 5;
        formfield_width =0.37;
        contact_formfield_width =0.37;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 14;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('1300');
    }

    if (context.width < 1200) {
        maxlines = 5;
        formfield_width =0.45;
        contact_formfield_width =0.45;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 13;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 20;
        input_radius = 15; 
        print('1200');
    }

    if (context.width < 1000) {
        maxlines = 5;
        formfield_width =0.45;
        contact_formfield_width =0.45;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 13;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 18;
        input_radius = 15; 
        print('1000');
    }

    // TABLET :
    if (context.width < 800) {
        maxlines = 5;
        formfield_width =0.50;
        contact_formfield_width =0.50;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.01;
        top_spacer = 25;
        form_textSize = 12;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 18;
        input_radius = 15; 
        print('800');
    } 

    // SMALL TABLET:
    if (context.width < 640) {
        maxlines = 5;
        formfield_width =0.50;
        contact_formfield_width =0.50;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.03;
        top_spacer = 25;
        form_textSize = 12;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 18;
        input_radius = 15; 
        print('640');
    }

    // PHONE:
    if (context.width < 480) {
        maxlines = 6;
        formfield_width =0.55;
        contact_formfield_width =0.55;
        contact_text_margin_top = 0.05;

        info_cont_top_margin = 0.03;
        top_spacer = 25;
        form_textSize = 12;
        max_length = 500;
        scroll_padd = 10;
        content_padding = 5;
        input_radius = 10; 
        print('480');
    }

    return Container(
      width: context.width*formfield_width,
      margin: EdgeInsets.only(top: context.width * info_cont_top_margin),
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

                SingleChildScrollView(
                  child: Column(
                    children: [
                    
                      Container(
                        alignment: Alignment.topCenter,
                        width: context.width*contact_formfield_width,
                        child: InputField(
                            context: context,
                            name: 'info',
                            hind_text: 'investor Detail',
                            error_text: 'investor detail min len 20',
                            maxlines: maxlines,
                            inital_val:
                                widget.form_type == InvestorFormType.edit
                                    ? widget.member['info']
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
        fontSize: form_textSize,
      ),

      maxLength: max_length,
      scrollPadding: EdgeInsets.all(scroll_padd),
      maxLines: maxlines,

      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength( 50,
            errorText: 'At least 50 char allow')
      ]),

      decoration: InputDecoration(
          helperText: 'min allow 50 ',
          hintText: hind_text,
          hintStyle: TextStyle(
            color: Colors.blueGrey.shade200,
          ),

          fillColor: Colors.grey[100],
          filled: true,
          
          contentPadding: EdgeInsets.all(content_padding),
          
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(input_radius),
              borderSide:
                  BorderSide(width: 1.5, color: Colors.blueGrey.shade200)),
          
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(input_radius),
              borderSide: BorderSide(width: 2, color: primary_light)),
         
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(input_radius))),
    );
  }
}
