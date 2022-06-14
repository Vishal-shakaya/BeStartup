import 'package:be_startup/Backend/Startup/Connector/UpdateStartupDetail.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/AddSectionButton.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductList.dart';
import 'package:be_startup/Components/StartupSlides/BusinessSlideNav.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:be_startup/Utils/Colors.dart';
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
  double prod_cont_width = 0.80;
  double prod_cont_height = 0.70;
  double prod_sec_width = 0.65;
  double con_button_width = 150;
  double con_button_height = 40;
  double con_btn_top_margin = 30;

  var pageParam;
  bool? updateMode = false;

  var updateStore = Get.put(StartupUpdater(), tag: 'update_startup');
  var productStore = Get.put(BusinessProductStore(), tag: 'productList');

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

    ErrorSnakbar() {
      Get.snackbar(
        '',
        '',
        margin: EdgeInsets.only(top: 10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: 'Error'),
        messageText: MySnackbarContent(message: 'Something went wrong'),
        maxWidth: context.width * 0.50,
      );
    }

    SubmitProduct() async {
      StartLoading();
      var resp = await productStore.PersistProduct();
      await updateStore.UpdateProducts();
      if (!resp['response']) {
        EndLoading();
        ErrorSnakbar();
      }
      EndLoading();
      updateMode == true ? Get.toNamed(startup_view_url) : EndLoading();
    }

    // INITILIZE DEFAULT STATE :
    // GET IMAGE IF HAS IS LOCAL STORAGE :
    GetLocalStorageData() async {
      try {
        final data = await productStore.GetProductList();
        return data;
      } catch (e) {
        return '';
      }
    }

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
            return MainMethod(context, snapshot.data, SubmitProduct);
          }
          return MainMethod(context, snapshot.data, SubmitProduct);
        });
    // return MainMethod(context, product, SubmitProduct);
  }

//////////////////////////////
// MAIN METHOD SECTION:
//////////////////////////////
  Column MainMethod(
      BuildContext context, product, Future<Null> SubmitProduct()) {
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
            ? UpdateButton(context, SubmitProduct)
            : BusinessSlideNav(
                slide: SlideType.product,
                submitform: SubmitProduct,
              )
      ],
    );
  }

  Container UpdateButton(BuildContext context, SubmitProduct) {
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
