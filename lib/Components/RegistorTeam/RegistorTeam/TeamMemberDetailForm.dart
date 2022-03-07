import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamMemberDetailForm extends StatefulWidget {
  GlobalKey<FormBuilderState>?  formkey;
  Function ResetForm;
  TeamMemberDetailForm({required this.ResetForm, this.formkey, Key? key})
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: formfield_width,
      alignment: Alignment.center,
      child: FormBuilder(
          key: widget.formkey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TAKE FOUNDER INOF:
                SizedBox(
                  height: 20,
                ),
                Card(
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        width: contact_formfield_width,
                        child: Column(
                          children: [
                            SecondaryInputField(
                              context: context,
                              name: 'name',
                              lable_text: 'Full name',
                              hind_text: 'enter name',
                              error_text: 'name field required',
                            ),
                            SecondaryInputField(
                              context: context,
                              name: 'position',
                              lable_text: 'Position',
                              hind_text: 'type',
                              error_text: 'member position required',
                            ),
                            SecondaryInputField(
                              context: context,
                              name: 'email',
                              lable_text: 'Email',
                              hind_text: 'contact email',
                              error_text: '',
                              require: false,
                            ),
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
      {context, name, error_text, lable_text, hind_text, require = true}) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: light_color_type1,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(context, require ? 1 : 0,
            errorText: error_text)
      ]),
      decoration: InputDecoration(
        labelText: lable_text,
        labelStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: input_label_color,
            fontSize: 14,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            widget.ResetForm();
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
              color: input_reset_color,
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
}
