import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/ProductModel.dart';

/*
class ProductController extends GetxController {
  static ProductController instance = Get.find();
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
*/

/*
class ProductController extends BaseProductRepo{
  final FirebaseFirestore _firebaseFirestore;

  ProductController({FirebaseFirestore? firebaseFirestore}) :
      _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  @override
  onReady(){
  products.bindStream(getAllProducts());
}
  Stream<List<ProductModel>> getAllProducts() {
    return _firebaseFirestore
        .collection('Products')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }

}


abstract class BaseProductRepo {
  Stream<List<ProductModel>> getAllProducts();
}

 */

class ProductController extends BaseProductRepo{
  final FirebaseFirestore _firebaseFirestore;

  ProductController({FirebaseFirestore? firebaseFirestore}) :
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  @override
  onReady(){
    products.bindStream(getAllProducts());
  }
  Stream<List<ProductModel>> getAllProducts() {
    return _firebaseFirestore
        .collection('Products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }

}


abstract class BaseProductRepo {
  Stream<List<ProductModel>> getAllProducts();
}
