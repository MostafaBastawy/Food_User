import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/modules/change_password_screen.dart';
import 'package:food_user_interface/modules/edit_profile_screen.dart';
import 'package:food_user_interface/modules/on_boarding_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/default_drawer.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(end: 40.0),
            child: Center(
              child: Text('Profile'),
            ),
          ),
        ),
        drawer: const DefaultDrawer(),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2.0,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(
                        cubit.userData[0].userProfileImage.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.userData[0].userFullName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text(
                            cubit.userData[0].userEmail.toString(),
                            style: TextStyle(
                              color: Colors.grey[500]!,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          cubit.userData[0].userPhoneNumber.toString(),
                          style: TextStyle(
                            color: Colors.grey[500]!,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                        widget: EditProfileScreen(),
                        context: context,
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey[600],
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock,
                      color: defaultColor,
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.0),
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        navigateTo(
                          widget: ChangePasswordScreen(),
                          context: context,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (cubit.userData[0].userAddress['houseNumber'] != '')
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cubit.userData[0].userAddress['receiverName'] != '')
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10.0),
                            child: Text(
                              cubit.userData[0].userAddress['receiverName']
                                  .toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              cubit.updateDeliveryAddress(
                                receiverName: '',
                                receiverNumber: '',
                                houseNumber: '',
                                area: '',
                                address: '',
                              );
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Colors.grey[600]!,
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10.0),
                      child: Text(
                        '${cubit.userData[0].userAddress['houseNumber'].toString()}, ${cubit.userData[0].userAddress['area'].toString()}, ${cubit.userData[0].userAddress['address'].toString()}',
                        style: TextStyle(
                          color: Colors.grey[500]!,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            BlocConsumer<AppAuthenticationCubit, AppAuthenticationStates>(
              listener: (BuildContext context, state) {
                if (state is AppAuthenticationSignOutSuccessState) {
                  CacheHelper.removeData(key: 'uid');
                  defaultToast(
                    message: 'Sign out successfully',
                    color: Colors.green,
                    context: context,
                  );
                  navigateAndFinish(
                    widget: const OnBoardingScreen(),
                    context: context,
                  );
                }
                if (state is AppAuthenticationSignOutErrorState) {
                  defaultToast(
                    message: state.error.substring(30),
                    color: Colors.red,
                    context: context,
                  );
                }
              },
              builder: (BuildContext context, Object? state) =>
                  ConditionalBuilder(
                condition: state is! AppAuthenticationLoadingState,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: DefaultButton(
                    onPressed: () {
                      AppAuthenticationCubit.get(context).userSignOut();
                    },
                    labelText: 'SIGN OUT',
                    color: defaultColor,
                  ),
                ),
                fallback: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
