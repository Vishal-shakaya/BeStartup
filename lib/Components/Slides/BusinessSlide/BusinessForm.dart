import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BusinessForm extends StatefulWidget {
  BusinessForm({Key? key}) : super(key: key);

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

// SUBMIT  FORM :
  SubmitBusinessDetail() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      // String email = formKey.currentState!.value['email'];
      formKey.currentState!.reset();
    } else {
      print('error found');
    }
  }

  ResetBusinessform() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
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
                hintStyle: TextStyle(fontSize: 27, color: Colors.grey.shade300),

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
                    borderSide: BorderSide(width: 2, color: primary_light)),
              ),
            ),
          ],
        ));
  }
}
