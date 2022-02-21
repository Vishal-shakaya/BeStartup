import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  final formKey = GlobalKey<FormBuilderState>();

  double prod_cont_width = 0.80;
  double prod_cont_height = 0.90;
  double image_sec_height = 0.33;
  double image_sec_width = 0.04;
  double heading_text_width = 200;

  Color suffix_icon_color = Colors.blueGrey.shade300;
  int maxlines = 10;

  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////

  SubmitProductForm() {
    if (formKey.currentState!.validate()) {
      final heading = formKey.currentState!.value['heading'];
      final description = formKey.currentState!.value['description'];
    }


  }

  /// RESET FORM :
  ResetProductForm() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * prod_cont_width,
      height: context.height * prod_cont_height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: Container()),
              Container(
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primary_light)),
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('Add')))
            ],
          ),

          ////////////////////////////////////////////////
          // PRODUCT SECTION;
          ////////////////////////////////////////////////
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE SECTION :
                Expanded(
                  flex: 1,
                  child: Container(
                    height: context.height * image_sec_height,
                    width: context.width * image_sec_width,
                    margin: EdgeInsets.only(top: 29),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                        border: Border.all(width: 2, color: Colors.black54)),
                    child: AutoSizeText.rich(
                        TextSpan(style: Get.textTheme.headline3, children: [
                      TextSpan(
                          text: product_image_subhead,
                          style: TextStyle(
                              color: Colors.blueGrey.shade200,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ])),
                  ),
                ),

                ////////////////////////////////////////////////
                // PRODUCT TITLE AND DESCRIPTION SECTION :
                ////////////////////////////////////////////////
                Container(
                  child: Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: FormBuilder(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                    textAlign: TextAlign.center,
                                    name: 'prod_heading',
                                    style: Get.textTheme.headline2,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.minLength(
                                          context, 3,
                                          errorText: 'At least 3 char allow')
                                    ]),
                                    decoration: InputDecoration(
                                      hintText: 'Type your business catigory',
                                      contentPadding: EdgeInsets.all(16),
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade300),

                                      suffix: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: suffix_icon_color,
                                          ),
                                        ),
                                      ),

                                      // focusColor:Colors.pink,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2, color: primary_light)),
                                    ),
                                  ),

                                  // PROD DESCRIPTION BOX :
                                  SizedBox(
                                    height: 20,
                                  ),

                                  FormBuilderTextField(
                                    name: 'prod_desc',
                                    style: GoogleFonts.robotoSlab(
                                      fontSize: 16,
                                    ),
                                    maxLength: 2000,
                                    scrollPadding: EdgeInsets.all(10),
                                    maxLines: maxlines,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.minLength(
                                          context, 40,
                                          errorText: 'At least 40 char allow')
                                    ]),
                                    decoration: InputDecoration(
                                        helperText: 'min allow 200 ',
                                        hintText: "Product revision",
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade200,
                                        ),
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.all(20),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color:
                                                    Colors.blueGrey.shade200)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: primary_light)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded(
                //   flex: 1,
                //   child: Container())
              ],
            ),
          )
        ],
      ),
    );
  }
}
