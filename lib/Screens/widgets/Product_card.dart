import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String unit;
  final String image;
  final VoidCallback onAddToCart;
  final VoidCallback onTap; // Add this

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.unit,
    required this.onAddToCart,
    required this.onTap, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                            child: Image.network(
                              image,
                              height: 85,
                              width: 140,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_outline_outlined),
                              color: Colors.grey.shade700,
                              onPressed: () {
                                // Implement wishlist functionality
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$$price',
                          style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 2,),
                        const Text("|",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(width: 2,),
                        Text(
                          unit,
                          style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onAddToCart,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Center(child: Text('Add to Cart')),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
