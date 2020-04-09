import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:is_app/models/product.dart';

class ProductRepository {
  Future<List<Product>> loadData() async {
    String json = await rootBundle.loadString("assets/ISBikesData.json");

    List decodedJsonList = jsonDecode(json);

    return decodedJsonList.map((product) => Product.fromJson(product)).toList();
  }
}
