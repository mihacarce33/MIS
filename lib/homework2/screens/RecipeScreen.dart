import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Recipe.dart';
import '../services/ApiService.dart';
import '../widgets/IngredientRow.dart';

class RecipeScreen extends StatefulWidget {
  final String id;

  RecipeScreen({required this.id});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  ApiService api = ApiService();
  Recipe? recipe;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final r = await api.loadRecipeById(widget.id);
    setState(() => recipe = r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe")),
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
            SizedBox(height: 20),
            if (recipe!.youtube.isNotEmpty)
              TextButton(
                child: Text("Watch on YouTube"),
                onPressed: () async {
                  try {
                    final url = Uri.parse(recipe!.youtube);
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } catch (e) {
                    print('Could not launch URL: $e');
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
