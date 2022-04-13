import 'package:be_startup/Backend/Startup/Team/CreateFounderStore.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/FounderImage.dart';
import 'package:be_startup/Components/RegistorTeam/RegistorFounder/RegistorFounderForm.dart';
import 'package:be_startup/Components/RegistorTeam/TeamSlideNav.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistorFounderBody extends StatelessWidget {
  const RegistorFounderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var founderStore = Get.put(BusinessFounderStore(), tag: 'founder');

    final formKey = GlobalKey<FormBuilderState>();

    // SUBMIT  FORM :
    SubmitFounderDetail() async {
      print('SUBMIT FOUNDER DETAIL');

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

        String founder_name = formKey.currentState!.value['founder_name'];
        String founder_position =
            formKey.currentState!.value['founder_position'];
        String phone_no = formKey.currentState!.value['phone_no'];
        String email = formKey.currentState!.value['email'];
        String other_contact = formKey.currentState!.value['other_info'];

        Map<String, dynamic> founder = {
          'id': UniqueKey(),
          'user': '',
          'name': founder_name,
          'position': founder_position,
          'phone_no': phone_no,
          'email': email,
          'other_contact': other_contact
        };
        // Testing
        // print(founder_name);
        // print(founder_position);
        // print(phone_no);
        // print(email);
        // print(other_contact);

        var res = await founderStore.CreateFounder(founder);
        
        if(!res['response']){
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
          duration: Duration(seconds:2),
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
                  FounderImage(),

                  // REGISTRATION FORM :
                  RegistorFounderForm(
                    formKey: formKey,
                  )
                ],

                // BOTTOM NAVIGATION:
              ),
            )),
        TeamSlideNav(
          submitFounderDetail: SubmitFounderDetail,
          slide: TeamSlideType.founder,
        )
      ],
    );
  }
}
