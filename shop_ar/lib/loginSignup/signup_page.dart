// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/loginSignup/login_page.dart';
import 'package:shop_ar/loginSignup/new_user.dart';
import 'package:shop_ar/loginSignup/loading_main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final NewUser user = NewUser();

  FirebaseAuth auth = FirebaseAuth.instance;

  void checkInput() {
    if (firstName.text != "" && lastName.text != "") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    }
  }

  int _index = 0;

  static const _steps = [
    Step(
      title: Text('Personal'),
      content: _PersonalForm(),
    ),
    Step(
      title: Text('Address'),
      content: _AddressForm(),
    ),
    Step(
      title: Text('Phone Number'),
      content: _PhoneForm(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Stepper(
              //type: StepperType.horizontal,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 1) {
                  setState(() {
                    _index += 1;
                  });
                } else if (_index > 1){

                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: _steps,
            )
          ],
        ),
      ),
    );
  }
}

class _PersonalForm extends StatelessWidget {
  const _PersonalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
        ),
      ],
    );
  }
}

class _AddressForm extends StatelessWidget {
  const _AddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Street',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'City',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'State',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Zip Code',
          ),
        ),
      ],
    );
  }
}

class _PhoneForm extends StatelessWidget {
  const _PhoneForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
