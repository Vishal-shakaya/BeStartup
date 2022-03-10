import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BusinessForm extends StatefulWidget {
  var formKey; 
  BusinessForm({
    this.formKey, 
    Key? key}) : super(key: key);

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

////////////////////////////////////////
// SLIDE 1 :
// SUBMIT  BUSINESS DETIAL :
////////////////////////////////////////

  ResetBusinessform() {
    widget.formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: context.height * 0.3,
          margin: EdgeInsets.only(top: context.height * 0.15),
          width: 500,
          child: FormBuilder(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  FormBuilderTextField(
                    textAlign: TextAlign.center,
                    name: 'startup_name',
                    style: Get.textTheme.headline3,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 1,
                          errorText: 'Startup name required ')
                    ]),
                    decoration: InputDecoration(
                      hintText: 'Enter Startup Name',
                      contentPadding: EdgeInsets.all(16),
                      hintStyle:
                          TextStyle(fontSize: 27, color: Colors.grey.shade300),

                      suffix: InkWell(
                        onTap: () {
                          ResetBusinessform();
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
                          borderSide:
                              BorderSide(width: 2, color: primary_light)),
                    ),
                  ),
                ],
              )),
        ),


      ],
    );
  }
}
