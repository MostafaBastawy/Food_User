class CartDataModel {
  String? productImage;
  String? productName;
  int? productPrice;
  int? productQuantity;
  int? productTotalPrice;

  CartDataModel(
    this.productImage,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.productTotalPrice,
  );

  CartDataModel.fromJson(Map<String, dynamic> json) {
    productImage = json['productImage'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productQuantity = json['productQuantity'];
    productTotalPrice = json['productTotalPrice'];
  }
  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
    };
  }
}
