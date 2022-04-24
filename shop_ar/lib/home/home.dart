// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_ar/product/product_page.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          child: Container(
            width: 1000,
            height: 2000,
            child: const ProductPage(
                description:
                    'This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read. This watch is an orange watch with a face and it keeps track of time. You could even hang it up on a wall to have a tiny clock that you would have to get close to in order to read.',
                image:
                    'https://firebasestorage.googleapis.com/v0/b/shopar-3f662.appspot.com/o/watch2.jpg?alt=media&token=9fb3508b-0e0f-4a34-8c3b-b79070e1870a',
                price: 250,
                name: 'Orange Watch',
                id: '6KUuMIxS3QnWfEimCefE'),
          ),
        ));
  }
}
