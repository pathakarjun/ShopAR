import 'package:flutter/material.dart';

import 'package:shop_ar/models/ProductModel.dart';
import 'package:shop_ar/screens/product/product_page.dart';

import '../screens/product/product_page.dart';

///
///Add on pressed in this file to switch to product page
///
///
///

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  SingleProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                  name: product.name,
                  price: product.price,
                  description: product.description,
                  image: product.image,
                  id: product
                      .id)), // Replace ForgotPassPage() with home Page Screen
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.scaleDown,
                    //width: double.infinity,
                  )),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
              ],
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
                    "\$${product.price}",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
