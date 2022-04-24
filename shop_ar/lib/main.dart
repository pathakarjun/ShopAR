
import 'package:flutter/material.dart';
import 'screens/home/homeScreen.dart';
import 'Firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ShopAR());
}

class ShopAR extends StatelessWidget {
  const ShopAR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );

  }
}



///References
/// https://www.raywenderlich.com/26435435-firestore-tutorial-for-flutter-getting-started
///
///
///
///



