import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Users/Founder/FounderStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class RegistorFounderForm extends StatefulWidget {
  var formKey;
  var data;
  RegistorFounderForm({
    this.data, 
    this.formKey, 
    Key? key}) : super(key: key);

  @override
  State<RegistorFounderForm> createState() => _RegistorFounderFormState();
}

class _RegistorFounderFormState extends State<RegistorFounderForm> {
  var founderStore = Get.put(FounderStore());

  bool is_password_visible = true;

  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double formfield_width = 500;
  double contact_formfield_width = 350;
  double contact_text_margin_top = 0.05;

  double form_fontSize = 15;
  double form_hint_fontSize = 14;

  var pageParam;
  var user_id;
  var startup_id;
  var is_admin;

  bool? updateMode = false;

  ResetForm(field) {
    widget.formKey.currentState.fields[field].didChange('');
  }

//////////////////////////////////////
// GET REQUIREMENTS :
//////////////////////////////////////
  GetLocalStorageData() async {
    var error_resp;
    try {
      final data = widget.data;
      error_resp = data;
      return data;
    } catch (e) {
      return error_resp;
    }
  }


  @override
  Widget build(BuildContext context) {
    formfield_width = 500;
    form_fontSize = 15;
    form_hint_fontSize = 14;

    // DEFAULT :
    if (context.width > 1500) {
      formfield_width = 500;
      form_fontSize = 15;
      form_hint_fontSize = 14;
      print('greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      formfield_width = 490;
      form_fontSize = 15;
      form_hint_fontSize = 14;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      formfield_width = 480;
      form_fontSize = 15;
      form_hint_fontSize = 14;
      print('800');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      formfield_width = 480;
      form_fontSize = 14;
      form_hint_fontSize = 13;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      form_fontSize = 13;
      form_hint_fontSize = 12;
      formfield_width = 470;
      print('480');
    }

    //////////////////////////////////////
    /// SET REQUIREMENTS :
    //////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading User Details',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data);
          }
          return MainMethod(context, snapshot.data);
        });
  }

  ///////////////////////////////////
  /// MAIN METHOD :
  ///////////////////////////////////
  Container MainMethod(BuildContext context, data) {
    return Container(
      width: formfield_width,
      alignment: Alignment.center,
      child: FormBuilder(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // FOUNDER FIELD :
                Container(
                  margin: EdgeInsets.only(top: context.width * 0.01),
                  width: contact_formfield_width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputField(
                          context: context,
                          name: 'founder_name',
                          error_text: 'Founder name required',
                          lable_text: 'Founder',
                          hind_text: 'Founder name',
                          initial_val: data['name'],
                        ),

                      ],
                    ),
                  ),
                ),

                // CONTACT HEADING SECTION:
                Container(
                    margin: EdgeInsets.only(
                        top: context.height * contact_text_margin_top),
                    child: AutoSizeText.rich(TextSpan(
                        style: Get.textTheme.headline2,
                        children: const [
                          TextSpan(
                            text: 'Primary Contact',
                          )
                        ]))),

                // TAKE FOUNDER INOF:
                const SizedBox(
                  height: 20,
                ),

                Card(
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
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
                                  initial_val: data['phone_no'],
                                ),
                                SecondaryInputField(
                                  context: context,
                                  name: 'email',
                                  lable_text: 'Email',
                                  hind_text: 'personal email',
                                  error_text: 'primay eamil required ',
                                  initial_val: data['primary_mail'],
                                ),
                                SecondaryInputField(
                                  context: context,
                                  name: 'other_info',
                                  lable_text: 'Other',
                                  hind_text: 'optional contact',
                                  error_text: '',
                                  require: false,
                                  initial_val: data['other_contact'],
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

//////////////////////////////////
  /// EXTERNAL METHODS ;
//////////////////////////////////
  FormBuilderTextField InputField(
      {context,
      name,
      error_text,
      lable_text,
      hind_text,
      require = true,
      initial_val}) {
    return FormBuilderTextField(
      initialValue: initial_val,
      textAlign: TextAlign.center,
      name: name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_text_color,
        fontSize: form_fontSize,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.minLength(1, errorText: error_text)]),
      decoration: InputDecoration(
        labelText: lable_text,

        labelStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: input_label_color,
            fontSize: form_hint_fontSize,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),

        hintStyle:
            TextStyle(fontSize: form_hint_fontSize, color: input_hind_color),

        suffix: InkWell(
          onTap: () {
            ResetForm(name);
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

  // Secondary Input field :
  FormBuilderTextField SecondaryInputField({
    context,
    name,
    error_text,
    lable_text,
    hind_text,
    require = true,
    initial_val,
  }) {
    return FormBuilderTextField(
      initialValue: initial_val,
      textAlign: TextAlign.center,
      name: name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_text_color,
        fontSize: form_fontSize,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(1,
            allowEmpty: name == 'other_info' ? true : false,
            errorText: error_text)
      ]),
      decoration: InputDecoration(
        labelText: lable_text,
        labelStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: input_label_color,
            fontSize: form_hint_fontSize,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(
            fontSize: form_hint_fontSize, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetForm(name);
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
