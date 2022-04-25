// **** importing all of our files and data ****
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:shop_ar/screens/product/ar_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProductPage extends StatelessWidget {
// ***** parameters for to create a product page ****
  final String name;
  final int price;
  final String? description;
  final String image;
  final String id;

// **** what constructs the page ****
  const ProductPage(
      {required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.id});

  @override
  Widget build(BuildContext context) {
//creates an instance of the collection of users
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance; //auth for the user

    Future<void> addToCart() {
      // **** adds the current items id to the current users cart. ****
      // ***** Call the user's CollectionReference to add a new user *****
      return users
          .doc(auth.currentUser!.uid)
          .collection('cart')
          .add({'id': id})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

// ****** design for the app. Covers the color scheme to the placements of buttons.*****
    return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "\$",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${price.toString()}.00',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  // ***** the creation of the button for add to cart. ******
                  style: ElevatedButton.styleFrom(
                      // fromHeight use double.infinity as width and 40 is the height
                      ),
                  onPressed: () {
                    addToCart();
                    print("ADD TO CART");
                  },
                  child: const Text(
                    '+ Add to Cart',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          )),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: -10,
                            color: Colors.black,
                            offset: Offset(0, 20),
                            blurRadius: 7,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.network(
                          image,
                          width: 400,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ElevatedButton(
                            // ***** this is the button to push the page for the AR model *****
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              Navigator.push(
                                // ***** this function pushes the new ARs page. ******
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ARModel()),
                              );
                            },
                            child: const Icon(Icons.threed_rotation)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "Seller",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Spacer()
                      ],
                    ),
                    ExpandableText(
                      description!,
                      expandText: 'Read more',
                      style: const TextStyle(fontSize: 17),
                      collapseText: 'Read less',
                      maxLines: 3,
                      animation: true,
                      linkColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 30),
                  ],
                )),
          ),
        ));
  }
}
