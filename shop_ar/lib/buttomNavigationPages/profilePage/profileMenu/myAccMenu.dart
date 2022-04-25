import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_ar/appColors.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          const Text(
            ("Name"),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deep_red),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "First Name"),
            controller: _firstNameController =
                TextEditingController(text: data['first name']),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Last Name"),
            controller: _lastNameController =
                TextEditingController(text: data['last name']),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            ("Contact Info"),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deep_red),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Phone No."),
            controller: _phoneController =
                TextEditingController(text: data['phone']),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            ("Address"),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deep_red),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Street"),
            controller: _streetController =
                TextEditingController(text: data['street']),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "City."),
            controller: _cityController =
                TextEditingController(text: data['city']),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "State"),
            controller: _stateController =
                TextEditingController(text: data['state']),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Zip code"),
            controller: _zipcodeController =
                TextEditingController(text: data['zip code']),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  shape: (RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              onPressed: () => updateData(),
              child: const Text("Update", style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
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
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              Fluttertoast.showToast(msg: "Data does not exist");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return setDataToTextField(data);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}
