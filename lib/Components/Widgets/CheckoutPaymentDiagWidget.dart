import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginated_search_bar/widgets/line_spacer.dart';

class CheckoutPaymentDialogWidget extends StatefulWidget {
  CheckoutPaymentDialogWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutPaymentDialogWidget> createState() =>
      _CheckoutPaymentDialogWidgetState();
}

class _CheckoutPaymentDialogWidgetState
    extends State<CheckoutPaymentDialogWidget> {
  GlobalKey<FormBuilderState>? formkey;
  // THEME  COLOR :
  Color input_text_color = Get.isDarkMode ? dartk_color_type2 : light_black;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  Color input_label_color =
      Get.isDarkMode ? dartk_color_type4 : light_color_type1!;
  Color suffix_icon_color = Colors.blueGrey.shade300;

  double formfield_width = 400;
  double contact_formfield_width = 400;
  double contact_text_margin_top = 0.05;

  // RESET FORM :
  ResetForm(field) {
    formkey?.currentState?.fields[field]!.didChange('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon:
                    Icon(Icons.cancel_outlined, size: 18, color: Colors.grey)),
          ),
          Container(
            alignment: Alignment.center,
            child: AutoSizeText.rich(
              TextSpan(
                  text: 'Confirm Order',
                  style: TextStyle(fontSize: 19, color: light_color_type3)),
              style: Get.textTheme.headline3,
            ),
          ),
          Container(
            width: formfield_width,
            alignment: Alignment.center,
            child: FormBuilder(
                key: formkey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TAKE FOUNDER INOF:
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Container(
                              width: contact_formfield_width,
                              child: Column(
                                children: [
                                  SecondaryInputField(
                                    context: context,
                                    name: 'name',
                                    lable_text: 'Name',
                                    hind_text: 'enter name',
                                    error_text: 'name field required',
                                    // initial_value:widget.member['name'],
                                  ),
                                  SecondaryInputField(
                                      context: context,
                                      name: 'email',
                                      lable_text: 'Email',
                                      hind_text: 'enter email',
                                      error_text: '',
                                      require: false,
                                      initial_val: 'shakyavishal@gmail.com'),
                                  SecondaryInputField(
                                      context: context,
                                      name: 'phone_no',
                                      lable_text: 'phone no',
                                      hind_text: 'enter number',
                                      error_text: 'phone no required required',
                                      initial_val: '7065121120'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: context.height * 0.03),
            alignment: Alignment.center,
            child: AutoSizeText.rich(
              TextSpan(
                  text: 'Order Summary',
                  style: TextStyle(
                      fontSize: 17,
                      color: light_color_type3,
                      fontWeight: FontWeight.normal)),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: context.height * 0.03),
            child:Row(
              children: [
                // Order Detail : 
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OrderTag(title: 'Plan type' , value: 'Basic'), 
                      OrderTag(title: 'Tax' , value: '0.0%'), 
                      OrderTag(title: 'Amount' , value: '₹6000'), 
                      OrderTag(title: 'Total' , value: '₹6000',font_size:22), 
                    ],
                  )),

                  // Pay button : 
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PayIconRow1(), 

                      PayIconRow2(), 
                    ],
                  ))
              ],
            )
          ),

            SubmitFormButton(context)
        ],
      ),
    );
  }

  Container PayIconRow1() {
    return Container(
                      padding: EdgeInsets.all(20),
                      child:Row(
                        children: [
                          Container(
                            child:Expanded(
                              flex:1,
                              child:Image.network('https://www.pngitem.com/pimgs/m/3-38170_phonepe-logo-png-phone-pe-transparent-png.png',
                              height: 50,
                              width: 50,) )),
                          Container(
                            child:Expanded(
                              flex:1,
                              child:Image.network('https://i.pinimg.com/originals/f6/60/a6/f660a637c5ea8ef2b00218bac3479c82.png', 
                              height: 50,
                              width: 50,) ))
                        ],
                      )
                    );
  }

  Container PayIconRow2() {
    return Container(
                      padding: EdgeInsets.all(20),
                      child:Row(
                        children: [
                          Container(
                            child:Expanded(
                              flex:1,
                              child:Image.network('https://livefromalounge.com/wp-content/uploads/2020/01/paytm-logo.jpeg',
                              height: 50,
                              width: 50,) )),
                          Container(
                            child:Expanded(
                              flex:1,
                              child:Image.network('https://www.financialexpress.com/wp-content/uploads/2020/12/amazon-pay.jpg', 
                              height: 50,
                              width: 50,) )),
                          Container(
                            child:Expanded(
                              flex:1,
                              child:Image.network('https://www.vandelaydesign.com/wp-content/uploads/tutorial-preview-image-4.png', 
                              height: 50,
                              width: 50,) ))
                        ],
                      )
                    );
  }

  Container OrderTag({title ,value,font_size}) {
    return Container(
      width:280,
      margin: EdgeInsets.all(5),
      padding:EdgeInsets.all(5),
      child: Row(
          children: [
            Expanded(
              flex: 5,
              child:   Container(
                child: AutoSizeText.rich(
                  TextSpan(
                      text: title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15, 
                        color: light_color_type2)),
                ),
              ),), 
            Expanded(
              flex: 5,
              child: Container(
                child: AutoSizeText.rich(
                  TextSpan(
                      text: value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: font_size!=null ? font_size : 15, 
                        color: dartk_color_type3)),
                ),
                )),
          ],  
        ),
    );
  }

  Container SubmitFormButton(context) {
    return Container(
      width: 220,
      height: 42,
      margin: EdgeInsets.only(top: 40),
      child: a.GradientElevatedButton(
          gradient: g1,
          onPressed: () async {
            // await SendpasswordResetLink(context);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            // side: BorderSide(color: Colors.orange)
          ))),
          child: Text('Pay Now',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ))),
    );
  }

  FormBuilderTextField SecondaryInputField(
      {context,
      name,
      error_text,
      lable_text,
      hind_text,
      require = true,
      initial_val}) {
    return FormBuilderTextField(
      initialValue: initial_val != '' ? initial_val : '',
      textAlign: TextAlign.center,
      name: name,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(),
        color: light_color_type1,
        fontSize: 14,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.minLength(context, 1, errorText: error_text)]),
      decoration: InputDecoration(
        labelText: lable_text,
        labelStyle: GoogleFonts.robotoSlab(
            textStyle: TextStyle(),
            color: input_label_color,
            fontSize: 14,
            fontWeight: FontWeight.w400),

        hintText: hind_text,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade300),

        suffix: InkWell(
          onTap: () {
            ResetForm(name);
          },
          child: Container(
            child: Icon(
              Icons.cancel_outlined,
              color: input_reset_color,
              size: 15,
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
