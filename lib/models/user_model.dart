import 'package:food_user_interface/models/cart_model.dart';

class UserDataModel {
  String? userFullName;
  String? userEmail;
  String? userPhoneNumber;
  String? userProfileImage;
  String? userUid;
  List<CartDataModel> userCart = [];
  int? userCartTotal;
  Map<String, dynamic> userAddress = {};
  String? userPassword;

  UserDataModel(
    this.userFullName,
    this.userEmail,
    this.userPhoneNumber,
    this.userProfileImage,
    this.userUid,
    this.userCart,
    this.userCartTotal,
    this.userAddress,
    this.userPassword,
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    {
      userFullName = json['userFullName'];
      userEmail = json['userEmail'];
      userPhoneNumber = json['userPhoneNumber'];
      userProfileImage = json['userProfileImage'];
      userUid = json['userUid'];
      json['userCart'].forEach((element) {
        userCart.add(CartDataModel.fromJson(element));
      });
      userCartTotal = json['userCartTotal'];
      userAddress = json['userAddress'];
      userPassword = json['userPassword'];
    }
  }
}
