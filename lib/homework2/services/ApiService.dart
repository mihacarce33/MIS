import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Category.dart';
import '../models/Meal.dart';
import '../models/Recipe.dart';

class ApiService {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Category>> loadCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));

    List<Category> list = [];

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var cat in data["categories"]) {
        list.add(Category.fromJson(cat));
      }
    }

    return list;
  }

  Future<List<Meal>> loadMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse("$baseUrl/filter.php?c=$category"),
    );

    List<Meal> list = [];

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var meal in data["meals"]) {
        list.add(Meal.fromJson(meal));
      }
    }

    return list;
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search.php?s=$query"),
    );

    List<Meal> list = [];

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["meals"] != null) {
        for (var meal in data["meals"]) {
          list.add(Meal.fromJson(meal));
        }
      }
    }

    return list;
  }

  Future<Recipe?> loadRecipeById(String id) async {
    final res = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return Recipe.fromJson(data["meals"][0]);
    }
    return null;
  }

  Future<Recipe?> loadRandomRecipe() async {
    final res = await http.get(Uri.parse("$baseUrl/random.php"));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return Recipe.fromJson(data["meals"][0]);
    }
    return null;
  }
}
