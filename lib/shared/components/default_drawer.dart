import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/my_orders_screen.dart';
import 'package:food_user_interface/modules/on_boarding_screen.dart';
import 'package:food_user_interface/modules/profile_screen.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                navigateAndFinish(
                  widget: const ProfileScreen(),
                  context: context,
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 40.0, bottom: 10.0),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(AppCubit.get(context)
                          .userData[0]
                          .userProfileImage
                          .toString()),
                    ),
                  ),
                  Text(
                    AppCubit.get(context).userData[0].userFullName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20.0),
              child: Container(
                color: Colors.grey[300],
                height: 2.0,
                width: double.infinity,
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateAndFinish(widget: const HomeMenu(), context: context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/images/menu-icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 20.0),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateAndFinish(widget: MyOrdersScreen(), context: context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/images/myorders-icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 20.0),
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/images/offers-icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 20.0),
                      child: Text(
                        'Offers',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/images/support-icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 20.0),
                      child: Text(
                        'Support',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'assets/images/settings-icon.png',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 20.0),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
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
                  navigateTo(
                    widget: const HomeMenu(),
                    context: context,
                  );
                }
              },
              builder: (BuildContext context, Object? state) {
                return ConditionalBuilder(
                  condition: state is! AppAuthenticationLoadingState,
                  builder: (BuildContext context) => Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 20.0, start: 20.0, end: 20.0),
                    child: Container(
                      height: 40.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          AppAuthenticationCubit.get(context).userSignOut();
                        },
                        child: const Text(
                          'sign out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
