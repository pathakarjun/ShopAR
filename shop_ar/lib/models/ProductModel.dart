
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
/*
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

 */

class ProductModel{

  String id;
  String image;
  String name;
  //String seller;
  double price;

  String? reference;

  ProductModel( this.id , {required this.image,required this.name,/*required this.seller,*/required this.price, this.reference});

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newProduct = ProductModel.fromJson(snapshot.data() as Map<String, dynamic>);
    newProduct.reference = snapshot.reference.id;
    return newProduct;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json)=> _productFromJson(json);

  Map<String, dynamic> toJson() => _productToJson(this);
  @override
  String toString() => 'Product<$id>';
}

ProductModel _productFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['id'] as String,
    image: json['Image'] as String,
    name: json['Name'] as String,
    //seller: json['Seller'] as String,
    price: json['Price'] as double,
  );
}

Map<String, dynamic> _productToJson(ProductModel instance) => <String, dynamic> {
  'id': instance.id,
  'Image': instance.image,
  'Name': instance.name,
  //'Seller': instance.seller,
  'Price': instance.price,
};
