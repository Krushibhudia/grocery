import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/Product_card.dart';


class ProductDetailPage extends StatefulWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  final GlobalKey _reviewsKey = GlobalKey();

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _scrollToReviews() {
    Scrollable.ensureVisible(
      _reviewsKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _shareProduct() {
    Share.share('Check out this product: ${widget.name} for ₹${widget.price}. ${widget.image}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareProduct,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        onPressed: () {
                          // Handle add to wishlist
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.grey.shade700,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _decrementQuantity,
                                icon: const Icon(Icons.remove),
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                onPressed: _incrementQuantity,
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '₹${widget.price}',
                            style: const TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          const SizedBox(width: 2,),
                          const Text(
                            '|',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 2,),
                          const Text(
                            '1 kg',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: _scrollToReviews,
                            child: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 2),
                      // Stock availability
                      const Text(
                        'In Stock',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      const SizedBox(height: 2),
                      // Discounts and Offers
                      const Text(
                        'Discount: 10% off',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Offers: Buy 1 Get 1 Free',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      const SizedBox(height: 20),
                      // Static data for additional details
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand: Example Brand',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'This is an example product description. It provides detailed information about the product.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Return and Exchange Policy
                      const Text(
                        'Return and Exchange Policy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'We offer a 30-day return and exchange policy for all products. To be eligible for a return or exchange, items must be unused, in their original packaging, and accompanied by a receipt or proof of purchase.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Similar Products:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ProductCard(
                              name: 'Similar Product 1',
                              price: '200',
                              image: 'https://via.placeholder.com/100',
                              unit: '',
                              onAddToCart: () {},
                              onTap: () {},
                            ),
                            ProductCard(
                              name: 'Similar Product 2',
                              price: '250',
                              image: 'https://via.placeholder.com/100',
                              unit: '',
                              onAddToCart: () {},
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Frequently Bought Together:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ProductCard(
                              name: 'Frequently Bought Product 1',
                              price: '150',
                              image: 'https://via.placeholder.com/100',
                              unit: '',
                              onAddToCart: () {},
                              onTap: () {},
                            ),
                            ProductCard(
                              name: 'Frequently Bought Product 2',
                              price: '300',
                              image: 'https://via.placeholder.com/100',
                              unit: '',
                              onAddToCart: () {},
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Customer Reviews:',
                        key: _reviewsKey,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: List.generate(3, (index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Customer Name $index',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // Handle rating update
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('This is a review text for the product. It provides detailed feedback about the product.'),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Extra space for bottom button
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle add to cart
                },
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                label: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
