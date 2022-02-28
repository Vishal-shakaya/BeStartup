import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductForm extends StatefulWidget {
  BuildContext? context;
  Function removeProduct;
  Function setFormData;
  Key? product_key;
  ProductForm(
      {Key? key,
      this.context,
      required this.removeProduct,
      required this.setFormData,
      required this.product_key})
      : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool selected_tag_prod = false;
  Color suffix_icon_color = Colors.blueGrey.shade300;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;

  Color del_btn_active_color = Colors.red.shade400;
  Color del_btn_default_color = Colors.red.shade200;
  Color del_btn_color = Colors.red.shade200;

  double del_btn_bottom_margin = 135;
  double tag_btn_bottom_margin = 30;
  int maxlines = 10;

  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////
  SubmitProductForm() {
       formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      print('form submited');
      final heading = formKey.currentState!.value['prod_head'];
      final description = formKey.currentState!.value['prod_desc'];

      widget.setFormData(widget.key, heading, description);
    }
  }

  /// RESET FORM :
  ResetProductForm() {
    formKey.currentState!.reset();
  }

  ToogleProduct() {
    setState(() {
      selected_tag_prod = !selected_tag_prod;
    });
  }

  @override
  Widget build(BuildContext context) {
    double form_width_factor = 0.7;

    // DEFAULT BREAK POINTS :
    if (context.width > 1000) {
      form_width_factor = 0.7;
      del_btn_bottom_margin = 135;
      tag_btn_bottom_margin = 30;
    }

    if (context.width < 1000) {
      form_width_factor = 0.6;
    }

    // TABLET :
    if (context.width < 800) {
      form_width_factor = 0.8;
      maxlines = 6;
      del_btn_bottom_margin = 70;
      print('width 800 ');
    }
    // SMALL TABLET:
    if (context.width < 640) {
      form_width_factor = 0.8;
      maxlines = 6;
      print('width 640 ');
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // FORM BLOCK :
          FractionallySizedBox(
            widthFactor: form_width_factor,
            child: FormBuilder(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // PRODUCT HEADING:
                      ProductHeading(context),

                      // SPACING :
                      const SizedBox(
                        height: 25,
                      ),

                      // PROD DESCRIPTION BOX :
                      Container(
                        width: context.width * 0.8,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: ProductDescription(context),
                            ),
                            Column(
                              children: [
                                // DELETE PRODUCT :
                                DeleteIcon(context),

                                // SELECT TYPE OF TAG :
                                TagsType(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

//////////////////////////////////////////
  /// DELETE ICON :
//////////////////////////////////////////
  Container DeleteIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: del_btn_bottom_margin),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              widget.removeProduct(widget.product_key);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 10,
              shadowColor: Colors.blueGrey,
              child: MouseRegion(
                onHover: (d) {
                  setState(() {
                    del_btn_color = del_btn_active_color;
                  });
                },
                onExit: (e) {
                  setState(() {
                    del_btn_color = del_btn_default_color;
                  });
                },
                child: CircleAvatar(
                    radius: 13,
                    backgroundColor: del_btn_color,
                    child: Icon(Icons.close,
                        size: 14,
                        // size:15,
                        color: Colors.white)),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              SubmitProductForm();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 10,
              shadowColor: Colors.blueGrey,
              child: MouseRegion(
                onHover: (d) {
                  setState(() {
                    del_btn_color = del_btn_active_color;
                  });
                },
                onExit: (e) {
                  setState(() {
                    del_btn_color = del_btn_default_color;
                  });
                },
                child: CircleAvatar(
                    radius: 13,
                    backgroundColor: del_btn_color,
                    child: Icon(Icons.close,
                        size: 14,
                        // size:15,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////
  /// SIDE BAR TAG BUTTON :
  /// SELECT TYPE OF SECTION :
  /// 1 PRODCUT  :
  /// 2 SERVIECE :
  /////////////////////////////////
  Container TagsType(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: tag_btn_bottom_margin),
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () {
                ToogleProduct();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 10,
                shadowColor: Colors.blueGrey,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: selected_tag_prod
                      ? Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        )
                      : Text('P',
                          style: TextStyle(
                              color: Colors.white,
                              // fontSize: 15,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () {
                ToogleProduct();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 10,
                shadowColor: Colors.blueGrey,
                child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.blue.shade300,
                    child: selected_tag_prod
                        ? Text('S',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                        : Icon(Icons.check, size: 15, color: Colors.white)),
              ),
            ),
          ],
        ));
  }

  /////////////////////////////////
  /// HEADING TEXT FIELD :
  /////////////////////////////////
  FormBuilderTextField ProductHeading(BuildContext context) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: 'prod_head',
      style: Get.textTheme.headline2,
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 3,
            errorText: 'At least 3 char allow')
      ]),
      decoration: InputDecoration(
        hintText: 'Representative Heading',
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetProductForm();
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
    );
  }

  /////////////////////////////////
// DESCRIPTION SECTION :
/////////////////////////////////
  FormBuilderTextField ProductDescription(BuildContext context) {
    return FormBuilderTextField(
      name: 'prod_desc',
      style: GoogleFonts.robotoSlab(
        fontSize: 16,
      ),
      maxLength: 2000,
      scrollPadding: EdgeInsets.all(10),
      maxLines: maxlines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 40,
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
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 1.5, color: Colors.blueGrey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: primary_light)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
