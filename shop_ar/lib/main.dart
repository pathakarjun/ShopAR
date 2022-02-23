import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_ar/loginSignup//login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginSignup/loading_main.dart';
import 'package:google_fonts/google_fonts.dart';

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
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: darkRed,
      ).copyWith(secondary: lightRed, brightness: Brightness.dark),
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF1E1E1E),
      primaryColor: const Color(0xFFE84855),


      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ).apply(
        bodyColor: Colors.white,
        displayColor: Theme.of(context).colorScheme.primary,
      ),
    );

    if (FirebaseAuth.instance.currentUser != null) {
      // ****LOGGED IN****
      return MaterialApp(
        theme: themeColors,
        home: Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          body: Container(
            alignment: Alignment.center,
            child: Container(
              child: LoginPage(),
            ), // New code
          ),
        ),
      );
    } else {
      // ****NOT LOGGED IN****
      return MaterialApp(
        theme: themeColors,
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Container(
              child: LoginPage(),
            ), // New code
          ),
        ),
      );
    }
  }
}
