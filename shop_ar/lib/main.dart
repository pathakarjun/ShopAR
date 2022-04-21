import 'package:flutter/material.dart';
import 'homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'ShopAR',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
