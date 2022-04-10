import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
        child: GridView.builder(
          itemCount: 100,
          itemBuilder: (context,index) => ItemTile(index),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
        ),

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

//class ProductsWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Obx(()=>GridView.count(
//        crossAxisCount: 2,
//        childAspectRatio: .63,
//        padding: const EdgeInsets.all(10),
//        mainAxisSpacing: 4.0,
//        crossAxisSpacing: 10,
//        children: producsController.products.map((ProductModel product) {
//          return SingleProductWidget(product: product,);
//        }).toList()));
//  }
//}