// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:be_startup/Handlers/Login.dart';
import 'package:be_startup/Utils/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        // CONFIGURE RESPONSIVE BREAKPOINTS :
        // builder: (context, widget) => ResponsiveWrapper.builder(
        //   BouncingScrollWrapper.builder(context, widget!),
        //   maxWidth: 1920,
        //   minWidth: 480,
        //   defaultScale: true,
        //   breakpoints: [
        //     ResponsiveBreakpoint.resize(480, name: MOBILE),
        //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //     ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //     ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //     ResponsiveBreakpoint.resize(2460, name: '4K'),
        //   ],
        // ),

        // CONFIGURE THEME SETTING :
        themeMode: ThemeMode.light,
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
              : GetPage(name: '/', page: () => LoginHandler())
        ],
      );
  }
}
