import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Keys/CacheStoreKeys/CacheStoreKeys.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Components/RegistorInvestor/ChooseCatigory/ChooseCatigoryBody.dart';
import 'package:be_startup/Components/SelectPlan/SelectPlan.dart';
import 'package:be_startup/Components/StartupView/InvestPage/InvestPage.dart';
import 'package:be_startup/Components/StartupView/TeamPage/TeamPage.dart';
import 'package:be_startup/Components/StartupView/VisionPage/VisionPage.dart';
import 'package:be_startup/Helper/HorizontalScroll.dart';
import 'package:be_startup/UI/HomeView/HomeView.dart';
import 'package:be_startup/UI/RegistorInvestor/ChooseCatigoryView.dart';
import 'package:be_startup/UI/RegistorInvestor/InvestorRegistorFormView.dart';
import 'package:be_startup/UI/RegistorTeam/RegistorFounderView.dart';
import 'package:be_startup/UI/RegistorTeam/RegistorTeamView.dart';
import 'package:be_startup/UI/RegistrationView/RegistrationView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessCatigoryView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessDetailView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessMileStoneView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessProductView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessThumbnailView.dart';
import 'package:be_startup/UI/StartupSlides/BusinessVision.dart';
import 'package:be_startup/UI/StartupSlides/BusinessWhyView.dart';
import 'package:be_startup/UI/StartupSlides/StartupSlides.dart';
import 'package:be_startup/UI/StartupView/StartupView.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:be_startup/Handlers/UserRegistration/Login.dart';
import 'package:be_startup/Utils/Fonts.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Components/WebLoginView/Signup/SignupView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FIREBASE INITILZATION : 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // FACEBOOK SDK INITILIZE :
  if (GetPlatform.isWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webInitialize(
      appId: "554392976209038",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }


  runApp(const MyApp());
}





class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  
  // Razorpay Channel initilize: 
  static const platform = MethodChannel("razorpay_flutter");
  FirebaseAuth auth = FirebaseAuth.instance;

  //////////////////////////////////
  // LOADING SPINNER :
  //////////////////////////////////
  var spinner = Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: dartk_color_type3,
      strokeWidth: 5,
    ),
  );



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Wait for a sec to settle things clearly : 
    SetAppLocalState() async {
      await Future.delayed(Duration(milliseconds: 500));
    }


    /////////////////////////////////
    /// MY APP :
    /////////////////////////////////
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      // INITILIZE TOAST DIALOG  :
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),

      // CONFIGURE THEME SETTING :
      themeMode: ThemeMode.light,
     
     
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
          textTheme: LightFontTheme(textTheme),
          primaryColor: Color(0xFF54BAB9),
          primarySwatch: Colors.blueGrey),

     
     
      // Dark Theme
      darkTheme: ThemeData(
        textTheme: DarkFontTheme(textTheme),
        brightness: Brightness.dark,
      ),


     
     ////////////////////////////////
     /// Routes : 
     ////////////////////////////////
      unknownRoute:
          GetPage(name: '/error-page', page: () => Text('Unknown Route')),
     
      // Default Route : 
      initialRoute: '/',
     
      getPages: [
        GetPage(
            name: home_route,
            page: () {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  
                  
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // SHOW ERROR :
                      ErrorPage();
                    }


                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return spinner;
                    }
                  
                  
                    if (snapshot.hasData) {
                      // Check Login user complete profile setup or not :
                      // if Complete then redirect to
                      // Configure App local state :
                      SetAppLocalState();


                      return HomeView();

                    }
                    return LoginHandler();


                  });
            }),



        GetPage(name: user_registration_url,
             page: () => RegistrationView()),

        GetPage(name: signup_url,
             page: () => SignupView()),

        GetPage(name: login_handler_url,
             page: () => LoginHandler()),

        GetPage(name: startup_slides_url,
             page: () => StartupSlides()),


        // BUSINESS DETAIL :
        GetPage(
            name: create_business_detail_url, 
             page: () => BusinessDetailView()),
        GetPage(
            name: create_business_thumbnail_url,
            page: () => BusinessThumbnailView()),
        GetPage(
            name: create_business_vision_url, page: () => BusinessVisionView()),
        GetPage(
            name: create_business_milestone_url,
            page: () => BusinessMileStone()),
        GetPage(
            name: create_business_catigory_url,
            page: () => BusinessCatigoryView()),
        GetPage(
            name: create_business_product_url,
            page: () => BusinessProductView()),
        GetPage(
            name: create_business_whyInvest_url,
            page: () => BusinessWhyInvestView()),

        // FOUNDER REGISTRATION AND TEAM
        GetPage(name: create_founder, 
           page: () => RegistorFounderView()),
        GetPage(name: create_business_team, 
           page: () => RegistorTeamView()),


        // STARTUP PAGE:
        GetPage(name: startup_view_url, 
            page: () => StartupView()),


        // SUB-ROUTES :
        // 1 Team Page :
        GetPage(name: team_page_url, 
            page: () => TeamPage()),
        GetPage(name: vision_page_url, 
            page: () => VisionPage()),
        GetPage(name: invest_page_url, 
            page: () => InvestPage()),


        // HOME PAGE
        GetPage(name: home_page_url, 
            page: () => HomeView()),



        // REGISTOR INVESTOR :
        GetPage(name: select_investor_choise, 
            page: () => ChooseCatigoryView()),
      
        GetPage(
            name: investor_registration_form,
            page: () => InvestorRegistorForm()),

        // SELECT PLAN
        GetPage(name: select_plan_url,
             page: () => SelectPlan()),

      ],
    );
  }
}
