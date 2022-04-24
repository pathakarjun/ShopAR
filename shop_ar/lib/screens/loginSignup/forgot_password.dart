// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/screens/loginSignup/loading_main.dart';
import 'package:shop_ar/screens/loginSignup/signup_page.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPage createState() => _ForgotPassPage();
}

class _ForgotPassPage extends State<ForgotPassPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Forgot Password?',
        ),
        // backgroundColor: Color(0xFF1e1e1e),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: email,
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  resetPassword(email.text);
                },
                child: const Text(
                  'Submit',
                ),
              ),
              SizedBox(height: 30),
              Text(
                "By clicking submit, if there is an account associated with the submitted email, "
                    "we will send the email a message with "
                    "information on how to reset it's account's password.",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}