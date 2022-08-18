import 'dart:convert';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessDetailSlide/BusinessForm.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Components/StartupSlides/BusinessDetailSlide/BusinessIcon.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shimmer/shimmer.dart';

class BusinessBody extends StatefulWidget {
  const BusinessBody({Key? key}) : super(key: key);

  @override
  State<BusinessBody> createState() => _BusinessBodyState();
}

class _BusinessBodyState extends State<BusinessBody> {
  final detailStore = Get.put(BusinessDetailStore(), tag: 'business_store');
  final updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  final startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');

  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  var my_context = Get.context;
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  // update params :
  var pageParam;
  bool? updateMode;
  var founder_id;
  var startup_id;
  var is_admin;

///////////////////////////////////////////////////
/// HANDLE SUBMIT FORM :
/// 1. IF SUCCESS THEN REDIRECT TO ANOTHER SLIDE :
/// 2. ELSE SHOW ERRO ALERT :
///////////////////////////////////////////////////
  SubmitBusinessDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    MyCustPageLoadingSpinner();

    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      String business_name = formKey.currentState!.value['startup_name'];
      var desire_amount = formKey.currentState!.value['desire_amount'];
      business_name = business_name.trim();
      desire_amount = desire_amount.trim();

      // HANDLING RESPONSE :
      var res = await detailStore.SetBusinessDetail(
          businessName: business_name, amount: desire_amount);

      // RESPONSE HANDLING :
      // 1. SUCCESS RESPONSE THEN REDIRECT TO NEXT SLIDE :
      // 2. IF FORM IS NOT VALID OR NULL SHOW ERROR :
      if (res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.toNamed(create_business_thumbnail_url);
      }

      if (!res['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.error,
          message: res['message'],
        ));
      }
    } else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
        type: MySnackbarType.error,
      ));
    }
  }



///////////////////////////////////////////////////
/// UPDATE FORM HANDLER :
/// It's a function that updates the business detail of a user
///////////////////////////////////////////////////
  UpdateBusinessDetail() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    MyCustPageLoadingSpinner();

    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      
      String business_name = formKey.currentState!.value['startup_name'];
      var desire_amount = formKey.currentState!.value['desire_amount'];
      
      business_name = business_name.trim();
      desire_amount = desire_amount.trim();

        var update_resp =
            await updateStore.UpdateBusinessDetail(startup_id: startup_id);

        // Update Success Handler :
        if (update_resp['response']) {
            var param = jsonEncode({
              'founder_id': founder_id,
              'startup_id': startup_id,
              'is_admin': is_admin,
            });
            CloseCustomPageLoadingSpinner();
            Get.closeAllSnackbars();
            Get.toNamed(startup_view_url, parameters: {'data':param});
        }

        // Update Error Handler :
        if (!update_resp['response']) {
          CloseCustomPageLoadingSpinner();
          Get.closeAllSnackbars();

          Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            type: MySnackbarType.error,
            message: update_error_msg,
            title: update_error_title,
          ));
        }
      }
    
    
    
    // Invalid form :
    else {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
        width: snack_width,
        type: MySnackbarType.error,
      ));
    }
  }

/////////////////////////////////
  /// SET PAGE DEFAULT STATE :
/////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    pageParam = jsonDecode(Get.parameters['data']!);
    founder_id = pageParam['founder_id'];
    startup_id = pageParam['startup_id'];
    is_admin = pageParam['is_admin'];

    if (pageParam['type'] == 'update') {
      updateMode = true;
    }
    super.initState();
  }

/////////////////////////////////
  /// GET REQUIREMENTS :
/////////////////////////////////
  GetRequirements() async {
    try {
      if (updateMode == true) {
        final resp = await startupConnector.FetchBusinessDetail(startup_id: startup_id);
        
        final amount = resp['data']['desire_amount'];
        final logo = resp['data']['logo'];
        final name = resp['data']['name'];

        await detailStore.SetBusinessAmountParam(data: amount);
        await detailStore.SetBusinessLogoParam(data: logo);
        await detailStore.SetBusinessNameParam(data: name );
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetRequirements(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: Text(
                'Loading Business Details',
                style: Get.textTheme.headline2,
              ),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(context);
        });
  }

  Container MainMethod(BuildContext context) {
    return Container(
        height: context.height * 0.80,
        /////////////////////////////////////////
        ///  BUSINESS SLIDE :
        ///  1. BUSINESS ICON :
        ///  2. INPUT FIELD TAKE BUSINESS NAME :
        /////////////////////////////////////////
        child: SingleChildScrollView(
          child: Column(
            children: [
              BusinessIcon(),
              BusinessForm(
                formKey: formKey,
              ),
              updateMode == true
                  ? UpdateButton(context)
                  : BusinessSlideNav(
                      key: UniqueKey(),
                      submitform: SubmitBusinessDetail,
                      slide: SlideType.detail,
                    )
            ],
          ),
        ));
  }



//////////////////////////////////////
/// Updaload Button : 
//////////////////////////////////////
  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
       
        onTap: () async {
          await UpdateBusinessDetail();
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
              'Update',
              style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
