import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProductTypeRow extends StatefulWidget {
  String? product_type = '';
  SelectProductTypeRow({
    this.product_type, 
    Key? key,
  }) : super(key: key);

  @override
  State<SelectProductTypeRow> createState() => _SelectProductTypeRowState();
}

class _SelectProductTypeRowState extends State<SelectProductTypeRow> {
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
      margin: EdgeInsets.only(bottom: context.height*0.01),
      child: Wrap(
        children: [
          /////////////////////////////
          // SELECT PRODUCT :
          /////////////////////////////
          Container(
            width:30,
            height: 30, 
            child: Card(
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
                            size: 12,
                          ))
                      : const Text(
                          'P',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              color: Colors.white, 
                              fontSize: 12),
                        ),
                ),
              ),
            ),
          ),
          ////////////////////////////
          // SPACING :
          ////////////////////////////
          const SizedBox(
            width: 5,
          ),
          /////////////////////////////
          // SELECT SERVICE :
          /////////////////////////////
          Container(
            width:30,
            height: 30, 
            child: Card(
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
                            size: 12,
                          ))
                      : const Text(
                          'S',
                          style: TextStyle(
                              fontWeight:FontWeight.bold, 
                              color: Colors.white,
                              fontSize: 12 ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
