import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BusinessForm extends StatefulWidget {
  var formKey;
  BusinessForm({this.formKey, Key? key}) : super(key: key);

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  var detailStore = Get.put(BusinessDetailStore(), tag: 'business_store');

  bool is_password_visible = true;

  String? value = '';

  var initial_val;

  double? input_section_width = 500;

  double? input_field_fontsize = 22;

  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  ResetBusinessform(field) {
    widget.formKey.currentState.fields[field].didChange('');
  }

/////////////////////////////////
  /// GET REQUIREMENTS :
/////////////////////////////////
  GetRequiredData() async {
    try {
      var data = await detailStore.GetCachedBusinessDetail();
      initial_val = data['data'];
      return initial_val;
    } catch (e) {
      return initial_val;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      print('1200');
    }

    if (context.width < 1000) {
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      input_section_width = 450;
      input_field_fontsize = 20;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      input_section_width = 400;
      input_field_fontsize = 18;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      input_section_width = 300;
      input_field_fontsize = 18;
      print('480');
    }

    /////////////////////////////////
    /// SET REQUIREMENTS :
    /////////////////////////////////
    return FutureBuilder(
        future: GetRequiredData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Input Section',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
                context,
                snapshot
                    .data); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
          return MainMethod(context, snapshot.data);
        });
  }

  //////////////////////////////////
  /// MAIN METHOD :
  //////////////////////////////////
  Column MainMethod(BuildContext context, data) {
    return Column(
      children: [
        Container(
          height: context.height * 0.3,
          margin: EdgeInsets.only(top: context.height * 0.05),
          width: input_section_width,
          child: FormBuilder(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: context.height * 0.01),
                      child: DetailViewInputField(
                        initial_val: data['name'],
                        context: context,
                        field_name: 'startup_name',
                        error_text: 'Startup name required',
                        hint_text: 'Enter Startup Name',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: context.height * 0.06),
                      child: DetailViewInputField(
                        initial_val: '${data['desire_amount']}',
                        context: context,
                        field_name: 'desire_amount',
                        error_text: 'Desire amount required',
                        hint_text: '₹ Desire Amount ',
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  FormBuilderTextField DetailViewInputField(
      {initial_val, context, field_name, error_text, hint_text}) {
    return FormBuilderTextField(
      initialValue: initial_val,
      textAlign: TextAlign.center,
      name: field_name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_text_color,
        fontSize: input_field_fontsize,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: field_name == 'desire_amount'
          ? FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1, errorText: error_text),
              FormBuilderValidators.integer(errorText: 'enter valid amount')
            ])
          : FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1, errorText: error_text),
            ]),
      decoration: InputDecoration(
        hintText: hint_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 18, color: input_hind_color),

        suffix: IconButton(
          onPressed: () {
            ResetBusinessform(field_name);
          },
          icon: FaIcon(
            my_cancel_icon,
            color: cancel_btn_color,
            size: 18,
          ),
        ),

        // focusColor:Colors.pink,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: primary_light)),
      ),
    );
  }
}
