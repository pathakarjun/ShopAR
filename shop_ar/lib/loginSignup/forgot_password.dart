// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/loginSignup/login_page.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPage createState() => _ForgotPassPage();
}

class _ForgotPassPage extends State<ForgotPassPage> {
  TextEditingController email = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (r) => false
    );
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
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: email,
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  resetPassword(email.text);
                },
                child: const Text(
                  'Submit',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
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
