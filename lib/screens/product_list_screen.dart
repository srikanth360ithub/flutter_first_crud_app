import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_list_model.dart';

class ProductListViewScreen extends StatefulWidget {
  const ProductListViewScreen({super.key});

  @override
  State<ProductListViewScreen> createState() => _ProductListViewScreenState();
}

class _ProductListViewScreenState extends State<ProductListViewScreen> {
  List<Product> products = [];
  int limit = 10;
  int skip = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true);

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      print('ResponseQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ: ${response.body}');
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];

      if (productsJson.isEmpty) {
        hasMore = false;
      } else {
        final newProducts =
            productsJson.map((e) => Product.fromJson(e)).toList();
        setState(() {
          products.addAll(newProducts);
          skip += limit;
        });
      }
    } else {
      throw Exception('Failed to load products');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              hasMore &&
              scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
            fetchProducts();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: products.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < products.length) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text(product.description),
                trailing: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
