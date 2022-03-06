import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberInfoForm extends StatefulWidget {

  MemberInfoForm({required, Key? key})
      : super(key: key);

  @override
  State<MemberInfoForm> createState() => _MemberInfoFormState();
}

class _MemberInfoFormState extends State<MemberInfoForm> {
  final  formkey = GlobalKey<FormBuilderState>();
  double maxlines = 4 ; 
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double formfield_width = 600;
  double contact_formfield_width = 600;
  double contact_text_margin_top = 0.05;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: formfield_width,
      margin: EdgeInsets.only(left:context.width* 0.02),
      alignment: Alignment.center,
      child: FormBuilder(
          key: formkey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TAKE FOUNDER INOF:
                SizedBox(
                  height: 25,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: contact_formfield_width,
                        child: InputField(
                          context: context,
                          name: 'mem_description',
                          hind_text: 'Member Detail',
                          error_text: 'member detail min len 20',
                          maxlines: maxlines,
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
  FormBuilderTextField InputField(
      {context, maxlines,name, error_text, lable_text, hind_text, require = true}) {
    return FormBuilderTextField(
    // enabled: !info_dialog,
    // initialValue: default_description,
    name: 'mile_desc',
    style: GoogleFonts.robotoSlab(
      fontSize: 16,
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
}
