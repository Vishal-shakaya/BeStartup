// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:be_startup/UI/RegistrationView/RegistrationView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_startup/Handlers/Login.dart';
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
        // CONFIGURE THEME SETTING :
        themeMode: ThemeMode.light,
        // themeMode: ThemeMode.dark,
        theme: ThemeData(
          textTheme: LightFontTheme(textTheme),
          primaryColor: Color(0xff1e847f),
          primarySwatch: Colors.teal,
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
        ],
      );
  }
}
