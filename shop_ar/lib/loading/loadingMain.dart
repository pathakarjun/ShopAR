import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          CircularProgressIndicator(),
          Text("Loading...",
          textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}