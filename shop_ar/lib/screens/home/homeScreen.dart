import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/models/oneProduct.dart';
import 'package:shop_ar/repository/data_repository.dart';

import '../product/shopping_cart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  // This widget is the root of your application.

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF353535),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(

          title: const Text('ShopAR',
            style: TextStyle(color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
          //backgroundColor: Color(0xFFE84855),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  }
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            ///add onpressed

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile'
              ///add on pressed!
          ),
        ],
        selectedItemColor: Color(0xFFF08B93),
        unselectedItemColor: Colors.grey,
      ),
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
