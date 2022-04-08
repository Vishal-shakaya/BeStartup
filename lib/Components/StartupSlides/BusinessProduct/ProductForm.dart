import 'package:be_startup/Backend/Startup/BusinessProductStore.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductForm extends StatefulWidget {
  ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormBuilderState>();
  int maxlines = 10;
  double con_button_width = 90;
  double con_button_height = 38;
  double con_btn_top_margin = 10;
  double form_width = 0.32;
  double form_height = 0.60;

  final productStore = Get.put(BusinessProductStore(), tag: 'productList');

  ////////////////////////////////////////////////
  /// SUBMIT PRODUCT :
  /// 1. SHOW LOADING SPINNER UNTIL SUBMIT FORM :
  /// 2. IF SUBMIT SUCCESS THEN EXIT MODEL :
  /// 3. IF ERROR THEN SHOW WARNING ALERT :
  /// /////////////////////////////////////////////
  SubmitProductForm({type=ProductType.product}) async {
    formKey.currentState!.save();
    SmartDialog.showLoading(
        background: Colors.white,
        maskColorTemp: Color.fromARGB(146, 252, 250, 250),
        widget: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ));

    if (formKey.currentState!.validate()) {
      var product_title = formKey.currentState!.value['product_title'];
      var product_desc = formKey.currentState!.value['product_desc'];

      // STORE PRODUCT TO BACKEND:
      var res = await productStore.SetProduct(
          title: product_title, 
          description: product_desc,
          );
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
    return Container(
      padding: EdgeInsets.only(left: 40),
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
        borderRadius: BorderRadius.horizontal(
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
            child: const Text(
              'submit',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilderTextField ProductDescInput(BuildContext context) {
    return FormBuilderTextField(
      name: 'product_desc',
      style: GoogleFonts.robotoSlab(
        fontSize: 16,
      ),
      maxLength: 1000,
      scrollPadding: EdgeInsets.all(10),
      maxLines: maxlines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 40,
            errorText: 'At least 50 char allow')
      ]),
      decoration: InputDecoration(
          helperText: 'min allow 50 ',
          hintText: "Product detail",
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

  FormBuilderTextField ProductTitleInput(BuildContext context) {
    return FormBuilderTextField(
      textAlign: TextAlign.center,
      name: 'product_title',
      maxLength: 100,
      style: Get.theme.textTheme.headline2,
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(context, 3,
            errorText: 'At least 3 char allow'),
        FormBuilderValidators.maxLength(context, 50,
            errorText: 'Max 100 char allow')
      ]),
      decoration: InputDecoration(
        hintText: 'Title',
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetForm();
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.grey.shade400,
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
