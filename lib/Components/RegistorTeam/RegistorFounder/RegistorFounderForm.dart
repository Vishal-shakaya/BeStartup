import 'package:auto_size_text/auto_size_text.dart';
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
      String founder_name = formKey.currentState!.value['founder_name'];
      String founder_position = formKey.currentState!.value['founder_position'];
      String phone_no = formKey.currentState!.value['phone_no'];
      String email = formKey.currentState!.value['email'];
      String other_info = formKey.currentState!.value['other_info'];
     
     // Testing
      print(founder_name);
      print(founder_position); 
      print(phone_no); 
      print(email); 
      formKey.currentState!.reset();
    } else {
      print('error found');
    }
  }

  ResetForm() {
    formKey.currentState!.reset();
  }

  double formfield_width = 500;
  double contact_formfield_width = 350;
  double contact_text_margin_top = 0.05;

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1500) {
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {print('1200');}

    if (context.width < 1000) {print('1000');}

    // TABLET :
    if (context.width < 800) {print('800');}
    // SMALL TABLET:
    if (context.width < 640) {print('640');}

    // PHONE:
    if (context.width < 480) {print('480');}
    
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
                Container(
                  width: contact_formfield_width,
                  child: Column(
                    children: [
                      InputField(
                          context: context,
                          name: 'founder_name',
                          error_text: 'Founder name required',
                          lable_text: 'founder',
                          hind_text: 'founder or CEO'),

                      // POSITION:
                      InputField(
                        context: context,
                        name: 'founder_position',
                        lable_text: 'Position',
                        hind_text: 'position in company',
                        error_text: 'position in company required',
                      ),
                    ],
                  ),
                ),

                // CONTACT HEADING SECTION:
                Container(
                    margin: EdgeInsets.only(
                        top: context.height * contact_text_margin_top),
                    child: AutoSizeText.rich(
                        TextSpan(style: Get.textTheme.headline2, children: [
                      TextSpan(
                        text: 'Primary Contact',
                      )
                    ]))),

                // TAKE FOUNDER INOF:
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                      width: formfield_width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: contact_formfield_width,
                            child: Column(
                              children: [
                                SecondaryInputField(
                                  context: context,
                                  name: 'phone_no',
                                  lable_text: 'Phone no',
                                  hind_text: 'primary phone no ',
                                  error_text:
                                      'phone no required for investor purpose!',
                                ),
                                SecondaryInputField(
                                  context: context,
                                  name: 'email',
                                  lable_text: 'Email',
                                  hind_text: 'personal email',
                                  error_text: 'primay eamil required ',
                                ),
                                SecondaryInputField(
                                  context: context,
                                  name: 'other_info',
                                  lable_text: 'Other',
                                  hind_text: 'optional contact',
                                  error_text: '',
                                  require: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }

  FormBuilderTextField InputField(
      {context, name, error_text, lable_text, hind_text, require = true}) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: name,
      style: Get.textTheme.headline2,
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
              color: input_reset_color,
              size: 20,
            ),
          ),
        ),

        // focusColor:Colors.pink,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: primary_light)),
      ),
    );
  }

  // Secondary Input field :
  FormBuilderTextField SecondaryInputField(
      {context, name, error_text, lable_text, hind_text, require = true}) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: name,
      style: Get.textTheme.headline2,
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
            ResetForm();
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
              color: input_reset_color,
              size: 20,
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
