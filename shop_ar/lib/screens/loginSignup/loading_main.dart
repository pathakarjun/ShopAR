import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Firebase/firebase_options.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircularProgressIndicator(),
          Text(
            "Loading...",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                signOut();
                print("LOGGED OOUT");
              },
              child: Text("LOG OUT"))
        ],
      ),
    );
  }
}