import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, dynamic>? product;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/${widget.productId}'));
    if (response.statusCode == 200) {
      setState(() {
        product = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(product!['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(product!['description']),
                  SizedBox(height: 16),
                  Text('Price: \$${product!['price']}'),
                  Text('Brand: ${product!['brand']}'),
                  Text('Stock: ${product!['stock']}'),
                  Text('Rating: ${product!['rating']}'),
                  SizedBox(height: 16),
                  Text('Return Policy: ${product!['returnPolicy']}'),
                  Text('Warranty: ${product!['warrantyInformation']}'),
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}
