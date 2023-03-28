import 'dart:convert';

import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/Connector/FetchStartupData.dart';
import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductList.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';

import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  var updateStore = Get.put(StartupUpdater());
  var productStore = Get.put(BusinessProductStore());

  var startupConnector = Get.put(StartupViewConnector());
  var my_context = Get.context;

  double prod_cont_width = 0.80;
  double prod_cont_height = 0.70;
  double prod_sec_width = 0.65;

  // Update params;
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  var pageArguments;

  String? startup_id;
  String? user_id;
  bool? is_admin;
  bool? updateMode = false;

////////////////////////////////////////////////////////////
  /// SUBMIT PRODUCT :
  /// The function is called when the user clicks on a button.
  /// The function calls a method in a store that
  /// persists the data to firestore. The function then navigates
  /// the user to the next page
////////////////////////////////////////////////////////////
  SubmitProduct() async {
    MyCustPageLoadingSpinner();
    final snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final authUser = FirebaseAuth.instance.currentUser;
    final resp = await productStore.PersistProduct(user_id: authUser?.uid);

    if (resp['response']) {
      Get.toNamed(create_business_whyInvest_url);
    }

    if (!resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();

      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.error,
          message: create_error_msg,
          title: create_error_title));
    }
    CloseCustomPageLoadingSpinner();
  }

//////////////////////////////////////////////////////////
  /// UPDATE PRODUCT :
  /// It's a function that updates a product in a store
//////////////////////////////////////////////////////////
  UpdateProduct() async {
    MyCustPageLoadingSpinner();
    final productStore = Get.put(BusinessProductStore());
    final snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    final updateProducts = await productStore.GetProducts();

    final update_resp = await updateStore.UpdateProducts(
        user_id: user_id, products: updateProducts);

    final productDeletePath = productStore.GetDeleteProductPath();

    // Success Handler  :
    if (update_resp['response']) {
      try {
        for (var i = 0; i < productDeletePath.length; i++) {
          final deleteResp = await DeleteFileFromStorage(productDeletePath[i]);
          print('delete Resp $deleteResp');
        }
      } catch (e) {
        print('Error While Delete File from firebase : $e');
      }



      final param = jsonEncode({
        'user_id': user_id,
        'is_admin': is_admin,
      });

      MyCustPageLoadingSpinner();
      Get.toNamed(startup_view_url, parameters: {'data': param});
    }

    // Error handler :
    if (!update_resp['response']) {
      CloseCustomPageLoadingSpinner();
      Get.closeAllSnackbars();
      Get.showSnackbar(MyCustSnackbar(
          width: snack_width,
          type: MySnackbarType.error,
          message: fetch_data_error_msg,
          title: fetch_data_error_title));
    }

    CloseCustomPageLoadingSpinner();
  }

  /////////////////////////////////////////////////////////////////////////
  /// GET REQUIREMENTS DATA :
  /// It fetches data from the server and stores. it in the local storage.
  ///  If the server is down, it
  /// returns the data from the local storage
  /// Returns:
  ///   The return value is a Future&lt;dynamic&gt;.
  /////////////////////////////////////////////////////////////////////////
  GetLocalStorageData() async {
    final snack_width = MediaQuery.of(my_context!).size.width * 0.50;
    var error_resp;
    var data;
    try {
      // Check if update Mode :
      if (Get.parameters.isNotEmpty) {
        pageParam = jsonDecode(Get.parameters['data']!);
        user_id = pageParam['user_id'];
        is_admin = pageParam['is_admin'];

        if (pageParam['type'] == 'update') {
          updateMode = true;
          final resp =
              await startupConnector.FetchProductsAndServices(user_id: user_id);

          // Success Handler :
          if (resp['response']) {
            data = await productStore.SetProductList(list: resp['data']);
          }

          // Error Handler :
          if (!resp['response']) {
            CloseCustomPageLoadingSpinner();
            Get.closeAllSnackbars();
            Get.showSnackbar(MyCustSnackbar(
                width: snack_width,
                message: fetch_data_error_msg,
                title: fetch_data_error_title));
          }
        }
      } else {
        data = await productStore.GetProductList();
      }

      error_resp = data;
      return data;
    } catch (e) {
      return error_resp;
    }
  }

  @override
  Widget build(BuildContext context) {
    // DEFAULT :
    if (context.width > 1500) {
      prod_cont_width = 0.80;
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      prod_cont_width = 0.80;
      print('1500');
    }

    if (context.width < 1450) {
      print('1450');
      prod_sec_width = 0.70;
    }

    if (context.width < 1400) {
      prod_sec_width = 0.75;
      print(' 1400');
    }

    if (context.width < 1300) {
      prod_sec_width = 0.75;
      print(' 1400');
    }

    if (context.width < 1200) {
      prod_sec_width = 0.85;
      print('1200');
    }

    if (context.width < 1000) {
      prod_sec_width = 1;
      print('main 1000');
    }

    // TABLET :
    if (context.width < 800) {
      prod_sec_width = 0.99;
      print('main 800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      prod_sec_width = 1;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      prod_sec_width = 1;
      print('480');
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
                          alignment: Alignment.center,
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
          await UpdateProduct();
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
