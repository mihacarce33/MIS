import 'package:flutter/material.dart';
import '../models/Category.dart';
import '../services/ApiService.dart';
import '../widgets/CategoryCard.dart';
import 'MealsScreen.dart';
import 'RandomRecipeScreen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  ApiService api = ApiService();
  List<Category> categories = [];
  List<Category> filtered = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final data = await api.loadCategories();
    setState(() {
      categories = data;
      filtered = data;
    });
  }

  void search(String text) {
    setState(() {
      filtered = categories
          .where((c) => c.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RandomRecipeScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                labelText: "Search categories",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: categories.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                return CategoryCard(
                  item: filtered[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MealsScreen(category: filtered[i].name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
