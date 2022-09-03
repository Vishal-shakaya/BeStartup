import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProductType extends StatefulWidget {
  String? product_type = '';
  SelectProductType({
    this.product_type, 
    Key? key,
  }) : super(key: key);

  @override
  State<SelectProductType> createState() => _SelectProductTypeState();
}

class _SelectProductTypeState extends State<SelectProductType> {
  bool is_product = true;
  bool is_service = false;

  final productStore = Get.put(BusinessProductStore(), tag: 'product_type');

  SetProduct() async {
    setState(() {
      is_product = true;
      is_service = false;
      var res = productStore.SetProductType(ProductType.product);
    });
  }

  SetService() {
    setState(() {
      is_product = false;
      is_service = true;
      var res = productStore.SetProductType(ProductType.service);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
        if (widget.product_type == 'product')  {
       SetProduct();
    }
    if (widget.product_type == 'service')  {
       SetService();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 15, top: 120),
      child: Column(
        children: [
          /////////////////////////////
          // SELECT PRODUCT :
          /////////////////////////////
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                SetProduct();
              },
              radius: 20,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.green.shade300,
                child: is_product
                    ? Container(
                        padding: EdgeInsets.all(2),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ))
                    : const Text(
                        'P',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),
          ),
          ////////////////////////////
          // SPACING :
          ////////////////////////////
          const SizedBox(
            height: 5,
          ),
          /////////////////////////////
          // SELECT SERVICE :
          /////////////////////////////
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                SetService();
              },
              radius: 20,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.blue.shade300,
                child: is_service
                    ? Container(
                        padding: EdgeInsets.all(2),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ))
                    : const Text(
                        'S',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
