import 'dart:convert';

import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/Backend/Startup/StartupInvestor/StartupInvestorStore.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/Dialog/CreateInvestorDialog.dart';
import 'package:be_startup/Components/StartupView/InvestorSection.dart/InvestorBlock.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestorSection extends StatelessWidget {
  InvestorSection({Key? key}) : super(key: key);

  var startupState = Get.put(StartupDetailViewState());
  var startupInvestorStore = Get.put(StartupInvestorStore());
  var my_context = Get.context;

  var investors = [];
  var is_admin;
  var user_id;

  double mem_desc_block_width = 0.15;
  double mem_desc_block_height = 0.10;
  double mem_dialog_width = 600;

  double heading_fonSize = 32;

  double add_btn_top_margin = 0.06;
  double add_btn_left_margin = 0.02;

  double add_btn_cont_width = 90;
  double add_btn_cont_height = 30;

  double add_btn_radius = 15;

  double add_iconSize = 16;

  double add_iconfonSize = 14;

  double invest_cont_top_marg = 0.06;

  double invest_cont_height = 0.30;

  double invest_cont_width = 0.60;

  // MEMBER DETAIL DIALOG BLOK :
  MemberDetailDialogView({form_type, context}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
            title: Container(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  )),
            ),
            content: SizedBox(
              width: mem_dialog_width,
              child: InvestorDialog(
                form_type: form_type,
              ),
            )));
  }

  ////////////////////////////////////////
  /// Get Requirements :
  ////////////////////////////////////////
  GetLocalStorageData() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final pageParam = jsonDecode(Get.parameters['data']!);

    user_id = pageParam['user_id'];
    is_admin = pageParam['is_admin'];

    final resp =await startupInvestorStore.FetchStartupInvestor(user_id: user_id);

    if (resp['response']) {
      investors = resp['data'];
    }

    if (!resp['response']) {
      Get.showSnackbar(
          MyCustSnackbar(type: MySnackbarType.error, width: snack_width));
    }
  }

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1700) {
      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 32;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.02;

      add_btn_cont_width = 90;
      add_btn_cont_height = 30;

      add_btn_radius = 15;

      add_iconSize = 16;

      add_iconfonSize = 14;

      invest_cont_top_marg = 0.06;

      invest_cont_height = 0.30;

      invest_cont_width = 0.60;
      print('Greator then 1700');
    }

    if (context.width < 1700) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.60;

      invest_cont_height = 0.30;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 32;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.02;

      add_btn_cont_width = 90;
      add_btn_cont_height = 30;

      add_btn_radius = 15;

      add_iconSize = 16;

      add_iconfonSize = 14;

      print('1700');
    }

    if (context.width < 1600) {
      print('1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1200) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.60;

      invest_cont_height = 0.30;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 30;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.02;

      add_btn_cont_width = 80;
      add_btn_cont_height = 25;

      add_btn_radius = 15;

      add_iconSize = 15;

      add_iconfonSize = 13;
      print('1200');
    }

    if (context.width < 1000) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.60;

      invest_cont_height = 0.25;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 30;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.02;

      add_btn_cont_width = 80;
      add_btn_cont_height = 25;

      add_btn_radius = 15;

      add_iconSize = 14;

      add_iconfonSize = 13;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.80;

      invest_cont_height = 0.28;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 28;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.05;

      add_btn_cont_width = 70;
      add_btn_cont_height = 25;

      add_btn_radius = 15;

      add_iconSize = 14;

      add_iconfonSize = 13;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.80;

      invest_cont_height = 0.28;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 25;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.05;

      add_btn_cont_width = 65;
      add_btn_cont_height = 25;

      add_btn_radius = 15;

      add_iconSize = 14;

      add_iconfonSize = 13;

      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      invest_cont_top_marg = 0.06;

      invest_cont_width = 0.80;

      invest_cont_height = 0.22;

      mem_desc_block_width = 0.15;
      mem_desc_block_height = 0.10;
      mem_dialog_width = 600;

      heading_fonSize = 25;

      add_btn_top_margin = 0.06;
      add_btn_left_margin = 0.05;

      add_btn_cont_width = 63;
      add_btn_cont_height = 25;

      add_btn_radius = 15;

      add_iconSize = 14;

      add_iconfonSize = 12;
      print('480');
    }

    ////////////////////////////////////////
    /// Set Requirements:
    ////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(text: 'Loading Investors');
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context);
          }
          return MainMethod(
            context,
          );
        });
  }

  Column MainMethod(BuildContext context) {
    var mainWidget;
    var investorSectionWidget;

    if (investors.length <= 0) {
      mainWidget = Container();
      investorSectionWidget = Container();

      if (is_admin == true) {
        investorSectionWidget = Container(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              StartupHeaderText(
                title: 'Investors',
                font_size: heading_fonSize,
              ),

              //////////////////////////////////////////////////
              /// Show Add button only if user is admin :
              //////////////////////////////////////////////////
              is_admin != true
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(
                        top: context.height * add_btn_top_margin,
                        left: context.width * add_btn_left_margin,
                      ),
                      child: Container(
                        width: add_btn_cont_width,
                        height: add_btn_cont_height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(add_btn_radius),
                            border: Border.all(color: border_color)),
                        child: TextButton.icon(
                            onPressed: () {
                              MemberDetailDialogView(
                                  form_type: InvestorFormType.create,
                                  context: context);
                            },
                            icon: Icon(
                              Icons.add,
                              size: add_iconSize,
                            ),
                            label: Text(
                              'Add',
                              style: TextStyle(
                                  fontSize: add_iconfonSize,
                                  fontWeight: FontWeight.bold),
                            )),
                      ))
            ],
          ),
        );
      }
    } else {
      mainWidget = Container(
        color: Colors.orange.shade300,
        margin: EdgeInsets.only(top: context.height * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: context.height * invest_cont_height,
                width: context.width * invest_cont_width,
                color: Colors.orange.shade300,
                child: Obx(
                  () {
                    return ListView.builder(
                        itemCount: investors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InvestorBlock(
                            is_admin: is_admin,
                            investor: investors[index],
                          );
                        });
                  },
                )),
          ],
        ),
      );

      investorSectionWidget = Container(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            StartupHeaderText(
              title: 'Investors',
              font_size: heading_fonSize,
            ),

            //////////////////////////////////////////////////
            /// show add button on ly if user is admin :
            //////////////////////////////////////////////////
            is_admin != true
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                      top: context.height * add_btn_top_margin,
                      left: context.width * add_btn_left_margin,
                    ),
                    child: Container(
                      width: add_btn_cont_width,
                      height: add_btn_cont_height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(add_btn_radius),
                          border: Border.all(color: border_color)),
                      child: TextButton.icon(
                          onPressed: () {
                            MemberDetailDialogView(
                                form_type: InvestorFormType.create,
                                context: context);
                          },
                          icon: Icon(
                            Icons.add,
                            size: add_iconSize,
                            color: edit_btn_color,
                          ),
                          label: Text(
                            'Add',
                            style: TextStyle(
                                fontSize: add_iconfonSize,
                                color: edit_btn_color,
                                fontWeight: FontWeight.bold),
                          )),
                    ))
          ],
        ),
      );
    }

    return Column(
      children: [
        // INVESTOR HEADING:
        investorSectionWidget,

        ////////////////////////////////
        /// Main Investor widget :
        ////////////////////////////////
        mainWidget
      ],
    );
  }
}
