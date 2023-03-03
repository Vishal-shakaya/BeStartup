import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductForm extends StatefulWidget {
  String? title = '';
  String? description = '';
  String? form_type = '';
  String? id;
  int? product_index;
  ProductForm(
      {this.id,
      this.product_index,
      this.form_type,
      this.title,
      this.description,
      Key? key})
      : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormBuilderState>();
  int maxlines = 10;
  double con_button_width = 90;
  double con_button_height = 38;
  double con_btn_top_margin = 10;

  double submit_btn_fontSize = 16;

  double form_left_padding = 40;
  double form_width = 0.32;
  double form_height = 0.60;

  double prod_title_fontSize = 18;
  double prod_desc_fontSize = 16;

  final productStore = Get.put(BusinessProductStore(), tag: 'productList');

  ////////////////////////////////////////////////
  /// SUBMIT PRODUCT :
  /// 1. SHOW LOADING SPINNER UNTIL SUBMIT FORM :
  /// 2. IF SUBMIT SUCCESS THEN EXIT MODEL :
  /// 3. IF ERROR THEN SHOW WARNING ALERT :
  /// /////////////////////////////////////////////
  SubmitProductForm({type = ProductType.product}) async {
    formKey.currentState!.save();
    SmartDialog.showLoading(
      builder: (context) {
        return CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ); 
      },
    );

    if (formKey.currentState!.validate()) {
      var product_title = formKey.currentState!.value['product_title'];
      var product_desc = formKey.currentState!.value['product_desc'];

      // STORE PRODUCT TO BACKEND:
      var res;
      if (widget.form_type == 'update') {
        // print('UPDATE PRODUCT START');
        res = await productStore.UpdateProduct(
            title: product_title,
            description: product_desc,
            id: widget.id,
            index: widget.product_index);
      } else {
        res = await productStore.CreateProduct(
          title: product_title,
          description: product_desc,
        );
      }
      if (!res['response']) {
        // CLOSE SNAKBAR :
        SmartDialog.dismiss();
        Get.closeAllSnackbars();
        // Error Alert :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Error  accure'),
          messageText: MySnackbarContent(message: 'Something went wrong'),
          maxWidth: context.width * 0.50,
        );
        return;
      }
      SmartDialog.dismiss();
      Navigator.of(context).pop();
    }
    SmartDialog.dismiss();
  }

  ResetForm() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    if (context.width > 1500) {
      form_width = 0.32;
      form_height = 0.60;
      maxlines = 10;
      prod_title_fontSize = 18;
      prod_desc_fontSize = 16;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1450) {
      form_width = 0.38;
      print('1450');
    }

    if (context.width < 1300) {
      form_width = 0.40;
      form_height = 0.60;
      maxlines = 9;
      print('1300');
    }

    if (context.width < 1200) {
      maxlines = 7;
      prod_title_fontSize = 17;
      prod_desc_fontSize = 15;
      print('1200');
    }

    if (context.width < 1100) {
      maxlines = 6;
      print('1100');
    }

    if (context.width < 1000) {
      form_width = 0.55;
      form_height = 0.60;
      maxlines = 8;
      prod_title_fontSize = 15;
      prod_desc_fontSize = 14;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      form_width = 0.55;
      form_height = 0.60;
      maxlines = 7;

      submit_btn_fontSize = 14;
      con_button_width = 85;
      con_button_height = 30;
      con_btn_top_margin = 15;

      prod_title_fontSize = 15;
      prod_desc_fontSize = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      form_width = 0.55;
      form_height = 0.60;
      maxlines = 6;

      submit_btn_fontSize = 15;
      con_button_width = 88;
      con_button_height = 30;
      con_btn_top_margin = 15;

      prod_title_fontSize = 15;
      prod_desc_fontSize = 14;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      form_width = 0.99;
      form_height = 0.60;
      maxlines = 6;
      form_left_padding = 0;

      submit_btn_fontSize = 12;
      con_button_width = 80;
      con_button_height = 30;
      con_btn_top_margin = 15;

      prod_title_fontSize = 15;
      prod_desc_fontSize = 13;
      print('480');
    }

    return Container(
      padding: EdgeInsets.only(left: form_left_padding),
      width: context.width * form_width,
      height: context.height * form_height,
      child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // PRODUCT TITLE :
                ProductTitleInput(context),

                // PRODUCT DESCRIPTION:
                ProductDescInput(context),

                // SUBMIT PRODUCT BUTTON:
                ProductSubmitButton()
              ],
            ),
          )),
    );
  }

  Container ProductSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 0),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () {
          SubmitProductForm();
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
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Text(
              'submit',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: submit_btn_fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilderTextField ProductDescInput(BuildContext context) {
    return FormBuilderTextField(
      initialValue: widget.description,
      name: 'product_desc',
      style: GoogleFonts.robotoSlab(
        fontSize: prod_desc_fontSize,
      ),
      maxLength: 1000,
      scrollPadding: EdgeInsets.all(10),
      maxLines: maxlines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(40,
            errorText: 'At least 50 char allow')
      ]),
      decoration: InputDecoration(
          helperText: 'min allow 50 ',
          hintText: "Product detail",
          hintStyle: TextStyle(
              color: Colors.blueGrey.shade200, fontSize: prod_desc_fontSize),
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

  FormBuilderTextField ProductTitleInput(BuildContext context) {
    return FormBuilderTextField(
      initialValue: widget.title,
      textAlign: TextAlign.center,
      name: 'product_title',
      maxLength: 100,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: input_text_color,
        fontSize: prod_title_fontSize,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(  3,
            errorText: 'At least 3 char allow'),
        FormBuilderValidators.maxLength(  50,
            errorText: 'Max 100 char allow')
      ]),
      decoration: InputDecoration(
        hintText: 'Title',
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(
            fontSize: prod_title_fontSize, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetForm();
          },
          child: Container(
              child: FaIcon(
            my_cancel_icon,
            size: 16,
            color: cancel_btn_color,
          )),
        ),

        // focusColor:Colors.pink,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: primary_light)),
      ),
    );
  }
}
