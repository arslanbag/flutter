import 'dart:async';

import 'package:flutter_block_pattern/data/product_service.dart';
import 'package:flutter_block_pattern/models/product.dart';

class ProductBloc {
  final productStreamController = StreamController.broadcast();

  Stream get getStream => productStreamController.stream;

  List<Product> getAll() {
    return ProductService.getAll();
  }
}

final productBloc = ProductBloc();
