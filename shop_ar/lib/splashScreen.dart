import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_ar/appColors.dart';
import 'package:shop_ar/homeScreen.dart';
import 'package:shop_ar/screens/loginSignup/login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => authpersistence());
    super.initState();
  }

  authpersistence() => {
        if (FirebaseAuth.instance.currentUser != null)
          {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => HomeScreen()),
                (r) => false
            ),
          }
        else
          {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => LoginPage()),
                (r) => false
            ),
          }
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_red,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(image: AssetImage("assets/images/Logo.png")),
              CircularProgressIndicator(backgroundColor: Colors.white)
            ]),
      ),
    );
  }
}
