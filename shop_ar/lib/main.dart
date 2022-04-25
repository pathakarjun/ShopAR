import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ar/screens/loginSignup//login_page.dart';
import 'firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_ar/homeScreen.dart';
import 'package:shop_ar/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //PRIMARY CUSTOM COLOR (DARKER RED)
    Map<int, Color> primary = {
      50: const Color.fromRGBO(232, 72, 85, .1),
      100: const Color.fromRGBO(232, 72, 85, .2),
      200: const Color.fromRGBO(232, 72, 85, .3),
      300: const Color.fromRGBO(232, 72, 85, .4),
      400: const Color.fromRGBO(232, 72, 85, .5),
      500: const Color.fromRGBO(232, 72, 85, .6),
      600: const Color.fromRGBO(232, 72, 85, .7),
      700: const Color.fromRGBO(232, 72, 85, .8),
      800: const Color.fromRGBO(232, 72, 85, .9),
      900: const Color.fromRGBO(232, 72, 85, 1),
    };
    MaterialColor darkRed = MaterialColor(0xFFE84855, primary);

    Map<int, Color> secondary = {
      50: const Color.fromRGBO(240, 139, 147, .1),
      100: const Color.fromRGBO(240, 139, 147, .2),
      200: const Color.fromRGBO(240, 139, 147, .3),
      300: const Color.fromRGBO(240, 139, 147, .4),
      400: const Color.fromRGBO(240, 139, 147, .5),
      500: const Color.fromRGBO(240, 139, 147, .6),
      600: const Color.fromRGBO(240, 139, 147, .7),
      700: const Color.fromRGBO(240, 139, 147, .8),
      800: const Color.fromRGBO(240, 139, 147, .9),
      900: const Color.fromRGBO(240, 139, 147, 1),
    };
    MaterialColor lightRed = MaterialColor(0xFFE84855, secondary);

    ThemeData themeColors = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: darkRed,
      ).copyWith(secondary: lightRed, brightness: Brightness.dark),
      backgroundColor: const Color(0xFF1E1E1E),
      primaryColor: const Color(0xFFE84855),
      scaffoldBackgroundColor: const Color(0xFF353535),
      appBarTheme: const AppBarTheme(
          color: Color(0xFF1e1e1e),
          foregroundColor: Color(0xFFFFFFFF)),

      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ).apply(
        bodyColor: Colors.white,
        displayColor: Theme.of(context).colorScheme.primary,
      ),
    );

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext c) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeColors,
        home: SplashScreen(),
      ),
    );

  }
}


///References
/// https://www.raywenderlich.com/26435435-firestore-tutorial-for-flutter-getting-started
///
///
///
///



