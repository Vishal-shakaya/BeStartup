import 'package:be_startup/Components/WebLoginView/LoginPage/SideImage.dart';
import 'package:be_startup/Components/WebLoginView/SocialAuth/SocailAuth.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/LoginTabs.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/CustomDivider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen_width = context.width;

    return Row(children: [
    
      // Login Form
      Expanded(
        flex: 1,
        child: Column(children: [
          // Image Container :

          // LOGIN FORM ROW  :
          Container(
              margin: EdgeInsets.only(top: context.height*0.04),
              child: Row(
                children: [
                  // SPACING
                  // Expanded(flex: 1, child: Text('')),

                  // TABS LOGIN | SIGNUP
                  Expanded(
                      flex: screen_width < 800 ? 4 : 2, child: LoginTabs()),

                  // Divider
                  // Responseive adder 800 width  :
                  // add emptly container and remove divider:
                  // screen_width < 800
                  //     ? Container(
                  //         width: 20,
                  //         margin: EdgeInsets.only(right: 20),
                  //         child: Text(''))
                  //     : CustomDivider(),

                  // SOCIAL LOGIN BUTTONS :
                  // Responsive Adder :
                  // 1. Remove Large button :
                  // 2. Add Small button :
                  // screen_width < 800
                  //     ? Text('')
                  //     : Expanded(
                  //         flex: 1,
                  //         child: SocailAuth(),
                  //       ),

                  // SPACING RESPONSIVE
                  // Hide Image
                  // screen_width < 1150
                  //     ? Expanded(flex: 1, child: Text(''))
                  //     : Text('')
                ],
              )),
        ]),
      ),

      // SIDE REPRESENTATIVE IMAGE
      screen_width < 1150
          ? Text('')
          : Expanded(
              child: LoginSideImage(),
            )
    ]);
  }
}
