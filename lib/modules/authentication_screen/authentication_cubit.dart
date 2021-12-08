import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/shared/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppAuthenticationCubit extends Cubit<AppAuthenticationStates> {
  AppAuthenticationCubit() : super(AppAuthenticationInitialState());
  static AppAuthenticationCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppAuthenticationLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(AppAuthenticationLoginSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationLoginErrorState(error.toString()));
    });
  }

  void userSignOut() {
    emit(AppAuthenticationLoadingState());
    _googleSignIn.signOut();
    FirebaseAuth.instance.signOut().then((value) {
      emit(AppAuthenticationSignOutSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationSignOutErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) {
    emit(AppAuthenticationLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(AppAuthenticationRegisterSuccessState());
      createUserInDatabase(
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
    }).catchError((error) {
      emit(AppAuthenticationRegisterErrorState(error.toString()));
    });
  }

  void createUserInDatabase({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'userFullName': fullName,
      'userPhoneNumber': phoneNumber,
      'userEmail': email,
      'UserUid': FirebaseAuth.instance.currentUser!.uid,
      'userProfileImage': defaultProfileImage,
      'userCart': [],
      'userCartTotal': 0,
      'userPassword': password,
      'userAddress': {
        'receiverName': '',
        'receiverNumber': '',
        'houseNumber': '',
        'area': '',
        'address': '',
      }
    }).then((value) {
      emit(AppAuthenticationCreateUserInDatabaseSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationCreateUserInDatabaseErrorState(error.toString()));
    });
  }

  void userChangePassword({required String newUserPassword}) {
    emit(AppAuthenticationLoadingState());
    FirebaseAuth.instance.currentUser!
        .updatePassword(newUserPassword)
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'userPassword': newUserPassword}).then((value) {
        emit(AppAuthenticationUserChangePasswordSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(AppAuthenticationUserChangePasswordErrorState(error.toString()));
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void loginWithGoogle() async {
    emit(AppAuthenticationLoginWithGoogleLoadingState());

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(AppAuthenticationLoginWithGoogleSuccessState());
    }).catchError((error) {
      emit(AppAuthenticationLoginWithGoogleErrorState(error.toString()));
    });
  }
}
