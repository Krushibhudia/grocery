import 'package:flutter/material.dart';

import '../checkout_screen.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  bool _isGridView = true;

  final List<Map<String, String?>> cartItems = [
    {'name': 'Apple', 'price': '1.00', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Apple'},
    {'name': 'Banana', 'price': '0.50', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Banana'},
    {'name': 'Carrot', 'price': '0.30', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Carrot'},
    {'name': 'Milk', 'price': '1.20', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Milk'},
    {'name': 'Spoon', 'price': '0.30', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Spoon'},
    {'name': 'Chevdo', 'price': '1.20', 'quantity': '1', 'image': 'https://via.placeholder.com/100x100?text=Chevdo'}
  ];

  @override
  Widget build(BuildContext context) {
    final double totalPrice = cartItems.fold(
      0.0,
          (sum, item) {
        final price = double.tryParse(item['price'] ?? '0') ?? 0.0;
        final quantity = double.tryParse(item['quantity'] ?? '0') ?? 0.0;
        return sum + (price * quantity);
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(_isGridView ? Icons.list : Icons.grid_on),
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isGridView ? _buildGridView() : _buildListView(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: cartItems)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Proceed to Checkout', style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            )],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        final price = double.tryParse(item['price'] ?? '0') ?? 0.0;
        final quantity = double.tryParse(item['quantity'] ?? '0') ?? 0.0;
        final image = item['image'] ?? '';

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              )
                  : const SizedBox(height: 120),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? 'Unnamed Item',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${price.toStringAsFixed(2)} x ${quantity.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        final price = double.tryParse(item['price'] ?? '0') ?? 0.0;
        final quantity = double.tryParse(item['quantity'] ?? '0') ?? 0.0;
        final image = item['image'] ?? '';

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? 'Unnamed Item',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${price.toStringAsFixed(2)} x ${quantity.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                image.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
                    : const SizedBox(height: 60),
              ],
            ),
          ),
        );
      },
    );
  }
}
