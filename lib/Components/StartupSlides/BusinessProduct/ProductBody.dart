import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductList.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  var productStore = Get.put(BusinessProductStore(), tag: 'productList');
  var startupConnector =
      Get.put(StartupViewConnector(), tag: 'startup_connector');

  double prod_cont_width = 0.80;
  double prod_cont_height = 0.70;
  double prod_sec_width = 0.65;

  // Update params;
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;
  var pageParam;
  bool? updateMode = false;
  var my_context = Get.context;

  /////////////////////////////////////////
  /// SUBMIT PRODUCT :
  /////////////////////////////////////////
  SubmitProduct() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    MyCustPageLoadingSpinner();
    var resp = await productStore.PersistProduct();
    // Error Handerl :
    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          message: fetch_data_error_msg,
          title: fetch_data_error_title));
    }
    CloseCustomPageLoadingSpinner();
  }

  /////////////////////////////////////////
  /// UPDATE PRODUCT :
  /////////////////////////////////////////
  UpdateProduct() async {
    var snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    MyCustPageLoadingSpinner();
    var resp = await productStore.PersistProduct();
    // Cached Data Success Handler:
    if (resp['response']) {
      var update_resp = await updateStore.UpdateProducts();

      // Update Success Handler :
      if (update_resp['response']) {
        MyCustPageLoadingSpinner();
        Get.toNamed(startup_view_url);
      }

      if (!update_resp['response']) {
        CloseCustomPageLoadingSpinner();
        Get.closeAllSnackbars();
        Get.showSnackbar(MyCustSnackbar(
            width: snack_width,
            message: fetch_data_error_msg,
            title: fetch_data_error_title));
      }
    }

    // Error Handerl :
    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          message: fetch_data_error_msg,
          title: fetch_data_error_title));
    }
    CloseCustomPageLoadingSpinner();
  }

///////////////////////////////
// Set page Default State :
///////////////////////////////
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
  ///////////////////////////////////////////////////
  /// GET REQUIREMENTS DATA :
  /// It fetches data from the server and stores. it in the local storage.
  ///  If the server is down, it
  /// returns the data from the local storage
  /// Returns:
  ///   The return value is a Future&lt;dynamic&gt;.
  ///////////////////////////////////////////////////
    GetLocalStorageData() async {
      var error_resp;
      try {
        final resp = await startupConnector.FetchProducts();
        print(resp['message']);

        final data = await productStore.GetProductList();
        error_resp = data;
        return data;
      } catch (e) {
        return error_resp;
      }
    }

    ///////////////////////////////////
    /// SET REQUIREMNTS :
    ///////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer(
              text: 'Loading Products',
            );
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(context, snapshot.data);
          }
          return MainMethod(context, snapshot.data);
        });
  }



//////////////////////////////
// MAIN METHOD SECTION:
//////////////////////////////
  Column MainMethod(
    BuildContext context,
    product,
  ) {
    return Column(
      children: [
        Container(
          width: context.width * prod_cont_width,
          height: context.height * prod_cont_height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ADD SECTION BUTTON :
                AddSectionButton(
                  key: UniqueKey(),
                ),

                ////////////////////////////////////
                // PRODUCT SECTION;
                // DARK THEME COLOR ___ :
                // RESPONSIVE NESS _____:
                ////////////////////////////////////

                // PRODUCT LIST VIEW :
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: context.width * prod_sec_width,
                          height: context.height * 0.60,
                          child: Obx(() {
                            return ListView.builder(
                                itemCount: product.length,
                                key: UniqueKey(),
                                itemBuilder: (context, index) {
                                  return ProductListView(
                                    key: UniqueKey(),
                                    product: product[index],
                                    index: index,
                                  );
                                });
                          })),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        updateMode == true
            ? UpdateButton(context)
            : BusinessSlideNav(
                slide: SlideType.product,
                submitform: SubmitProduct,
              )
      ],
    );
  }

  Container UpdateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: con_btn_top_margin, bottom: 20),
      child: InkWell(
        highlightColor: primary_light_hover,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
        onTap: () async {
          await SubmitProduct();
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
