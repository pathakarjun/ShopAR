import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ar/Firebase/productService.dart';
import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/models/oneProduct.dart';

import '../screens/home/constant.dart';




class ProductsWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Obx(()=>GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,

        children: productController.products.map((ProductModel product) {
          return SingleProductWidget(product: product);
        }).toList()));
  }
}
