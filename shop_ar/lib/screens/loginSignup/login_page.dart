// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/screens/loginSignup/forgot_password.dart';
import 'package:shop_ar/screens/loginSignup/signup_page.dart';
import 'package:shop_ar/homeScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()), // Replace ForgotPassPage() with home Page Screen
              (r) => false
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Image(image: AssetImage("assets/images/Logo.png")),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  controller: email,
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  controller: password,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    login();
                  },
                  child: const Text(
                    'Log In',
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    print(FirebaseAuth.instance.currentUser);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text("Sign Up"),
                ),
                const SizedBox(height: 15),
                TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                }, child: const Text("Forgot Password?")),
              ],
            ),
          ),
        ),
      )
    );
  }
}
