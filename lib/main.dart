// ignore_for_file: prefer_const_constructors
import 'package:be_startup/UI/RegistorTeam/RegistorFounderView.dart';
import 'package:be_startup/UI/RegistorTeam/RegistorTeamView.dart';
import 'package:be_startup/UI/RegistrationView/RegistrationView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessCatigoryView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessDetailView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessMileStoneView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessProductView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessThumbnailView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessVision.dart';
import 'package:be_startup/UI/StartupSlides/StartupSlides.dart';
import 'package:be_startup/UI/StartupView/StartupView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Handlers/UserRegistration/Login.dart';
import 'package:be_startup/Utils/Fonts.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:be_startup/Components/WebLoginView/LoginPage/SignupView.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final is_login = false;
    final textTheme = Theme.of(context).textTheme;

      return GetMaterialApp(
      // INITILIZE TOAST DIALOG  : 
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),

        // CONFIGURE THEME SETTING :
        themeMode: ThemeMode.light,
        // themeMode: ThemeMode.dark,
        theme: ThemeData(
          textTheme: LightFontTheme(textTheme),
          primaryColor: Color(0xFF54BAB9),
          primarySwatch: Colors.blueGrey
        ),

        // Dark Theme
        darkTheme: ThemeData(
          textTheme: DarkFontTheme(textTheme),
          brightness: Brightness.dark,
        ),

        // CONFIGURE ROUTES
        unknownRoute:
            GetPage(name: '/error-page', page: () => Text('Unknown Route')),
        initialRoute: '/',
        getPages: [
          is_login
            ? GetPage(name: '/', page: () => Text('Home  page'))
            : GetPage(name: '/', page: () => LoginHandler()),

          GetPage(name: signup_url,page:()=> SignupView() ), 
          GetPage(name: user_registration_url ,page:()=> RegistrationView() ), 
          GetPage(name: startup_slides_url ,page:()=> StartupSlides() ), 
          
          // BUSINESS DETAIL : 
          GetPage(name: create_business_detail_url ,page:()=> BusinessDetailView() ), 
          GetPage(name: create_business_thumbnail_url ,page:()=> BusinessThumbnailView() ), 
          GetPage(name: create_business_vision_url ,page:()=> BusinessVisionView() ), 
          GetPage(name: create_business_milestone_url ,page:()=> BusinessMileStone() ), 
          GetPage(name: create_business_catigory_url ,page:()=> BusinessCatigoryView() ), 
          GetPage(name: create_business_product_url ,page:()=> BusinessProductView() ), 

          // FOUNDER REGISTRATION AND TEAM 
          GetPage(name: create_founder ,page:()=> RegistorFounderView() ), 
          GetPage(name: create_business_team ,page:()=> RegistorTeamView() ), 

          // STARTUP PAGE: 
          GetPage(name:  startup_view_url,page:()=> StartupView() ), 

           
        ],
      );
  }
}
