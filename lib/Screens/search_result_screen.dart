import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Simulating search results based on the query
    final List<Map<String, String>> searchResults = [
      {'name': 'Apple', 'price': '\$1.00', 'image': 'https://via.placeholder.com/100x100'},
      {'name': 'Banana', 'price': '\$0.50', 'image': 'https://via.placeholder.com/100x100'},
      {'name': 'Carrot', 'price': '\$0.30', 'image': 'https://via.placeholder.com/100x100'},
    ].where((item) => item['name']!.toLowerCase().contains(query.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$query"'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final product = searchResults[index];
          return ListTile(
            leading: Image.network(product['image']!),
            title: Text(product['name']!),
            subtitle: Text(product['price']!),
            onTap: () {
              // Navigate to product detail page or perform any action on tap
            },
          );
        },
      ),
    );
  }
}
