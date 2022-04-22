
/*class ProductModel{
  static const ID = "id";
  static const IMAGE = "Image";
  static const NAME = "Name";
  static const PRICE = "Price";
  static const SELLER = "Seller";

  String id = 'test';
  String image = 'image';
  String name = 'name';
  String seller = 'seller';
  double price = 0.0;

  ProductModel({required this.id,required this.image,required this.name,required this.seller,required this.price});

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    seller = data[SELLER];
    price = data[PRICE].toDouble();
  }

}*/

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{

  final String id;
  final String image;
  final String name;
  final String seller;
  final double price;

  ProductModel({required this.id,required this.image,required this.name,required this.seller,required this.price});

  static ProductModel fromSnapshot(DocumentSnapshot snap) {
    ProductModel productModel = ProductModel(
        id: snap['id'],
        image: snap['Image'],
        name: snap['Name'],
        seller: snap['Seller'],
        price: snap['Price']
    );
    return productModel;
  }

}
