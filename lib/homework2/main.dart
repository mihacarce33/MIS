import 'package:exam_scheduler/homework2/screens/CategoriesScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      home: CategoriesScreen(),
    );
  }
}
