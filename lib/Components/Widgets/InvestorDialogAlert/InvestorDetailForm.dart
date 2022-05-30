import 'package:be_startup/Components/RegistorTeam/RegistorTeam/MemberListView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestorDetailForm extends StatefulWidget {
  GlobalKey<FormBuilderState>? formkey;
  Function ResetForm;
  InvestorFormType? form_type;
  var member; 
  InvestorDetailForm({
    this.form_type, 
    this.member,
    required this.ResetForm, this.formkey, Key? key})
      : super(key: key);

  @override
  State<InvestorDetailForm> createState() => _InvestorDetailFormState();
}

class _InvestorDetailFormState extends State<InvestorDetailForm> {
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
                              // initial_value:widget.member['name'],
                              context: context,
                              name: 'name',
                              lable_text: 'Full name',
                              hind_text: 'enter name',
                              error_text: 'name field required',
                              initial_val: 
                              widget.form_type == InvestorFormType.edit? widget.member['name'] :''
                            ),
                            SecondaryInputField(
                              context: context,
                              name: 'position',
                              lable_text: 'Position',
                              hind_text: 'type',
                              error_text: 'member position required',
                              initial_val: 
                              widget.form_type == InvestorFormType.edit? widget.member['position']:''
                            ),
                            SecondaryInputField(
                              context: context,
                              name: 'email',
                              lable_text: 'Email',
                              hind_text: 'contact email',
                              error_text: '',
                              require: false,
                              initial_val:
                               widget.form_type == InvestorFormType.edit?widget.member['email']:''
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
      {context, name,   error_text, lable_text, hind_text, require = true,
        initial_val
      }) {
    return FormBuilderTextField(
      initialValue: initial_val!=''?initial_val:'',
      textAlign: TextAlign.center,
      name: name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: light_color_type1,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.minLength(context, 1, errorText: error_text)]),
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
            widget.ResetForm(name);
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
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
