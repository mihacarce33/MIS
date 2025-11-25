class Category {
  String name;
  String img;
  String description;

  Category({
    required this.name,
    required this.img,
    required this.description,
  });

  Category.fromJson(Map<String, dynamic> data)
      : name = data['strCategory'],
        img = data['strCategoryThumb'],
        description = data['strCategoryDescription'];
}
