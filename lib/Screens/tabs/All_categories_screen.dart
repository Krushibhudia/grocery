  import 'package:flutter/material.dart';
  import 'package:firebase_database/firebase_database.dart';

  import '../products/ProductList_screen.dart';

  class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

    @override
    _CategoriesTabState createState() => _CategoriesTabState();
  }

  class _CategoriesTabState extends State<CategoriesTab> {
    final DatabaseReference _database = FirebaseDatabase.instance.ref().child('grocery/categories');
    List<Map<String, String>> _categories = [];
    bool _isLoading = true;

    @override
    void initState() {
      super.initState();
      _fetchCategories();
    }

    Future<void> _fetchCategories() async {
      try {
        final snapshot = await _database.get();
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
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Browse by Category',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                  categoryName: _categories[index]['name']!,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      _categories[index]['image']!,
                                      height: 160,
                                      width: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      _categories[index]['name']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
