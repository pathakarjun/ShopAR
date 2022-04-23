import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ProductModel.dart';

class DataRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('Products');

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  Future<DocumentReference> addProduct(ProductModel product){
    return collection.add(product.toJson());
  }

  void updateProduct(ProductModel product) async{
    await collection.doc(product.id).update(product.toJson());
  }

  void deleteProduct(ProductModel product) async {
    await collection.doc(product.id).delete();
  }

}