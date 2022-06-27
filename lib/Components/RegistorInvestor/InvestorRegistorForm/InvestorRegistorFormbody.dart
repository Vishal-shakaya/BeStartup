import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorDetailStore.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/InvestorImage.dart';
import 'package:be_startup/Components/RegistorInvestor/InvestorRegistorForm/RegistorInvForm.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InvestorRegistorFormBody extends StatefulWidget {
  InvestorRegistorFormBody({Key? key}) : super(key: key);

  @override
  State<InvestorRegistorFormBody> createState() =>
      _InvestorRegistorFormBodyState();
}

class _InvestorRegistorFormBodyState extends State<InvestorRegistorFormBody> {
  var investorStore = Get.put(InvestorDetailStore(), tag: 'investor');

  var investorConnector =
      Get.put(InvestorConnector(), tag: 'investor_connector');

  final formKey = GlobalKey<FormBuilderState>();

  var my_context = Get.context;

  double done_btn_width = 150;

  double done_btn_height = 40;

  double con_button_width = 150;

  double con_button_height = 40;

  double con_btn_top_margin = 30;

  var pageParam;

  bool? updateMode = false;


  //////////////////////////////////////////////
  // CREATE INVESTOR FORM :
  //////////////////////////////////////////////
  SubmitInvestorDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    formKey.currentState!.save();
    MyCustPageLoadingSpinner();

    if (formKey.currentState!.validate()) {
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
      var res = await investorStore.CreateInvestor(founder);

      // Success Handler :
      if (res['response']) {
        formKey.currentState!.reset();
        CloseCustomPageLoadingSpinner();
        Get.toNamed(select_investor_choise, preventDuplicates: false);
      }

      // Error Handler :
      if (!res['response']) {
        Get.closeAllSnackbars();
        CloseCustomPageLoadingSpinner();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: res['message'],
            message: create_error_msg));
      }
    }

    // Form Validatiaon Error :
    else {
      Get.closeAllSnackbars();
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

  //////////////////////////////////
  // UPDATE INVESTOR FORM :
  //////////////////////////////////
  UpdateInvestorDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    formKey.currentState!.save();
    MyCustPageLoadingSpinner();

    if (formKey.currentState!.validate()) {
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
      var res = await investorStore.CreateInvestor(founder);
      var update_resp = await investorConnector.UpdateInvestorDetail();

      // Success Handler :
      if (res['response']) {
        // Update Success Hndler :
        if (update_resp['response']) {
          formKey.currentState!.reset();
          CloseCustomPageLoadingSpinner();
          Get.toNamed(startup_view_url);
        }

        // Update Error handler :
        if (!update_resp['response']) {
          Get.closeAllSnackbars();
          CloseCustomPageLoadingSpinner();
          Get.showSnackbar(MyCustSnackbar(
              width: snack_width,
              type: MySnackbarType.error,
              title: update_resp['message'],
              message: update_error_msg));
        }
      }

      // Error Handler :
      if (!res['response']) {
        Get.closeAllSnackbars();
        CloseCustomPageLoadingSpinner();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            title: res['message'],
            message: create_error_msg));
      }
    }

    // Form Validatiaon Error :
    else {
      Get.closeAllSnackbars();
      CloseCustomPageLoadingSpinner();
      Get.showSnackbar(
          MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
    }
  }

/////////////////////////////////////
  /// SET PAGE DEFAULT STATE :
/////////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    pageParam = Get.parameters;
    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        updateMode==true?
         DoneButton(done_btn_width, done_btn_height, SubmitInvestorDetail)
        :DoneButton(done_btn_width, done_btn_height, UpdateInvestorDetail())
      ],
    );
  }

//////////////////////////////////
  /// EXTERNAL METHODS;
//////////////////////////////////

  Container DoneButton(double done_btn_width, double done_btn_height,
      Function SubmitDetail) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          SubmitDetail();
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
