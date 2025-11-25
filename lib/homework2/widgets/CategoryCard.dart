import 'package:flutter/material.dart';
import '../models/Category.dart';

class CategoryCard extends StatelessWidget {
  final Category item;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.network(item.img, height: 120, fit: BoxFit.cover),
            SizedBox(height: 8),
            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
