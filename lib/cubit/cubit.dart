import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/category_model.dart';
import 'package:food_user_interface/models/order_model.dart';
import 'package:food_user_interface/models/product_model.dart';
import 'package:food_user_interface/models/user_model.dart';
import 'package:food_user_interface/shared/components/dio_helper/dio_helper.dart';
import 'package:food_user_interface/shared/components/dio_helper/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> categoryProductSize = [];

  List<String> orderType = ["Delivery", "Pick-up (in 30 minutes)"];
  List<String> paymentMethod = ["Visa Debit Card", "Cash on Delivery"];
  int deliveryFees = 15;
  int? totalPayment;
  List<CategoryDataModel> categories = [];

  void getCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((event) {
      categories = [];
      for (var element in event.docs) {
        categories.add(CategoryDataModel.fromJson(element.data()));
      }
      emit(AppGetCategoriesSuccessState());
    });
  }

  List<ProductDataModel> categoryProducts = [];

  void getCategoryProducts({
    required String productCategory,
  }) {
    emit(AppGetCategoryProductsLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .where("productCategory", isEqualTo: productCategory)
        .snapshots()
        .listen((event) {
      categoryProducts = [];

      for (var element in event.docs) {
        categoryProducts.add(ProductDataModel.fromJson(element.data()));
      }
      emit(AppGetCategoryProductsSuccessState());
    });
  }

  List<UserDataModel> userData = [];

  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      userData = [];
      userCart = [];
      userData.add(UserDataModel.fromJson(event.data()!));
      for (var element in userData[0].userCart) {
        userCart.add(element.toMap());
      }

      emit(AppGetUserDataSuccessState());
    });
  }

  List userCart = [];

  void addToCart() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userCart': userCart}).then((value) {
      emit(AppAddToCartSuccessState());
    }).catchError((error) {
      emit(AppAddToCartErrorState(error.toString()));
    });
  }

  void removeFromCart() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userCart': userCart}).then((value) {
      emit(AppRemoveFromCartSuccessState());
    }).catchError((error) {
      emit(AppRemoveFromCartErrorState(error.toString()));
    });
  }

  void updateUserCartTotal({required int total}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userCartTotal': total}).then((value) {
      emit(AppUpdateUserCartTotalSuccessState());
    }).catchError((error) {
      emit(AppUpdateUserCartTotalErrorState(error.toString()));
    });
  }

  void updateDeliveryAddress({
    required String receiverName,
    required String receiverNumber,
    required String houseNumber,
    required String area,
    required String address,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'userAddress': {
        'receiverName': receiverName,
        'receiverNumber': receiverNumber,
        'houseNumber': houseNumber,
        'area': area,
        'address': address,
      }
    }).then((value) {
      emit(AppUpdateUserAddressSuccessState());
    }).catchError((error) {
      emit(AppUpdateUserAddressErrorState(error.toString()));
    });
  }

  void userPurchaseOrder({
    required String orderReceiverNumber,
    required String orderReceiverName,
    required String orderTotalValue,
    required String orderPaymentMethod,
    required String orderType,
    required String orderReceiverAddress,
    required String orderPaymentId,
  }) {
    emit(AppUserPurchaseOrderLoadingState());
    FirebaseFirestore.instance.collection('orders').doc().set({
      'orderReceiverNumber': orderReceiverNumber,
      'orderNumber': 1,
      'orderReceiverEmail': userData[0].userEmail,
      'orderReceiverName': orderReceiverName,
      'orderStatus': 'Pending',
      'orderTotalValue': orderTotalValue,
      'orderUserUid': FirebaseAuth.instance.currentUser!.uid,
      'orderPaymentMethod': orderPaymentMethod,
      'orderCreateAt': Timestamp.fromDate(DateTime.now()).toString(),
      'orderDateTime': DateFormat.yMMMMd().add_Hms().format(DateTime.now()),
      'orderType': orderType,
      'orderProducts': userCart,
      'orderReceiverAddress': orderReceiverAddress,
      'orderPaymentId': orderPaymentId,
    }).then((value) {
      emit(AppUserPurchaseOrderSuccessState());
    }).catchError((error) {
      emit(AppUserPurchaseOrderErrorState(error.toString()));
    });
  }

  List<OrderDataModel> userOrders = [];
  List<OrderDataModel> ongoingOrders = [];
  List<OrderDataModel> pastOrders = [];

  void getUserOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .where("orderUserUid",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('orderCreateAt', descending: true)
        .snapshots()
        .listen((event) {
      userOrders = [];
      ongoingOrders = [];
      pastOrders = [];
      for (var element in event.docs) {
        userOrders.add(OrderDataModel.fromJson(element.data()));
      }
      emit(AppGetUserOrdersSuccessState());
    });
  }

  void userDataUpdate({
    required String userFullName,
    required String userPhoneNumber,
    required String userProfileImage,
  }) {
    emit(AppUserDataUpdateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'userFullName': userFullName,
      'userPhoneNumber': userPhoneNumber,
      'userProfileImage': userProfileImage,
    }).then((value) {
      emit(AppUserDataUpdateSuccessState());
    }).catchError((error) {
      emit(AppUserDataUpdateErrorState(error.toString()));
    });
  }

  Map<String, dynamic> paymentIntent = {};
  void makePaymentIntent() {
    DioHelper.postData(
      url: paymentIntentUrl,
      data: {
        'amount': (totalPayment! * 100).toString(),
        'currency': 'USD',
        'payment_method_types[]': 'card',
      },
    ).then((value) {
      paymentIntent = value.data;
      makePayment();
      emit(AppMakePaymentIntentSuccessState());
    }).catchError((error) {
      emit(AppMakePaymentIntentErrorState(error.toString()));
      print(error);
    });
  }

  void makePayment() async {
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Mostafa',
          customerId: paymentIntent['id'],
          paymentIntentClientSecret: paymentIntent['client_secret'],
        ))
        .then((value) {});
    await Stripe.instance.presentPaymentSheet().then((value) {
      emit(AppMakePaymentSuccessState());
    }).catchError((error) {
      emit(AppMakePaymentErrorState(error.toString()));
    });
  }

  File? profileImage;
  String profileImageUrl = '';
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppPickProfileImageSuccessState());
      uploadProfileImage();
    } else {
      emit(AppPickProfileImageErrorState());
    }
  }

  void uploadProfileImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profileImage.jpg')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
        }).catchError((error) {
          emit(AppUploadProfileImageErrorState(error.toString()));
        });
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState(error.toString()));
      });
    }
  }
}
