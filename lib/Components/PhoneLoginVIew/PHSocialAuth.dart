import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:get/get.dart';

class PHSocailAuth extends StatelessWidget {
  const PHSocailAuth({Key? key}) : super(key: key);
   // SOCIAL MIDEA AUTH BUTTON DIAOG BOX :
    SocialAuthModal(){
      Get.dialog(
       FractionallySizedBox(
         widthFactor: 0.70,
         heightFactor: 0.45,
         child:Container(
           alignment: Alignment.center,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.all(Radius.circular(20))
           ),

          child:Wrap(
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.down,
            alignment: WrapAlignment.center,
            spacing: 15,
          children: [
            
            // AUTH TEXT  
            Container(
              margin:EdgeInsets.only(left:60),
              child: Text('Continue with',
              softWrap: true,
              style: TextStyle(
                color:light_color_type3, 
                fontSize: 15,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none  
              ) ,),
            ),


            // SOCIAL BUTTONS:     
            SignInButton(
              buttonType: Get.isDarkMode? ButtonType.googleDark: ButtonType.google,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            SignInButton(
              buttonType:ButtonType.twitter ,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            SignInButton(
              buttonType: ButtonType.linkedin,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
            SignInButton(
              buttonType:  ButtonType.apple,
              elevation: 3,
              onPressed: () {
              print('click');
              }),
          ],
        )
           )
       ),
       transitionDuration: Duration(milliseconds:370)
     );
    }
  @override
  Widget build(BuildContext context) {
    // THEME MANAGE :
    final auth_image =
        Get.isDarkMode ? dark_social_auth_image : light_social_auth_image;

  

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('or', style: TextStyle(color: light_color_type3))),
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          child: InkWell(
            onTap: SocialAuthModal,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            child: Container(
                width: 130,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                child: Image.asset(auth_image,
                    width: 110, height: 50, fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}
