import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {'orderId': '1234', 'status': 'Delivered', 'date': '2024-07-20'},
    {'orderId': '5678', 'status': 'Shipped', 'date': '2024-07-18'},
    {'orderId': '9101', 'status': 'Pending', 'date': '2024-07-15'},
    {'orderId': '1121', 'status': 'Delivered', 'date': '2024-07-10'},
  ];

  OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with 'Browse by Category' and search/sort icons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Implement search functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: () {
                          // Implement sort functionality
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Orders List
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        'Order #${order['orderId']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: ${order['status']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: ${order['date']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Navigate to order details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(orderId: order['orderId']!),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Replace with actual order details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: $orderId',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Item 1: Product Name - \$Price',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Item 2: Product Name - \$Price',
              style: TextStyle(fontSize: 18),
            ),
            // Add more items here
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement re-order or other actions
              },
              child: const Text('Re-Order'),
            ),
          ],
        ),
      ),
    );
  }
}
