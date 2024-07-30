import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/Product_card.dart';
import 'Product_Detail_Page.dart';


class ProductListScreen extends StatefulWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('grocery/products');
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final snapshot = await _database.orderByChild('category').equalTo(widget.categoryName).get();
      print('Snapshot: ${snapshot.value}');

      if (snapshot.exists) {
        final data = snapshot.value as Map;

        List<Map<String, dynamic>> products = [];
        data.forEach((key, value) {
          products.add({
            'name': value['name'] as String? ?? '',
            'price': (value['price'] is int ? value['price'].toString() : value['price'] as String? ?? ''),
            'image': value['image'] as String? ?? '',
            'unit': value['unit'] as String? ?? '',
          });
        });

        setState(() {
          _products = products;
          _isLoading = false;
        });
      } else {
        print('No products found for category: ${widget.categoryName}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(
                        name: _products[index]['name']!,
                        price: _products[index]['price']!,
                        image: _products[index]['image']!,
                        unit: _products[index]['unit']!,
                        onAddToCart: () {
                          // Handle add to cart
                        },
                        onTap: () {  // Navigate to ProductDetailPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                name: _products[index]['name']!,
                                price: _products[index]['price']!,
                                image: _products[index]['image']!,
                              ),
                            ),
                          ); },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
