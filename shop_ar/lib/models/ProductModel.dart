class ProductModel{
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

}