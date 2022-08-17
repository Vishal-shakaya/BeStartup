import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Components/Widgets/CustomInputField.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
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
      var data = await detailStore.GetBusinessDetail();
      initial_val = data;
      return initial_val;
    } catch (e) {
      return initial_val;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          width: 500,
          child: FormBuilder(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.disabled,
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
        color: light_color_type2,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: field_name == 'desire_amount'
          ? FormBuilderValidators.compose([
              FormBuilderValidators.minLength(context, 1,
                  errorText: error_text),
              FormBuilderValidators.integer(context,
                  errorText: 'enter valid amount')
            ])
          : FormBuilderValidators.compose([
              FormBuilderValidators.minLength(context, 1,
                  errorText: error_text),
            ]),
      decoration: InputDecoration(
        hintText: hint_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 22, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetBusinessform(field_name);
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
              color: suffix_icon_color,
              size: 18,
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
