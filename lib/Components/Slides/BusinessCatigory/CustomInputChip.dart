import 'package:be_startup/Components/Slides/BusinessCatigory/CatigoryChip.dart';
import 'package:be_startup/Components/Slides/BusinessCatigory/RemovableChip.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomInputChip extends StatefulWidget {
  CustomInputChip({Key? key}) : super(key: key);

  @override
  State<CustomInputChip> createState() => _CustomInputChipState();
}

class _CustomInputChipState extends State<CustomInputChip> {
  final formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double chip_input_top_margin = 0.08;
  double vision_cont_width = 0.60;
  double con_button_width = 100;
  double con_button_height = 35;
  double con_btn_top_margin = 30;

  List<RemovableChip> custom_business_catigory_list = [];

  RemoveChip(val) {
    setState(() {
      custom_business_catigory_list.removeWhere((element) {
        return element.catigory == val;
      });
    });
  }

  ///////////////////////////////////////
  // 1. CREATE INPUT CHIP
  // 2. STORE IN CHIP LIST :
  // 3. THEN SET STATE :
  //////////////////////////////////////////
  SubmitCatigory(context) {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      final val = formKey.currentState!.value['custom_catigory'];

      // DUBLICATE TAG FILTER :
      // SHOW ALERT IF TAG DUBLICATE FOUND :
      // RETURN :
      bool is_dub_catigory = false;
      custom_business_catigory_list.forEach((element) {
        if (element.catigory == val) {
          is_dub_catigory = true;
        }
      });

      // WARNING ALERT TO ADD ANOTHER CATIGORY :
      // RETURN FUNCTION :
      if (is_dub_catigory) {
        CoolAlert.show(
            context: context,
            width: 200,
            title: 'Dublicate Catigory',
            type: CoolAlertType.warning,
            widget: Text(
              'you already add this catigory',
              style: TextStyle(
                  color:
                      Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
                  fontWeight: FontWeight.bold),
            ));
        return;
      }

      // Create Input Chip:
      final custom_cat = RemovableChip(
        key: UniqueKey(),
        catigory: val,
        removeFun: RemoveChip,
      );

      // Update UI :
      setState(() {
        custom_business_catigory_list.add(custom_cat);
      });

      formKey.currentState!.reset();
    } else {}
  }

  ResetCatigory() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: context.height * chip_input_top_margin),
        child: Column(
          children: [
            // CUSTION CHIPS :
            Container(
              width: context.width * vision_cont_width,
              padding: EdgeInsets.all(8),
              child: Wrap(
                spacing: 5,
                children: custom_business_catigory_list,
              ),
            ),

            FormBuilder(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      textAlign: TextAlign.center,
                      name: 'custom_catigory',
                      style: Get.textTheme.headline3,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 3,
                            errorText: 'At least 3 char allow')
                      ]),
                      decoration: InputDecoration(
                        hintText: 'Type your business catigory',
                        contentPadding: EdgeInsets.all(16),
                        hintStyle: TextStyle(
                            fontSize: 27, color: Colors.grey.shade300),

                        suffix: InkWell(
                          onTap: () {
                            ResetCatigory();
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

            Container(
              margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
              child: InkWell(
                highlightColor: primary_light_hover,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20)),
                onTap: () {
                  SubmitCatigory(context);
                },
                child: Card(
                  elevation: 10,
                  shadowColor: light_color_type3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    width: con_button_width,
                    height: con_button_height,
                    decoration: BoxDecoration(
                        color: primary_light,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20))),
                    child: const Text(
                      'continue',
                      style: TextStyle(
                          letterSpacing: 2.5,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
