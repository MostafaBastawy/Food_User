import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/on_boarding_screen.dart';
import 'package:food_user_interface/shared/components/authentication/authentication_login.dart';
import 'package:food_user_interface/shared/components/authentication/authentication_register.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

class AuthenticationScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool login = true;
  bool register = false;
  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppAuthenticationCubit cubit = AppAuthenticationCubit.get(context);
    return BlocConsumer<AppAuthenticationCubit, AppAuthenticationStates>(
      listener: (BuildContext context, state) {
        if (state is AppAuthenticationLoginSuccessState) {
          defaultToast(
            message: 'Login successfully',
            color: Colors.green,
            context: context,
          );
          CacheHelper.setData(
              key: 'uid', value: FirebaseAuth.instance.currentUser!.uid);
          navigateAndFinish(context: context, widget: const HomeMenu());
          AppCubit.get(context).getUserData();
        }
        if (state is AppAuthenticationLoginErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(
            widget: AuthenticationScreen(),
            context: context,
          );
        }
        if (state is AppAuthenticationRegisterSuccessState) {
          defaultToast(
            message: 'Account has been created successfully',
            color: Colors.green,
            context: context,
          );
          login = true;
          register = false;
          AppAuthenticationCubit.get(context)
              .emit(AuthAuthenticationRefreshState());
        }
        if (state is AppAuthenticationRegisterErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(
            widget: AuthenticationScreen(),
            context: context,
          );
        }
      },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_Image.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: 30.0, top: 40.0),
                        child: Container(
                          padding: const EdgeInsets.all(25.0),
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/cutlery_logo.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: login ? Colors.white : defaultColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  login = true;
                                  register = false;
                                  emailController.text = '';
                                  passwordController.text = '';
                                  fullNameController.text = '';
                                  phoneController.text = '';
                                  cubit.emit(AuthAuthenticationRefreshState());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: login ? defaultColor : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: register ? Colors.white : defaultColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10.0)),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  login = false;
                                  register = true;
                                  emailController.text = '';
                                  passwordController.text = '';
                                  fullNameController.text = '';
                                  phoneController.text = '';
                                  cubit.emit(AuthAuthenticationRefreshState());
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color:
                                        register ? defaultColor : Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (login)
                        LoginAuthentication(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      if (register)
                        RegisterAuthentication(
                          passwordController: passwordController,
                          emailController: emailController,
                          fullNameController: fullNameController,
                          phoneController: phoneController,
                        ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppAuthenticationLoadingState,
                        builder: (BuildContext context) => DefaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (login) {
                                cubit.userLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                              if (register) {
                                cubit.userRegister(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  fullName: fullNameController.text.trim(),
                                  phoneNumber: phoneController.text.trim(),
                                );
                              }
                            }
                          },
                          labelText: login ? 'Login' : 'Register',
                          color: defaultColor,
                        ),
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateAndFinish(
                            widget: const OnBoardingScreen(),
                            context: context,
                          );
                        },
                        child: const Text(
                          'Back to landing page',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
