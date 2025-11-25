class Recipe {
  String id;
  String name;
  String img;
  String instructions;
  String youtube;
  List<Map<String, String>> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.img,
    required this.instructions,
    required this.youtube,
    required this.ingredients,
  });

  Recipe.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        name = data['strMeal'],
        img = data['strMealThumb'],
        instructions = data['strInstructions'] ?? "",
        youtube = data['strYoutube'] ?? "",
        ingredients = List.generate(20, (i) {
          final ing = data['strIngredient${i + 1}']?.toString() ?? "";
          final measure = data['strMeasure${i + 1}']?.toString() ?? "";

          if (ing.isNotEmpty) {
            return {"ingredient": ing, "measure": measure};
          }

          return null;
        })
            .whereType<Map<String, String>>()
            .toList();

}
