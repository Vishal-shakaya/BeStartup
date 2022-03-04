import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistorFounderForm extends StatefulWidget {
  RegistorFounderForm({Key? key}) : super(key: key);

  @override
  State<RegistorFounderForm> createState() => _RegistorFounderFormState();
}

class _RegistorFounderFormState extends State<RegistorFounderForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

// SUBMIT  FORM :
  SubmitFounderDetail() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      // String email = formKey.currentState!.value['email'];
      formKey.currentState!.reset();
    } else {
      print('error found');
    }
  }

  ResetForm() {
    formKey.currentState!.reset();
  }

  double formfield_width=300; 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: formfield_width,
      alignment: Alignment.center,
      child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [

                // FOUNDER FIELD : 
                InputField(
                  context:context, 
                  name: 'founder_name',
                  error_text: 'Founder name required',
                  lable_text: 'founder',  
                  hind_text: 'founder or CEO'
                   ),

                 // POSITION:   
                InputField(
                  context:context, 
                  name: 'founder_position',
                  lable_text: 'Position',  
                  hind_text: 'position in company', 
                  error_text: 'position in company required',
                   ),
              ],
            ),
          )),
    );
  }

  FormBuilderTextField InputField({
    context, name, error_text , lable_text, hind_text}) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: name,
      style: Get.textTheme.headline2,
      
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(context, 1,
            errorText: error_text)
      ]),
      decoration: InputDecoration(
        labelText: lable_text,

        labelStyle: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_label_color,
        fontSize: 16,
        fontWeight: FontWeight.w500),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetForm();
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
    );
  }
}
