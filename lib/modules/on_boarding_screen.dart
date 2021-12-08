import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_screen.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAuthenticationCubit, AppAuthenticationStates>(
      listener: (BuildContext context, state) {
        if (state is AppAuthenticationLoginWithGoogleSuccessState) {
          defaultToast(
            message: 'Login successfully',
            color: Colors.green,
            context: context,
          );
          CacheHelper.setData(
              key: 'uid', value: FirebaseAuth.instance.currentUser!.uid);
          navigateAndFinish(context: context, widget: const HomeMenu());
          AppCubit.get(context).getUserData();
          if (AppCubit.get(context).userData.isEmpty) {
            AppAuthenticationCubit.get(context).createUserInDatabase(
              fullName:
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
              phoneNumber:
                  FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              password: '',
            );
          }
        }
        if (state is AppAuthenticationLoginWithGoogleErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(
            widget: const OnBoardingScreen(),
            context: context,
          );
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_Image.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 50.0, top: 40.0),
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
                          //fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    decoration: BoxDecoration(
                      color: const Color(0xAFECEDED).withOpacity(0.5),
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(700.0),
                        topEnd: Radius.circular(700.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DefaultButton(
                          onPressed: () {
                            AppAuthenticationCubit.get(context).userSignOut();
                          },
                          labelText: 'Login Via Facebook',
                          color: facebookColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DefaultButton(
                            onPressed: () {
                              AppAuthenticationCubit.get(context)
                                  .loginWithGoogle();
                            },
                            labelText: 'Login Via Google',
                            color: googleColor,
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! AppAuthenticationLoadingState,
                          builder: (BuildContext context) => Padding(
                            padding:
                                const EdgeInsetsDirectional.only(bottom: 10.0),
                            child: DefaultButton(
                              onPressed: () {
                                navigateAndFinish(
                                  widget: AuthenticationScreen(),
                                  context: context,
                                );
                              },
                              labelText: 'Login Via Email-ID',
                              color: defaultColor,
                            ),
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account! ',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  widget: AuthenticationScreen(),
                                  context: context,
                                );
                              },
                              child: const Text(
                                'Register?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
