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

  double mem_desc_block_width = 0.15;
  double mem_desc_block_height = 0.10;
  double mem_dialog_width = 600;

  var investors = [];
  var is_admin;

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
    final startup_id = await startupState.GetStartupId();
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;

    is_admin = await startupState.GetIsUserAdmin();

    final resp =
        await startupInvestorStore.FetchStartupInvestor(startup_id: startup_id);

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
                font_size: 32,
              ),

              //////////////////////////////////////////////////
              /// Show Add button only if user is admin :
              //////////////////////////////////////////////////
              is_admin != true
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(
                        top: context.height * 0.06,
                        left: context.width * 0.02,
                      ),
                      child: Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: border_color)),
                        child: TextButton.icon(
                            onPressed: () {
                              MemberDetailDialogView(
                                  form_type: InvestorFormType.create,
                                  context: context);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 16,
                            ),
                            label: const Text(
                              'Add',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
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
                height: context.height * 0.30,
                width: context.width * 0.60,
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
              font_size: 32,
            ),

            //////////////////////////////////////////////////
            /// show add button on ly if user is admin :
            //////////////////////////////////////////////////
            is_admin != true
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                      top: context.height * 0.06,
                      left: context.width * 0.02,
                    ),
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: border_color)),
                      child: TextButton.icon(
                          onPressed: () {
                            MemberDetailDialogView(
                                form_type: InvestorFormType.create,
                                context: context);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
