import 'package:food_user_interface/models/cart_model.dart';

class OrderDataModel {
  int? orderNumber;
  String? orderReceiverEmail;
  String? orderReceiverAddress;
  String? orderReceiverNumber;
  String? orderReceiverName;
  String? orderStatus;
  String? orderTotalValue;
  String? orderUserUid;
  String? orderPaymentMethod;
  String? orderCreateAt;
  String? orderDateTime;
  String? orderType;
  String? orderPaymentId;
  List<CartDataModel> orderProducts = [];

  OrderDataModel(
    this.orderNumber,
    this.orderReceiverEmail,
    this.orderReceiverAddress,
    this.orderReceiverNumber,
    this.orderReceiverName,
    this.orderStatus,
    this.orderTotalValue,
    this.orderUserUid,
    this.orderPaymentMethod,
    this.orderCreateAt,
    this.orderDateTime,
    this.orderType,
    this.orderPaymentId,
    this.orderProducts,
  );
  OrderDataModel.fromJson(Map<String, dynamic> json) {
    orderNumber = json['orderNumber'];
    orderReceiverEmail = json['orderReceiverEmail'];
    orderReceiverAddress = json['orderReceiverAddress'];
    orderReceiverNumber = json['orderReceiverNumber'];
    orderReceiverName = json['orderReceiverName'];
    orderStatus = json['orderStatus'];
    orderTotalValue = json['orderTotalValue'];
    orderUserUid = json['orderUserUid'];
    orderPaymentMethod = json['orderPaymentMethod'];
    orderCreateAt = json['orderCreateAt'];
    orderDateTime = json['orderDateTime'];
    orderType = json['orderType'];
    orderPaymentId = json['orderPaymentId'];
    json['orderProducts'].forEach((element) {
      orderProducts.add(CartDataModel.fromJson(element));
    });
  }
}
