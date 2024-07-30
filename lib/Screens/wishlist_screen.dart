import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, String>> wishlistItems = [
    {
      'name': 'Apple',
      'price': '\$1.00',
      'image': 'https://via.placeholder.com/100x100'
    },
    {
      'name': 'Banana',
      'price': '\$0.50',
      'image': 'https://via.placeholder.com/100x100'
    },
    {
      'name': 'Carrot',
      'price': '\$0.30',
      'image': 'https://via.placeholder.com/100x100'
    },
  ];

  WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: wishlistItems.isEmpty
          ? const Center(child: Text('Your wishlist is empty',
          style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Image.network(
                  item['image']!, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(item['name']!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text(item['price']!,
                  style: const TextStyle(fontSize: 14, color: Colors.green)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle item removal
                },
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          );
        },
      ),
    );
  }
}
