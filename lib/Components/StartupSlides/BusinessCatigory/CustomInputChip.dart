import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessCatigoryStore.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CatigoryChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/RemovableChip.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputChip extends StatefulWidget {
  List defualt_custom_chip = [];
  CustomInputChip({required this.defualt_custom_chip, Key? key})
      : super(key: key);

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

  double chip_input_top_margin = 0.05;
  double vision_cont_width = 0.60;

  double con_button_width = 100;
  double con_button_height = 35;
  double con_btn_top_margin = 30;

  double input_fontSize = 22;

  double input_section_width = 0.60;

  double? add_btn_fontSize = 16;

  List<RemovableChip> custom_business_catigory_list = [];
  var catigoryStore = Get.put(BusinessCatigoryStore(), tag: 'catigory_store');

  // REMOVE CHIP HANDLER :
  RemoveChip(val) async {
    setState(() {
      custom_business_catigory_list.removeWhere((element) {
        return element.catigory == val;
      });
    });

    // UPLDATE BACKEND :
    var res = await catigoryStore.RemoveCatigory(cat: val);
    if (!res['response']) {
      Get.closeAllSnackbars();
      Get.snackbar(
        '',
        '',
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Error accure'),
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: context.width * 0.50,
      );
    }
  }

  ///////////////////////////////////////
  // 1. CREATE INPUT CHIP
  // 2. STORE IN CHIP LIST :
  // 3. THEN SET STATE :
  //////////////////////////////////////////
  SubmitCatigory(context, snack_width) async {
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

      // CREATIN CUSTOM CHIP WIDGET :
      final custom_cat = RemovableChip(
        key: UniqueKey(),
        catigory: val,
        removeFun: RemoveChip,
      );

      // Update UI :
      setState(() {
        custom_business_catigory_list.add(custom_cat);
      });
      ///////////////////////////////////////////
      // STORE CHIP IN BACKGROUND:
      // GET RESPONSE SUCCESS OR ERROR:
      // IF GET ERROR THEN SHOW ERROR ALERT :
      ///////////////////////////////////////////
      var res = await catigoryStore.SetCatigory(cat: val);
      if (!res['response']) {
        // CLOSE SNAKBAR :
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(width: snack_width));
      }

      // Reset form :
      formKey.currentState!.reset();
    } else {
      // CLOSE SNAKBAR :
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(width: snack_width));
    }
  }

  // Reset Form :
  ResetCatigory() {
    formKey.currentState!.reset();
  }

  @override
  void initState() {
    // Set Default Custom Chips :
    widget.defualt_custom_chip.forEach((el) {
      final custom_cat = RemovableChip(
        key: UniqueKey(),
        catigory: el,
        removeFun: RemoveChip,
      );

      if (!business_catigories.contains(el)) {
        custom_business_catigory_list.add(custom_cat);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snack_width = MediaQuery.of(context).size.width * 0.50;

    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      con_button_width = 100;
      print('1200');
    }

    if (context.width < 1000) {
      input_section_width = 0.70;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      con_button_width = 80;
      con_button_height = 30;
      add_btn_fontSize = 14;

      input_fontSize = 20;
      input_section_width = 0.80;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      con_button_width = 75;
      con_button_height = 28;
      add_btn_fontSize = 13;

      input_section_width = 0.85;
      input_fontSize = 18;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      con_button_width = 75;
      con_button_height = 28;
      add_btn_fontSize = 13;

      input_section_width = 0.85;
      input_fontSize = 18;
      print('480');
    }

    return Container(
        width: context.width * input_section_width,
        margin: EdgeInsets.only(top: context.height * chip_input_top_margin),
        child: Column(
          children: [
            // CUSTION CHIPS :
            PredefineChipSection(context),

            // CUSTOM CATIGORY FORM :
            FormBuilder(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    ChipInputField(context),
                  ],
                )),

            // SUBMIT BUTTON :
            ChipAddButton(context, snack_width)
          ],
        ));
  }

  ////////////////////////////////////
  /// EXTERNAL COMPONENTS :
  ////////////////////////////////////

  Container ChipAddButton(BuildContext context, snack_width) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () {
          SubmitCatigory(context, snack_width);
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            width: con_button_width,
            height: con_button_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Text(
              'Add',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: add_btn_fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilderTextField ChipInputField(BuildContext context) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: 'custom_catigory',
      style: GoogleFonts.robotoSlab(
        textStyle: const TextStyle(),
        color: input_text_color,
        fontSize: input_fontSize,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength( 3,
            errorText: 'At least 3 char allow')
      ]),
      decoration: InputDecoration(
        hintText: 'Add Catigory',
        contentPadding: const EdgeInsets.all(16),

        hintStyle: TextStyle(fontSize: input_fontSize, color: input_hind_color),

        suffix: InkWell(
          onTap: () {
            ResetCatigory();
          },
          child: Container(
              child: FaIcon(
            my_cancel_icon,
            color: cancel_btn_color,
            size: 18,
          )),
        ),

        // focusColor:Colors.pink,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: primary_light)),
      ),
    );
  }

  Container PredefineChipSection(BuildContext context) {
    return Container(
      width: context.width * vision_cont_width,
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 5,
        children: custom_business_catigory_list,
      ),
    );
  }
}
