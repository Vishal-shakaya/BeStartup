import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorCatigoryStorage.dart';
import 'package:be_startup/Backend/Users/Investor/InvestorConnector.dart';
import 'package:be_startup/Backend/Users/UserStore.dart';
import 'package:be_startup/Components/RegistorInvestor/ChooseCatigory/ChooseChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessCatigory/CustomInputChip.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:be_startup/Utils/Messages.dart';
// import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ChooseCatigoryBody extends StatefulWidget {
  ChooseCatigoryBody({Key? key}) : super(key: key);

  @override
  State<ChooseCatigoryBody> createState() => _ChooseCatigoryBodyState();
}

class _ChooseCatigoryBodyState extends State<ChooseCatigoryBody> {
  double vision_cont_width = 0.60;
  double vision_cont_height = 0.50;
  double vision_subheading_text = 20;
  double continue_btn_width = 150;
  double continue_btn_height = 50;

  var catigoryStore = Get.put(InvestorCatigoryStore(), tag: 'catigories');
  var investorConct = Get.put(InvestorConnector(), tag: 'investor_connector');
  var userStore = Get.put(UserStore());

  @override
  Widget build(BuildContext context) {
    // SHOW LOADING SPINNER :
    StartLoading() {
      var dialog = SmartDialog.showLoading(
          background: Colors.white,
          maskColorTemp: Color.fromARGB(146, 252, 250, 250),
          widget: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ));
      return dialog;
    }

    // End Loading
    EndLoading() async {
      SmartDialog.dismiss();
    }

    // SUBMIT CATIGORY :
    SubmitCatigory() async {
      StartLoading();
      var resp = await catigoryStore.PersistCatigory();
      if (resp['response'] == false) {
        EndLoading();

        var snack_width = MediaQuery.of(context).size.width * 0.50;
        Get.showSnackbar(
            MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
        return;
      } else {
        var resp = await investorConct.CreateInvestorCatigory();
        print(resp);

        var resp1 = await investorConct.CreateInvestorContact();
        print(resp);

        var resp2 = await investorConct.CreateInvestorDetail();
        print(resp);

        final resp4 = await userStore.UpdateUserDatabaseField(
            field: 'is_investor', val: true);

        final user_id = await getUserId;
        final user_resp = await investorConct.FetchInvestorDetailandContact(
            user_id: user_id);

        print('Registor Investor detial $user_resp');
        if (user_resp['response']) {
          final phoneno = user_resp['data']['userContect']['phone_no'];
          final profile_image = user_resp['data']['userDetail']['picture'];
          final username = user_resp['data']['userDetail']['name'];

          await SetLoginUserPhoneno(phoneno);
          await SetLoginUserProfileImage(profile_image);
          await SetLoginUserName(username);
        }

        // Success Response Handler :
        if (resp['response']) {
          await ClearStartupSlideCached();
          await SetUserType('investor');
          EndLoading();
          Get.toNamed(home_page_url);
        }

        // Error Response Handler :
        if (!resp['response']) {
          var snack_width = MediaQuery.of(context).size.width * 0.50;
          EndLoading();
          Get.showSnackbar(
              MyCustSnackbar(width: snack_width, type: MySnackbarType.error));
        }

        EndLoading();
      }
    }

    // DEFAULT :
    if (context.width > 1500) {
      vision_cont_height = 0.50;
      vision_cont_width = 0.60;
      vision_subheading_text = 20;
    }
    if (context.width < 1500) {
      vision_cont_height = 0.50;
      vision_cont_width = 0.75;
      vision_subheading_text = 20;
    }

    // PC:
    if (context.width < 1200) {
      vision_cont_width = 0.80;
      vision_subheading_text = 20;
    }

    if (context.width < 1000) {
      vision_cont_width = 0.85;
      vision_subheading_text = 20;
    }

    // TABLET :
    if (context.width < 800) {
      vision_cont_width = 0.80;
      vision_subheading_text = 20;
    }
    // SMALL TABLET:
    if (context.width < 640) {
      vision_cont_width = 0.70;
      vision_subheading_text = 18;
    }

    // PHONE:
    if (context.width < 480) {
      vision_cont_width = 0.99;
      vision_subheading_text = 16;
    }

    // CAREAT CATIGORY CHIPS:
    List<ChooseChip> catigory_list = [];
    business_catigories.forEach((cat) {
      catigory_list.add(ChooseChip(
        key: UniqueKey(),
        catigory: cat,
      ));
    });

    return Column(
      children: [
        Container(
            width: context.width * vision_cont_width,
            height: context.height * vision_cont_height,
            alignment: Alignment.center,
            child: Column(
              children: [
                // SUBHEADING TEXT :
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.08),
                  child: AutoSizeText.rich(
                      TextSpan(style: context.textTheme.headline2, children: [
                    TextSpan(
                        text: investor_choise_sub_text,
                        style: TextStyle(
                            color: light_color_type3,
                            fontSize: vision_subheading_text))
                  ])),
                ),

                //////////////////////////////////////////
                // CATIGORY SELECT SECTION :
                // DISPLAY DEFAULT CATIGORIES CHIPS :
                //////////////////////////////////////////
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.05),
                  child: Wrap(
                    spacing: 2,
                    alignment: WrapAlignment.center,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    children: catigory_list,
                  ),
                ),
              ],
            )),
        ContinueButton(SubmitCatigory)
      ],
    );
  }

  Container ContinueButton(Function submitCatigory) {
    return Container(
      // margin:
      //     EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await submitCatigory();
        },
        child: Card(
          elevation: 10,
          shadowColor: light_color_type3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: 150,
            height: 40,
            decoration: BoxDecoration(
                color: primary_light,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: const Text(
              'Finish',
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
