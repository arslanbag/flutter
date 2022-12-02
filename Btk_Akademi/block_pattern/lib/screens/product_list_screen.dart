import 'package:flutter/material.dart';
import 'package:flutter_block_pattern/blocs/cart_bloc.dart';
import 'package:flutter_block_pattern/blocs/product_bloc.dart';
import 'package:flutter_block_pattern/models/cart.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alışveriş"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, "/cart"),
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: buildProductList(),
    );
  }

  buildProductList() {
    return StreamBuilder(
        initialData: productBloc.getAll(),
        stream: productBloc.getStream,
        builder: (context, snapshot) {
          return snapshot.data.length > 0
              ? buildProductListItems(snapshot)
              : const Center(
                  child: Text("Data yok"),
                );
        });
  }

  buildProductListItems(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, index) {
        final list = snapshot.data;
        return ListTile(
          title: Text(list[index].name),
          subtitle: Text(list[index].price.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              cartBloc.addToCart(Cart(list[index], 1));
            },
          ),
        );
      },
    );
  }
}
