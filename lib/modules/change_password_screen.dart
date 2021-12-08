import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/modules/profile_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppAuthenticationCubit cubit = AppAuthenticationCubit.get(context);
    return BlocConsumer<AppAuthenticationCubit, AppAuthenticationStates>(
      listener: (BuildContext context, state) {
        if (state is AppAuthenticationUserChangePasswordSuccessState) {
          defaultToast(
            message: 'Password changed successfully',
            color: Colors.green,
            context: context,
          );

          navigateAndFinish(context: context, widget: const ProfileScreen());
        }
        if (state is AppAuthenticationUserChangePasswordErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(
            widget: const ProfileScreen(),
            context: context,
          );
        }
      },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(end: 40.0),
            child: Center(
              child: Text('Change Password'),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    ),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: oldPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '  Required*';
                      }
                      if (value !=
                          AppCubit.get(context).userData[0].userPassword) {
                        return '  Password is incorrect';
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Old Password',
                      floatingLabelStyle: TextStyle(color: defaultColor),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: defaultColor,
                      ),
                    ),
                    onTap: () {},
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '  Required*';
                        }
                        String pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        if (!RegExp(pattern).hasMatch(value)) {
                          return '  6 Characters & 1 UpperCase & 1 Special Character';
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New Password',
                        floatingLabelStyle: TextStyle(color: defaultColor),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: defaultColor,
                        ),
                      ),
                      onTap: () {},
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    ),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '  Required*';
                      }
                      if (value != newPasswordController.text) {
                        return '  your confirm password is incorrect';
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      floatingLabelStyle: TextStyle(color: defaultColor),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: defaultColor,
                      ),
                    ),
                    onTap: () {},
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                ),
                const Spacer(),
                ConditionalBuilder(
                  condition: state is! AppAuthenticationLoadingState,
                  builder: (BuildContext context) => DefaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userChangePassword(
                          newUserPassword: confirmPasswordController.text,
                        );
                      }
                    },
                    labelText: 'Save Password',
                    color: defaultColor,
                  ),
                  fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
