import 'package:be_startup/Backend/Investor/InvestorDetailStore.dart';
import 'package:be_startup/Backend/Startup/Team/CreateFounderStore.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/InvestorImage.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/RegistorInvForm.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InvestorRegistorFormBody extends StatelessWidget {
  const InvestorRegistorFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var investorStore = Get.put(InvestorDetailStore(), tag: 'investor');

    final formKey = GlobalKey<FormBuilderState>();
    double done_btn_width = 150;
    double done_btn_height = 40;

    // SUBMIT  FORM :
    SubmitInvestorDetail() async {
      formKey.currentState!.save();

      if (formKey.currentState!.validate()) {
        // START SPINNER :
        SmartDialog.showLoading(
            background: Colors.white,
            maskColorTemp: Color.fromARGB(146, 252, 250, 250),
            widget: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.orangeAccent,
            ));

        String investor_name = formKey.currentState!.value['investor_name'];
        String investor_position =
            formKey.currentState!.value['investor_position'];
        String phone_no = formKey.currentState!.value['phone_no'];
        String email = formKey.currentState!.value['email'];
        String other_contact = formKey.currentState!.value['other_info'];

        Map<String, dynamic> founder = {
          'id': UniqueKey(),
          'user': '',
          'name': investor_name,
          'position': investor_name,
          'phone_no': phone_no,
          'email': email,
          'other_contact': other_contact
        };
        // Testing
        // print(investor_name);
        // print(investor_position);
        // print(phone_no);
        // print(email);
        // print(other_contact);

        var res = await investorStore.CreateInvestor(founder);

        if (!res['response']) {
          // CLOSE SNAKBAR :
          Get.closeAllSnackbars();
          // Error Alert :
          Get.snackbar(
            '',
            '',
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red.shade50,
            titleText: MySnackbarTitle(title: 'Error  accure'),
            messageText: MySnackbarContent(message: 'Something went wrong'),
            maxWidth: context.width * 0.50,
          );
        }
        formKey.currentState!.reset();
        SmartDialog.dismiss();

        // Redirect to team page:
        Get.toNamed(create_business_team);
      } else {
        // CLOSE SNAKBAR :
        Get.closeAllSnackbars();
        // Error Alert :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Form Validation Error'),
          messageText: MySnackbarContent(message: 'Check required field'),
          maxWidth: context.width * 0.50,
        );
      }
    }

    return Column(
      children: [
        Container(
            height: context.height * 0.7,
            /////////////////////////////////////////
            ///  BUSINESS SLIDE :
            ///  1. BUSINESS ICON :
            ///  2. INPUT FIELD TAKE BUSINESS NAME :
            /////////////////////////////////////////
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  // UPLOAD FOUNDER IMAGE :
                  InvestorImage(),

                  // REGISTRATION FORM :
                  RegistorInvForm(
                    formKey: formKey,
                  )
                ],

                // BOTTOM NAVIGATION:
              ),
            )),
        DoneButton(done_btn_width, done_btn_height,SubmitInvestorDetail)
      ],
    );
  }

  Container DoneButton(double done_btn_width, double done_btn_height,Function SubmitInvestorDetail) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          SubmitInvestorDetail();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: done_btn_width,
            height: done_btn_height,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Done',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
