abstract class AppAuthenticationStates {}

class AppAuthenticationInitialState extends AppAuthenticationStates {}

class AppAuthenticationLoadingState extends AppAuthenticationStates {}

class AppAuthenticationLoginSuccessState extends AppAuthenticationStates {}

class AppAuthenticationLoginErrorState extends AppAuthenticationStates {
  String error;
  AppAuthenticationLoginErrorState(this.error);
}

class AppAuthenticationRegisterSuccessState extends AppAuthenticationStates {}

class AppAuthenticationRegisterErrorState extends AppAuthenticationStates {
  String error;
  AppAuthenticationRegisterErrorState(this.error);
}

class AppAuthenticationSignOutSuccessState extends AppAuthenticationStates {}

class AppAuthenticationSignOutErrorState extends AppAuthenticationStates {
  String error;
  AppAuthenticationSignOutErrorState(this.error);
}

class AppAuthenticationCreateUserInDatabaseSuccessState
    extends AppAuthenticationStates {}

class AppAuthenticationCreateUserInDatabaseErrorState
    extends AppAuthenticationStates {
  String error;
  AppAuthenticationCreateUserInDatabaseErrorState(this.error);
}

class AppAuthenticationUserChangePasswordSuccessState
    extends AppAuthenticationStates {}

class AppAuthenticationUserChangePasswordErrorState
    extends AppAuthenticationStates {
  String error;
  AppAuthenticationUserChangePasswordErrorState(this.error);
}

class AuthAuthenticationRefreshState extends AppAuthenticationStates {}

class AppAuthenticationLoginWithGoogleLoadingState
    extends AppAuthenticationStates {}

class AppAuthenticationLoginWithGoogleSuccessState
    extends AppAuthenticationStates {}

class AppAuthenticationLoginWithGoogleErrorState
    extends AppAuthenticationStates {
  String error;
  AppAuthenticationLoginWithGoogleErrorState(this.error);
}

class AppAuthenticationLoginWithFacebookSuccessState
    extends AppAuthenticationStates {}

class AppAuthenticationLoginWithFacebookErrorState
    extends AppAuthenticationStates {
  String error;
  AppAuthenticationLoginWithFacebookErrorState(this.error);
}
