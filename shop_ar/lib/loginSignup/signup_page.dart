// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_ar/loginSignup/login_page.dart';
import 'package:shop_ar/loginSignup/new_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPage createState() => _SignupPage();
}

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class _SignupPage extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  final NewUser user = NewUser();

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> checkInput() async {
    if (_firstName.text != "" &&
        _lastName.text != "" &&
        _street.text != "" &&
        _city.text != "" &&
        _state.text != "" &&
        _zipCode.text != "" &&
        _phone.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text);

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: _email.text, password: _password.text);
          print(credential.user!.uid);
          FirebaseFirestore.instance
              .collection('Users')
              .doc(credential.user!.uid)
              .set({
                'first name': _firstName.text,
                'last name': _lastName.text,
                'street': _street.text,
                'city': _city.text,
                'state': _state.text,
                'zip code': _zipCode.text,
                'phone': _phone.text
              })
              .then((value) => FirebaseAuth.instance.signOut())
              .catchError((error) => print("Failed to add user: $error"));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(
                msg: "Wrong password provided for that user.");
          }
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage()), // Replace ForgotPassPage() with Home Page Screen
            (r) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "The account already exists for that email.");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'first name': _firstName, // John Doe
          'last name': _lastName, // Stokes and Sons
          'street': _street,
          'city': _city, // John Doe
          'state': _state,
          'zip code': _zipCode,
          'phone': _phone
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "Failed to add user: $error"));
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
        // backgroundColor: Color(0xFF1e1e1e),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Stepper(
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index <= 2) {
                    setState(() {
                      _index += 1;
                    });
                  } else if (_index > 2) {
                    checkInput();
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //spacing: 25,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(_index == 3 ? "SUBMIT" : "NEXT"),
                      ),
                      SizedBox(width: 25),
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: Text(_index == 0 ? " " : 'BACK'),
                      ),
                    ],
                  );
                },
                steps: <Step>[
                  Step(
                      title: const Text('Email and Password'),
                      content: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                          ),
                        ],
                      )),
                  Step(
                    title: const Text('Personal'),
                    content: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          controller: _firstName,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          controller: _lastName,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Address'),
                    content: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _street,
                          decoration: const InputDecoration(
                            labelText: 'Street',
                          ),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _city,
                          decoration: const InputDecoration(
                            labelText: 'City',
                          ),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _state,
                          decoration: const InputDecoration(
                            labelText: 'State (ST)',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            UpperCaseTextFormatter(),
                          ],
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _zipCode,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Zip Code',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Phone Number'),
                    content: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
