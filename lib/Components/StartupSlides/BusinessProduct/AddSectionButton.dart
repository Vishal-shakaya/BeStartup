import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductForm.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductImageSection.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/SelectProductType.dart';
import 'package:be_startup/Components/StartupSlides/BusinessProduct/SelectProductTypeRow.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSectionButton extends StatefulWidget {
  AddSectionButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSectionButton> createState() => _AddSectionButtonState();
}

class _AddSectionButtonState extends State<AddSectionButton> {
  bool selected_tag_prod = false;
  double image_cont_width = 0.18;
  double image_cont_height = 0.22;

  double desc_cont_width = 0.40;
  double desc_cont_height = 0.22;

  double prod_desc_fontSize = 14;
  double prod_title_fontSize = 20;

  double prod_dialog_width = 0.60;
  double prod_dialog_height = 0.50;

  ToogleProduct() {
    setState(() {
      selected_tag_prod = !selected_tag_prod;
    });
  }

  Widget horizontalDialogView = Container(
      padding: EdgeInsets.all(20),
      child: Wrap(
        children: [
          /////////////////////////////////
          // Image Section :
          /////////////////////////////////
          ProductImageSection(),
          //////////////////////////////
          // Content Section :
          // 1. Title :
          // 2. Description :
          //////////////////////////////
          ProductForm(),

          SelectProductType()
        ],
      ));

  Widget verticalDialogView = Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section :
            ProductImageSection(),

            // Product form which take title and content :
            // Select Product Type serice or just product :
            Wrap(
              children: [ProductForm(), SelectProductType()],
            ),
          ],
        ),
      ));


  Widget phoneViewAddProduct = Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SelectProductTypeRow(),

            // Image Section :
            ProductImageSection(),

            // Product form which take title and content :
            // Select Product Type serice or just product :
            ProductForm(),
          ],
        ),
      ));

  ProductDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
            title: ProductDialogHeading(),
            content: SizedBox(
              width: context.width * prod_dialog_width,
              height: context.height * prod_dialog_height,

              // PRODUCT CONTAINER :
              child: horizontalDialogView,
            )));
  }

  CloseDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    prod_dialog_width = 0.60;
    prod_dialog_height = 0.50;

    //Add Product button normal view :
    Widget addButton = ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primary_light)),
        onPressed: () {
          ProductDialog();
        },
        icon: Icon(Icons.add),
        label: const Text(
          'Add',
        ));

    // Icon button to add use 1000 px view :
    Widget addIconButton = Container(
      width: 40,
      height: 40,
      child: Card(
        color: primary_light2,
        elevation: 3,
        shadowColor: primary_light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: IconButton(
            onPressed: () {
              ProductDialog();
            },
            icon: const Icon(
              Icons.add,
              size: 17,
            )),
      ),
    );

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    if (context.width > 1500) {
      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1450) {
      addButton = addIconButton;
      prod_dialog_width = 0.75;
      prod_dialog_height = 0.50;
      print('1450');
    }

    if (context.width < 1200) {
      addButton = addIconButton;
      print('1200');
    }

    if (context.width < 1300) {
      print('1300');
    }

    if (context.width < 1000) {
      horizontalDialogView = verticalDialogView;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      prod_dialog_width = 0.90;
      prod_dialog_height = 0.50;
      horizontalDialogView = phoneViewAddProduct; 
      print('480');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(flex: 1, child: Container()),
        Container(
          child: addButton,
        )
      ],
    );
  }



  Container ProductDialogHeading() {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          CloseDialog();
          },
        child:  const Icon(
          Icons.close,
          color: Colors.grey,
          size: 22,
        ),
      ),
    );
  }
}
