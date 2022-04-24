// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ar/screens/loginSignup/login_page.dart';
import 'package:shop_ar/screens/loginSignup/new_user.dart';
import 'package:shop_ar/screens/loginSignup/loading_main.dart';

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
                  if (_index <= 1) {
                    setState(() {
                      _index += 1;
                    });
                  } else if (_index > 1) {}
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: _steps,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  print(FirebaseAuth.instance.currentUser);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text("Finish"),
              ),
            ],
          ),
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
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
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
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value!.contains('A')) ? "WRONG BITCH" : null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'State',
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
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
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
          ),
        ),
      ],
    );
  }
}