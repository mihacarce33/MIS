import 'package:flutter/material.dart';
import '../models/Meal.dart';
import '../services/FavoritesService.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    final favService = FavoritesService();
    final isFav = favService.isFavorite(widget.meal);

    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(widget.meal.img, fit: BoxFit.cover),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {});
                      favService.toggleFavorite(widget.meal);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            widget.meal.name,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
