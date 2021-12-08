class CategoryDataModel {
  String? categoryName;
  String? imageUrl;

  CategoryDataModel(
    this.categoryName,
    this.imageUrl,
  );

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    {
      categoryName = json['categoryName'];
      imageUrl = json['imageUrl'];
    }
  }
}
