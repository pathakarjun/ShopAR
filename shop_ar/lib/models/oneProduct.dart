import 'package:flutter/material.dart';

import 'package:shop_ar/models/ProductModel.dart';



class SingleProductWidget extends StatelessWidget {
  final  ProductModel product;

  SingleProductWidget({Key? key, required this.product /*, required this.boldStyle*/})
      : super(key: key);
  //const SingleProductWidget({ required this.product} ) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  product.image,
                  width: 300,
                  height: 300,
                  //width: double.infinity,
                )),
          ),
          Text(
              product.name
          ),
          /*Text(
            product.seller,
          ),*/
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

            ],
          ),
        ],
      ),
    );
  }
}