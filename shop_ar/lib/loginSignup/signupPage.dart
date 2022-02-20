// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/loginSignup/loadingMain.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text("ShopAR"),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              controller: email,
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              controller: password,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                login();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoadingScreen()),
                );
              },
              child: Text("Login"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                print(FirebaseAuth.instance.currentUser);
              },
              child: Text("Sign Up"),
            ),
            SizedBox(height: 15),
            TextButton(onPressed: () {}, child: Text("Forgot Password?"))
          ],
        ),
      ),
    );
  }
}
