import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ar/Firebase/productService.dart';
import 'package:shop_ar/models/ProductModel.dart';


class SingleProductWidget extends StatelessWidget {
  final  ProductModel product;

  const SingleProductWidget({ required this.product} ) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                )),
          ),
          Text(
            "name"+
              product.name
          ),
          Text(
            product.seller,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    "\$${product.price}"
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              /*IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProductToCart(product);
                  })*/
            ],
          ),
        ],
      ),
    );
  }
}