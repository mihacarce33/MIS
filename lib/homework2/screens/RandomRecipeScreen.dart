import 'package:flutter/material.dart';
import '../models/Recipe.dart';
import '../services/ApiService.dart';
import '../widgets/IngredientRow.dart';

class RandomRecipeScreen extends StatefulWidget {
  @override
  _RandomRecipeScreenState createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  ApiService api = ApiService();
  Recipe? recipe;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final r = await api.loadRandomRecipe();
    setState(() => recipe = r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Recipe")),
      body: recipe == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe!.img),
            SizedBox(height: 10),
            Text(
              recipe!.name,
              style:
              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Ingredients:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ...recipe!.ingredients.map((e) => IngredientRow(
              ingredient: e["ingredient"]!,
              measure: e["measure"]!,
            )),
            SizedBox(height: 20),
            Text("Instructions:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(recipe!.instructions),
          ],
        ),
      ),
    );
  }
}
