import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_demo/data/api/category_api.dart';
import 'package:http_demo/data/api/products_api.dart';
import 'package:http_demo/models/category.dart';
import 'package:http_demo/models/product.dart';
import 'package:http_demo/widgets/product_list_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  List<Category> categories = <Category>[];
  List<Widget> categoryWidgets = <Widget>[];
  List<Product> products = <Product>[];

  @override
  void initState() {
    getCategoriesFromApi();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alışveriş Sistemi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryWidgets,
              ),
            ),
            ProductListWidget(products)
          ],
        ),
      ),
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((value) {
      Iterable list = json.decode(value.body);
      setState(() {
        categories = list.map((e) => Category.fromJson(e)).toList();
        getCategorysWidgets();
      });
    });
  }

  List<Widget> getCategorysWidgets() {
    for (int i = 0; i < categories.length; i++) {
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget getCategoryWidget(Category category) {
    return TextButton(
      onPressed: () {
        getProductsByCategoryId(category);
      },
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: Colors.lightGreenAccent))),
      child: Text(
        category.categoryName.toString(),
        style: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  void getProductsByCategoryId(Category category) async {
    ProductApi.getProductsByCategoryId(category.id!).then((value) {
      Iterable list = json.decode(value.body);
      setState(() {
        products = list.map((e) => Product.fromJson(e)).toList();
      });
    });
  }

  void getProducts() async {
    ProductApi.getProducts().then((value) {
      Iterable list = json.decode(value.body);
      setState(() {
        products = list.map((e) => Product.fromJson(e)).toList();
      });
    });
  }
}
