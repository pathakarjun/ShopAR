class ProductModel{
  static const ID = "id";
  static const IMAGE = "Image";
  static const NAME = "Name";
  static const PRICE = "Price";
  static const SELLER = "Seller";

  late String id;
  late String Image;
  late String Name;
  late String Seller;
  late double Price;

  ProductModel(this.id, this.Image, this.Name, this.Seller, this.Price);

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    Image = data[IMAGE];
    Name = data[NAME];
    Seller = data[SELLER];
    Price = data[PRICE].toDouble();
  }

}