import 'package:flutter/material.dart';
import '../models/Meal.dart';
import '../services/ApiService.dart';
import '../widgets/MealCard.dart';
import 'RecipeScreen.dart';

class MealsScreen extends StatefulWidget {
  final String category;
  const MealsScreen({super.key, required this.category});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  ApiService api = ApiService();
  List<Meal> meals = [];
  List<Meal> filtered = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final data = await api.loadMealsByCategory(widget.category);
    setState(() {
      meals = data;
      filtered = data;
    });
  }

  search(String text) async {
    if (text.isEmpty) {
      setState(() => filtered = meals);
      return;
    }

    final data = await api.searchMeals(text);
    setState(() => filtered = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                labelText: "Search meals",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                return MealCard(
                  meal: filtered[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeScreen(id: filtered[i].id),
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
