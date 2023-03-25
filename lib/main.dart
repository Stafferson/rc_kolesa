import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rc_kolesa/pages/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late SharedPreferences? prefs;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: false,
        builder: (_, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: AnimatedSplashScreen(
                duration: 100,
                //splash: SvgAsset(
                //  assetName: AssetName.fizmatApp,
                //  width: 112.w,
                //),
                splash: Icon(
                  Icons.holiday_village_outlined,
                  size: 112.w,
                ),
                nextScreen: LoginScreen(),
                //nextScreen: HomePage(),
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.fade,
                backgroundColor: Colors.white,
            )
          //home: HomePage(),
        )
    );
  }
}
