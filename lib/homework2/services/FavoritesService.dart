import '../models/Meal.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;

  FavoritesService._internal();

  final List<Meal> favorites = [];

  bool isFavorite(Meal meal) {
    return favorites.any((m) => m.id == meal.id);
  }

  void toggleFavorite(Meal meal) {
    if (isFavorite(meal)) {
      favorites.removeWhere((m) => m.id == meal.id);
    } else {
      favorites.add(meal);
    }
  }
}
