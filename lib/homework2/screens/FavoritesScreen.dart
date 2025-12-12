import 'package:flutter/material.dart';
import '../services/FavoritesService.dart';
import '../widgets/MealCard.dart';
import 'RecipeScreen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favs = FavoritesService().favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Recipes")),
      body: favs.isEmpty
          ? Center(child: Text("No favorite recipes yet"))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: favs.length,
        itemBuilder: (_, i) {
          return MealCard(
            meal: favs[i],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeScreen(id: favs[i].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
