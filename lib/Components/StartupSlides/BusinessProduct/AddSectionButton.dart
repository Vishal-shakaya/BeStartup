import 'package:be_startup/Components/StartupSlides/BusinessProduct/ProductImageSection.dart';
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

  ToogleProduct() {
    setState(() {
      selected_tag_prod = !selected_tag_prod;
    });
  }

  ProductDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: ProductDialogHeading(),
            content: SizedBox(
              width: context.width * 0.60,
              height: context.height * 0.50,
              
              // PRODUCT CONTAINER :
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      /////////////////////////////////
                      // Image Section :
                      /////////////////////////////////
                        ProductImageSection()
                    ],
                       
                      // Content Section :
                      // 1. Title : 
                      // 2. Description : 
                      )),
            )));
  }

  Row ProductDialogHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // HEADING SECTION:
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.topCenter,
                child: Text('Add Title', style: Get.textTheme.headline2))),

        // CLOSE DIALOG ICON :
        // POP THE DIALOG BOX:
        TextButton(
          onPressed: () {
            CloseDialog();
          },
          child: Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  CloseDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(flex: 1, child: Container()),
        Container(
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary_light)),
                onPressed: () {
                  ProductDialog();
                },
                icon: Icon(Icons.add),
                label: Text('Add')))
      ],
    );
  }
}
