import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/ProductModel.dart';

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