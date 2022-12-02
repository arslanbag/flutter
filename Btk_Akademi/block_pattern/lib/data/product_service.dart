import 'package:flutter_block_pattern/models/product.dart';

class ProductService {
  static List<Product> products = <Product>[];

  static final ProductService _singleton = ProductService._internal();

  factory ProductService() {
    return _singleton;
  }

  ProductService._internal();

  static List<Product> getAll() {
    products.add(Product(1, "MSI Laptop", 15000));
    products.add(Product(2, "Acer Laptop", 12000));
    products.add(Product(3, "Casper Laptop", 11000));
    return products;
  }
}
