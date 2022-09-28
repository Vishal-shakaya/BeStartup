import 'package:be_startup/Components/StartupSlides/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamMemberDetailForm extends StatefulWidget {
  GlobalKey<FormBuilderState>? formkey;
  Function ResetForm;
  MemberFormType? form_type;
  var member;
  TeamMemberDetailForm(
      {this.form_type,
      this.member,
      required this.ResetForm,
      this.formkey,
      Key? key})
      : super(key: key);

  @override
  State<TeamMemberDetailForm> createState() => _TeamMemberDetailFormState();
}

class _TeamMemberDetailFormState extends State<TeamMemberDetailForm> {
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double formfield_width = 400;
  double contact_formfield_width = 400;
  double contact_text_margin_top = 0.05;

  double formfield_fontSize = 14;
  @override
  Widget build(BuildContext context) {
    formfield_width = 400;
    contact_formfield_width = 400;
    formfield_fontSize = 14; 
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////

    // DEFAULT :
    if (context.width > 1500) {
      formfield_width = 400;
      contact_formfield_width = 400;

      formfield_fontSize = 14; 
      print('Greator then 1500');
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
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      formfield_width = 600;
      contact_formfield_width = 600;

      formfield_fontSize = 14; 
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      formfield_fontSize = 12; 
      print('480');
    }

    return Container(
      padding: EdgeInsets.all(1),
      width: formfield_width,
      alignment: Alignment.center,
      child: FormBuilder(
          key: widget.formkey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TAKE FOUNDER INOF:
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shadowColor: form_shadow_color,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: form_border_color),
                            borderRadius: BorderRadius.circular(5)),
                        width: contact_formfield_width,
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
                                    widget.form_type == MemberFormType.edit
                                        ? widget.member['name']
                                        : ''),
                            SecondaryInputField(
                                context: context,
                                name: 'position',
                                lable_text: 'Position',
                                hind_text: 'position',
                                error_text: 'member position required',
                                initial_val:
                                    widget.form_type == MemberFormType.edit
                                        ? widget.member['position']
                                        : ''),
                            SecondaryInputField(
                                context: context,
                                name: 'email',
                                lable_text: 'Email',
                                hind_text: 'contact or email',
                                error_text: '',
                                require: false,
                                initial_val:
                                    widget.form_type == MemberFormType.edit
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
        fontSize: formfield_fontSize,
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
            fontSize: formfield_fontSize,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle:
            TextStyle(fontSize: formfield_fontSize, color: input_hind_color),

        suffix: InkWell(
          onTap: () {
            widget.ResetForm(name);
          },
          child: Container(
            child: Icon(
              Icons.close,
              color: input_reset_color,
              size: 15,
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
