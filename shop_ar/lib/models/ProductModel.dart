
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{

  String id;
  String image;
  String name;
  //String seller;
  String? description;
  int price;

  String? reference;

  ProductModel( this.id , {required this.image,required this.name,/*required this.seller,*/required this.price, this.reference,this.description});

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
    description: json['Description'] as String,
    //seller: json['Seller'] as String,
    price: json['Price'] as int,
  );
}

Map<String, dynamic> _productToJson(ProductModel instance) => <String, dynamic> {
  'id': instance.id,
  'Image': instance.image,
  'Name': instance.name,
  //'Seller': instance.seller,
  'Price': instance.price,
  'Description' :instance.description,
};
