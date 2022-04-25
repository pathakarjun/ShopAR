import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/models/oneProduct.dart';
import 'package:shop_ar/repository/data_repository.dart';

import '../product/shopping_cart.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  // This widget is the root of your application.

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      childAspectRatio: 0.8,


      children: snapshot.map((data) => _buildListItem(context ,data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final product = ProductModel.fromSnapshot(snapshot);
    return SingleProductWidget(product: product /*, boldStyle: boldStyle*/);
  }
}
