abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppRefreshState extends AppStates {}

class AppGetCategoriesSuccessState extends AppStates {}

class AppGetProductsSuccessState extends AppStates {}

class AppGetCategoryProductsLoadingState extends AppStates {}

class AppGetCategoryProductsSuccessState extends AppStates {}

class AppDropDownButtonRefreshState extends AppStates {}

class AppRadioGroupButtonRefreshState extends AppStates {}

class AppOrderScreenRefreshState extends AppStates {}

class AppGetUserDataSuccessState extends AppStates {}

class AppAddToCartSuccessState extends AppStates {}

class AppAddToCartErrorState extends AppStates {
  final String error;
  AppAddToCartErrorState(this.error);
}

class AppRemoveFromCartSuccessState extends AppStates {}

class AppRemoveFromCartErrorState extends AppStates {
  final String error;
  AppRemoveFromCartErrorState(this.error);
}

class AppUpdateUserCartTotalSuccessState extends AppStates {}

class AppUpdateUserCartTotalErrorState extends AppStates {
  final String error;
  AppUpdateUserCartTotalErrorState(this.error);
}

class AppUpdateUserAddressSuccessState extends AppStates {}

class AppUpdateUserAddressErrorState extends AppStates {
  final String error;
  AppUpdateUserAddressErrorState(this.error);
}

class AppUserPurchaseOrderLoadingState extends AppStates {}

class AppUserPurchaseOrderSuccessState extends AppStates {}

class AppUserPurchaseOrderErrorState extends AppStates {
  final String error;
  AppUserPurchaseOrderErrorState(this.error);
}

class AppGetUserOrdersSuccessState extends AppStates {}

class AppUserDataUpdateLoadingState extends AppStates {}

class AppUserDataUpdateSuccessState extends AppStates {}

class AppUserDataUpdateErrorState extends AppStates {
  final String error;
  AppUserDataUpdateErrorState(this.error);
}

class AppMakePaymentIntentSuccessState extends AppStates {}

class AppMakePaymentIntentErrorState extends AppStates {
  final String error;
  AppMakePaymentIntentErrorState(this.error);
}

class AppMakePaymentSuccessState extends AppStates {}

class AppMakePaymentErrorState extends AppStates {
  final String error;
  AppMakePaymentErrorState(this.error);
}

class AppPickProfileImageSuccessState extends AppStates {}

class AppPickProfileImageErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {
  final String error;
  AppUploadProfileImageErrorState(this.error);
}
