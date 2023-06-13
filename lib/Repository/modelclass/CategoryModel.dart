class CategoryModel {
  List<String>? categories;

  CategoryModel({
    this.categories,
  });

  factory CategoryModel.fromJson(List<dynamic> json) {
    return CategoryModel(
      categories: json.map((category) => category.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories,
    };
  }
}
