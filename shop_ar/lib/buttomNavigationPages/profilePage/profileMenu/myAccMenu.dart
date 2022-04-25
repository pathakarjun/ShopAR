import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _phoneController;
  TextEditingController? _cityController;
  TextEditingController? _stateController;
  TextEditingController? _streetController;
  TextEditingController? _zipcodeController;

  setDataToTextField(data) {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameController =
              TextEditingController(text: data['firstname']),
        ),
        TextFormField(
          controller: _lastNameController =
              TextEditingController(text: data['lastname']),
        ),
        TextFormField(
          controller: _phoneController =
              TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _cityController =
              TextEditingController(text: data['city']),
        ),
        TextFormField(
          controller: _stateController =
              TextEditingController(text: data['state']),
        ),
        TextFormField(
          controller: _streetController =
              TextEditingController(text: data['street']),
        ),
        TextFormField(
          controller: _zipcodeController =
              TextEditingController(text: data['zipcode']),
        ),
        ElevatedButton(onPressed: () => updateData(), child: Text("Update"))
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "first name": _firstNameController!.text,
      "last name": _lastNameController!.text,
      "phone": _phoneController!.text,
      "city": _cityController!.text,
      "state": _stateController!.text,
      "steet": _streetController!.text,
      "zip code": _zipcodeController!.text,
    }).then((value) => Fluttertoast.showToast(msg: "Updated Successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return setDataToTextField(data);
          },
        ),
      )),
    );
  }
}
