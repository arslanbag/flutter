import 'package:flutter/material.dart';
import 'package:http_demo/models/product.dart';

class ProductListRowWidget extends StatelessWidget {
  Product product;

  ProductListRowWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: [
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.network(
                  "https://cdn.pixabay.com/photo/2017/05/19/07/34/teacup-2325722_960_720.jpg"),
            ),
            Text(product.productName.toString()),
            Text(
              "${product.unitPrice}₺",
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
