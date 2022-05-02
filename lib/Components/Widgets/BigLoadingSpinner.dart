import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BigLoadingSpinner extends StatefulWidget {
  BigLoadingSpinner({Key? key}) : super(key: key);

  @override
  State<BigLoadingSpinner> createState() => _BigLoadingSpinnerState();
}

class _BigLoadingSpinnerState extends State<BigLoadingSpinner> {
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.center,
            width: context.width*0.80,
            height: context.height*0.30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              margin: EdgeInsets.only(bottom: context.height*0.03),
              child: AutoSizeText.rich(
                TextSpan(
                  text: 'creating your startup.. ' ,
                  style:TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 18,
                  )
                ),
                style: Get.textTheme.headline4 , 
                ),
              
            ), 
              Container(
                    width: context.width*0.08,
                    height: context.height*0.16,
                child: CircularProgressIndicator(
                  strokeWidth: 25,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        );
  }
}