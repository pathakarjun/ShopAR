import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/ProductModel.dart';
/*
class productService {

  FirebaseFirestore? _instance;

  //List<Products> _products = []

  Future<void> getProductsFromFirebase()async{

    _instance = FirebaseFirestore.instance;
    CollectionReference products = _instance!.collection('Products');


  }
}*/

class productController extends GetxController {
  static productController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = 'Products';

  @override
  onReady(){
    super.onReady();
    products.bindStream(getALLProducts());
  }

  Stream<List<ProductModel>> getALLProducts() =>
      FirebaseFirestore
          .instance.collection(collection)
          .snapshots()
          .map((query)=>
          query
          .docs
          .map((item)=> ProductModel.fromMap(item.data()))
          .toList()
      );

}