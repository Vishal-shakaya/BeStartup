import 'package:be_startup/Utils/Colors.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  dynamic  formkey; 
  
  // CustomInputField({ this.header_label_text ,  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        /////////////////////////////////////
        // HEADER SECTION :
        // 1. Header label text:
        // 2. Input Label tect :
        // 3. Error text :
        // 4. Hint text :
        ///////////////////////////////////////
        Container(
          padding: EdgeInsets.all(4),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10),
          child: Text('Email addresss',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: input_label_color)),
        ),

        // EMAIL INPUT FILED :
        FormBuilderTextField(
          name: 'email',
          style: TextStyle(
              fontSize: 15,
              fontWeight: Get.isDarkMode ? FontWeight.w400 : FontWeight.w600,
              color: input_text_color),
          keyboardType: TextInputType.emailAddress,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.email( errorText: 'enter valid email')
          ]),
          decoration: InputDecoration(
              hintText: 'enter mail ',
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Colors.orange.shade300,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(width: 1.5, color: Colors.teal.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: input_foucs_color)),
              // errorText: 'invalid email address',
              // constraints: BoxConstraints(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ],
    ));
  }
}
