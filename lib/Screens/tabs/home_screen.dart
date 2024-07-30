import 'package:grocery/screens/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grocery/screens/search_result_screen.dart';
import 'package:grocery/screens/wishlist_screen.dart';

import '../products/ProductList_screen.dart';
import '../products/Product_Detail_Page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> bannerImages = [];
  bool _isLoadingBanners = true;
  List<Map<String, String>> _categories = [];
  bool _isLoadingCategories = true;
  List<Map<String, dynamic>> featuredProducts = [];
  List<Map<String, dynamic>> deals = [];
  List<Map<String, dynamic>> recommendations = [];
  bool _isLoadingProducts = true;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onFocusChange);
    _fetchCategories();
    _fetchBannerImages();
    _fetchProducts();
  }

  void _onSearchChanged() {
    setState(() {
      _suggestions = _getSuggestions(_searchController.text);
    });
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus) {
      setState(() {
        _suggestions = [];
      });
    }
  }

  List<String> _getSuggestions(String query) {
    List<String> allSuggestions = ['Apple', 'Banana', 'Carrot', 'Milk', 'Orange', 'Soda'];
    return allSuggestions.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void _onSuggestionTap(String suggestion) {
    _searchController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(query: suggestion),
      ),
    );
  }

  void _onSearchSubmit(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(query: query),
      ),
    );
  }

  Future<void> _fetchBannerImages() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref().child('grocery/banners');
    try {
      final snapshot = await database.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        List<String> images = [];
        data.forEach((key, value) {
          images.add(value['imageUrl'] as String);
        });
        setState(() {
          bannerImages = images;
          _isLoadingBanners = false;
        });
        print('Banner Images: $bannerImages');
      } else {
        setState(() {
          _isLoadingBanners = false;
        });
        print('No banner images found');
      }
    } catch (e) {
      print('Error fetching banner images: $e');
      setState(() {
        _isLoadingBanners = false;
      });
    }
  }

  Future<void> _fetchCategories() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref().child('grocery/categories');
    try {
      final snapshot = await database.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, String>> categories = [];
        data.forEach((key, value) {
          categories.add({
            'name': value['name'] as String,
            'image': value['image'] as String,
          });
        });
        setState(() {
          _categories = categories;
          _isLoadingCategories = false;
        });
        print('Categories: $_categories');
      } else {
        setState(() {
          _isLoadingCategories = false;
        });
        print('No categories found');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _fetchProducts() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref().child('grocery/products');
    try {
      final snapshot = await database.get();
      if (snapshot.exists) {
        print('Snapshot value: ${snapshot.value}');
        List<Map<String, dynamic>> allProducts = [];

        // Check if the snapshot value is a List
        if (snapshot.value is List<dynamic>) {
          final data = snapshot.value as List<dynamic>;
          for (var value in data) {
            if (value != null && value is Map) {
              allProducts.add({
                'name': value['name'] as String? ?? 'Unknown',
                'price': value['price'].toString(), // Ensure price is a string
                'image': value['image'] as String? ?? '',
                'unit': value['unit'] as String? ?? '',
                'isFeatured': value['isFeatured'] as bool? ?? false,
                'isDeal': value['isDeal'] as bool? ?? false,
                'isRecommended': value['isRecommended'] as bool? ?? false,
              });
            }
          }

          setState(() {
            featuredProducts = allProducts.where((product) => product['isFeatured'] == true).toList();
            deals = allProducts.where((product) => product['isDeal'] == true).toList();
            recommendations = allProducts.where((product) => product['isRecommended'] == true).toList();
            _isLoadingProducts = false;
          });

          print('Featured Products: $featuredProducts');
          print('Deals: $deals');
          print('Recommendations: $recommendations');
        } else {
          print('Unexpected data structure: ${snapshot.value}');
          setState(() {
            _isLoadingProducts = false;
          });
        }
      } else {
        print('No products found');
        setState(() {
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoadingProducts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen...');
    print('Featured Products in build: $featuredProducts');
    print('Deals in build: $deals');
    print('Recommendations in build: $recommendations');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn4.iconfinder.com/data/icons/green-shopper/1068/user.png'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Krushi Bhudia',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text('New York, NY', style: TextStyle(color: Colors.black, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishlistScreen()),
                  );
                },
                icon: const Icon(Icons.favorite_border, size: 20, color: Colors.black),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search products',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: _onSearchSubmit,
                  ),
                  if (_suggestions.isNotEmpty) ...[
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: _suggestions.map((suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                            onTap: () => _onSuggestionTap(suggestion),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section
              _isLoadingCategories
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: 115,
                child: ListView.builder(
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(
                              categoryName: category['name']!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(category['image']!),
                              radius: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name']!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Banners Section
              _isLoadingBanners
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: 200,
                child: PageView(
                  children: bannerImages.map((url) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Featured Products Section
              _isLoadingProducts
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: _buildProductSection('Featured Products', featuredProducts)),
              // Deals Section
              _isLoadingProducts
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: _buildProductSection('Deals', deals)),
              // Recommendations Section
              _isLoadingProducts
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: _buildProductSection('Recommendations', recommendations)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection(String title, List<Map<String, dynamic>> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                name: product['name']??'unknown',
                price: product['price']??'0.0',
                image: product['image']?? '',
                unit: product['unit']?? '',
                onAddToCart: () {
                  // Implement add to cart functionality
                },
                onTap: () {
                  // Navigate to ProductDetailPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        name: product['name']!,
                        price: product['price']!,
                        image: product['image']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
