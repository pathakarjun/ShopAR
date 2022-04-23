import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ar/Firebase/productService.dart';
import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/models/oneProduct.dart';
import 'package:shop_ar/repository/data_repository.dart';

import 'package:shop_ar/screens/home/constant.dart';

import '../../controllers/Product_widget.dart';

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

          title: Text('ShopAR',
            style: TextStyle(color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
          backgroundColor: Color(0xFFE84855),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){

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
      /*Padding(
        padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
        /*child: GridView.builder(
          itemCount: 100,
          itemBuilder: (context,index) => ItemTile(index),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
        ),*/
        /*
        child: Container(
                  //product: ProductModel(id: 'id', image: 'image', name: 'name', seller: 'seller', price: 10.0)
          //SingleProductWidget(product: productController.products.)
            child: GridView.count(
            crossAxisCount: 2,
              children:
            productController.products.map((ProductModel product) {
                return SingleProductWidget(product: product);
              }).toList()

            )
        )
        */



      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile'
          ),
        ],
        backgroundColor: Color(0xFF353535),
        selectedItemColor: Color(0xFFF08B93),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  /*
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),

      children: snapshot.map((data) => _buildListItem(context ,data)).toList(),
    );
  }
   */
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,

      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),


      children: snapshot.map((data) => _buildListItem(context ,data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final product = ProductModel.fromSnapshot(snapshot);
    return SingleProductWidget(product: product /*, boldStyle: boldStyle*/);
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
      this.itemNo
      );

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: color.withOpacity(0.3),
        onTap: () {},
        leading: Container(
          width: 50,
          height: 30,
          color: color.withOpacity(0.5),
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Product $itemNo',
          key: Key('text_$itemNo'),
        ),
      ),
    );
  }
}




/*
class HomeScreen extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF353535),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(

          title: Text('ShopAR',
            style: TextStyle(color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
          backgroundColor: Color(0xFFE84855),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){

                  }
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
        /*child: GridView.builder(
          itemCount: 100,
          itemBuilder: (context,index) => ItemTile(index),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
        ),*/
        /*
        child: Container(
                  //product: ProductModel(id: 'id', image: 'image', name: 'name', seller: 'seller', price: 10.0)
          //SingleProductWidget(product: productController.products.)
            child: GridView.count(
            crossAxisCount: 2,
              children:
            productController.products.map((ProductModel product) {
                return SingleProductWidget(product: product);
              }).toList()

            )
        )
        */



      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile'
          ),
        ],
        backgroundColor: Color(0xFF353535),
        selectedItemColor: Color(0xFFF08B93),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
      this.itemNo
      );

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: color.withOpacity(0.3),
        onTap: () {},
        leading: Container(
          width: 50,
          height: 30,
          color: color.withOpacity(0.5),
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Product $itemNo',
          key: Key('text_$itemNo'),
        ),
      ),
    );
  }
}

 */

/*
class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,

        children: productController.products.map((ProductModel product) {

          return SingleProductWidget(product: product);
        }).toList()));
  }
}
*/

/*
class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.Image,
                  width: double.infinity,
                )),
          ),
          Text(
            product.Name
          ),
          Text(
            product.Seller,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "\$${product.Price}"
                ),
              ),
              SizedBox(
                width: 30,
              ),
              /*IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProductToCart(product);
                  })*/
            ],
          ),
        ],
      ),
    );
  }
}*/