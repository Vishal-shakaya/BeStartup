import 'package:be_startup/Components/LoginView/LoginPage/LoginForm.dart';
import 'package:be_startup/Components/LoginView/LoginPage/SignupBox.dart';
import 'package:be_startup/Components/LoginView/LoginPage/SocialAuthRow.dart';
import 'package:flutter/material.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class LoginTabs extends StatelessWidget {
  const LoginTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? indicator_color = Get.isDarkMode? Colors.tealAccent:Colors.teal.shade300;
   
    return DefaultTabController(
      length: 2,
      child: Container(
        margin:EdgeInsets.only(left:50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 50,
                margin:EdgeInsets.only(top:10),
                child: TabBar(
                  tabs:  [
                    Container(
                      padding: EdgeInsets.only(right:15),
                      child: Tab(
                        iconMargin: EdgeInsets.all(4),
                        child:Text('Login',
                        overflow: TextOverflow.ellipsis,
                          style:Get.theme.textTheme.headline4
                         ) 
                       ),
                    ),
                  
                    Container(
                      padding: EdgeInsets.only(left:15),
                      child: Tab(
                        iconMargin: EdgeInsets.all(4),
                        child:Text('Signup',
                        overflow: TextOverflow.ellipsis,
                            style:Get.theme.textTheme.headline4,
                                ),
                      ),
                    ),

                  ],
                  labelColor: Colors.orange[800],
                  indicator: ContainerTabIndicator(
                    color: indicator_color,
                    widthFraction: 0.39,
                    height: 5,
                    padding: const EdgeInsets.only(top: 30),
                    radius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 300,
                margin: EdgeInsets.only(top: 20),
                child: TabBarView(
                  children: [
                    LoginForm(), 
                    SignupForm()
                    ]),
              ),

              context.width<800
              ?SocialAuthRow()
              :Text('')
               
            ],
          ),
        ),
      ),
    );
  }
}
