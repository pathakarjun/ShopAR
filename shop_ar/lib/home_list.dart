import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/models/oneProduct.dart';
import 'package:shop_ar/repository/data_repository.dart';



class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  final DataRepository repository = DataRepository();
  final boldStyle =
  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context , snapshot) {
          if(!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data?.docs ?? []);
    }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_addPet();
        },
        tooltip: 'Add Pet',
        child: const Icon(Icons.add),
      ),
    );
  }

  /*void _addPet() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddPetDialog();
      },
    );
  }

   */


Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),

    children: snapshot.map((data) => _buildListItem(context ,data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  final product = ProductModel.fromSnapshot(snapshot);
  return SingleProductWidget(product: product /*, boldStyle: boldStyle*/);
}

}
