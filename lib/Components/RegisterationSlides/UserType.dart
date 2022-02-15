import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserOption { founder, investor }

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  Color? unselect_color = light_color_type2;
  Color? select_color = primary_light;
  Color? founder_bottom_heading = light_color_type2;
  Color? investor_bottom_heading = light_color_type2;

  @override
  Widget build(BuildContext context) {
    SelectUserType(option) {
      print('selected');
      setState(() {
        // 1. SELECT FOUNDER LOGIC:
        // 2. UNSELECT INVESTOR :
        if (UserOption.founder == option) {
          founder_bottom_heading = select_color;
          investor_bottom_heading = unselect_color;

          // 1. SELECT INVESTOR LOGIC:
          // 2. UNSELECT FOUNDER
        } else if (UserOption.investor == option) {
          investor_bottom_heading = select_color;
          founder_bottom_heading = unselect_color;
        }
      });
    }

    return Container(
        child: Column(children: [
      ///////////////////////////////
      // Heading Section :
      ///////////////////////////////
      Container(
        height: context.height * 0.2,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RichText(
              text: TextSpan(style: Get.textTheme.headline3, children: [
            TextSpan(text: user_type_heading, style: TextStyle(fontSize: 35))
          ]))
        ]),
      ),

      ////////////////////////////////
      /// BODY SECTION :
      ////////////////////////////////
      Container(
          height: context.height * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //////////////////////////////////
              // FOUNDER SECTION :
              //////////////////////////////////
              Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  onTap: () {
                    SelectUserType(UserOption.founder);
                  },
                  hoverColor: Colors.blueGrey.shade50,
                  child: Card(
                    elevation: 10,
                    shadowColor: primary_light,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2,
                            )),
                        child: Column(
                          children: [
                            // IMAGE SECTION :
                            Container(
                                child: Image.asset(
                              reg_founder_image,
                              width: 300,
                              height: 450,
                              fit: BoxFit.contain,
                            )),

                            // BOTTOM TEXT :
                            Container(
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline3,
                                        children: [
                                  TextSpan(
                                      text: 'Founder',
                                      style: TextStyle(
                                          color: founder_bottom_heading))
                                ])))
                          ],
                        )),
                  ),
                ),
              ),

              //////////////////////////////
              // INVESTOR SECTION :
              //////////////////////////////
              Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  onTap: () {
                    SelectUserType(UserOption.investor);
                  },
                  hoverColor: Colors.blueGrey.shade50,
                  child: Card(
                    elevation: 10,
                    shadowColor: primary_light,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2,
                            )),
                        child: Column(
                          children: [
                            // IMAGE SECTION :
                            Container(
                                child: Image.asset(
                              reg_investor_image,
                              width: 300,
                              height: 450,
                              fit: BoxFit.contain,
                            )),

                            // BOTTOM TEXT :
                            Container(
                                child: RichText(
                                    text: TextSpan(
                                        style: Get.textTheme.headline3,
                                        children: [
                                  TextSpan(
                                      text: 'Investor',
                                      style: TextStyle(
                                          color: investor_bottom_heading))
                                ])))
                          ],
                        )),
                  ),
                ),
              )
            ],
          )),

      // CONTINUE  BUTTON :
      Container(
        margin: EdgeInsets.only(top: 30),
        child: InkWell(
          highlightColor:primary_light_hover,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20)),
          onTap: () {
            print('df');
          },
          child: Card(
            elevation: 5,
            shadowColor: primary_light_hover,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              width: 130,
              height: 45,
              decoration: BoxDecoration(
                  color: primary_light,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20))),
              child: Text(
                'continue',
                style: TextStyle(
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
    ]));
  }
}
