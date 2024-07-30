import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  // Add data to the database
  Future<void> addProduct(String category, Map<String, dynamic> productData) async {
    try {
      await _databaseReference.child('grocery').child('products').child(category).push().set(productData);
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  // Fetch data from the database
  Stream<DatabaseEvent> fetchProducts(String category) {
    return _databaseReference.child('grocery').child('products').child(category).onValue;
  }
}
