class ProductDataModel {
  String? productImage;
  String? productName;
  String? productRecipe;
  String? productCategory;
  int? productSmallSizePrice;
  int? productMediumSizePrice;
  int? productLargeSizePrice;

  ProductDataModel(
    this.productImage,
    this.productName,
    this.productRecipe,
    this.productCategory,
    this.productSmallSizePrice,
    this.productMediumSizePrice,
    this.productLargeSizePrice,
  );

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    {
      productImage = json['productImage'];
      productName = json['productName'];
      productRecipe = json['productRecipe'];
      productCategory = json['productCategory'];
      productSmallSizePrice = json['productSmallSizePrice'];
      productMediumSizePrice = json['productMediumSizePrice'];
      productLargeSizePrice = json['productLargeSizePrice'];
    }
  }
}
