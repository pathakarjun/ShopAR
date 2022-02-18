import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'loading/loadingMain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //PRIMARY CUSTOM COLOR (DARKER RED)
    Map<int, Color> primary = {
      50: Color.fromRGBO(232, 72, 85, .1),
      100: Color.fromRGBO(232, 72, 85, .2),
      200: Color.fromRGBO(232, 72, 85, .3),
      300: Color.fromRGBO(232, 72, 85, .4),
      400: Color.fromRGBO(232, 72, 85, .5),
      500: Color.fromRGBO(232, 72, 85, .6),
      600: Color.fromRGBO(232, 72, 85, .7),
      700: Color.fromRGBO(232, 72, 85, .8),
      800: Color.fromRGBO(232, 72, 85, .9),
      900: Color.fromRGBO(232, 72, 85, 1),
    };
    MaterialColor darkRed = MaterialColor(0xFFE84855, primary);

    Map<int, Color> secondary = {
      50: Color.fromRGBO(240, 139, 147, .1),
      100: Color.fromRGBO(240, 139, 147, .2),
      200: Color.fromRGBO(240, 139, 147, .3),
      300: Color.fromRGBO(240, 139, 147, .4),
      400: Color.fromRGBO(240, 139, 147, .5),
      500: Color.fromRGBO(240, 139, 147, .6),
      600: Color.fromRGBO(240, 139, 147, .7),
      700: Color.fromRGBO(240, 139, 147, .8),
      800: Color.fromRGBO(240, 139, 147, .9),
      900: Color.fromRGBO(240, 139, 147, 1),
    };
    MaterialColor lightRed = MaterialColor(0xFFE84855, secondary);

    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: darkRed,
          ).copyWith(secondary: lightRed, brightness: Brightness.dark),
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF1E1E1E),
          primaryColor: const Color(0xFFE84855),

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          body: Container(
            alignment: Alignment.center,
            child: Container(
              child: LoadingScreen(),
            ),// New code
          ),
        ));
  }
}
