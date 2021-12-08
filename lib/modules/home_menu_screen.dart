import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/cart_screen.dart';
import 'package:food_user_interface/modules/products_screen.dart';
import 'package:food_user_interface/shared/components/default_drawer.dart';
import 'package:food_user_interface/shared/components/default_menu_bottom.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getUserData();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Menu'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                navigateAndFinish(
                  widget: const CartScreen(),
                  context: context,
                );
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 20.0),
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: Image.asset(
                    'assets/images/shopping-bag.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: const DefaultDrawer(),
        body: ConditionalBuilder(
          condition: cubit.categories.isNotEmpty,
          builder: (BuildContext context) => Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  navigateTo(
                      widget: ProductsScreen(
                        categoryDataModel: cubit.categories[index],
                      ),
                      context: context);
                },
                child: DefaultMenuBottom(
                  index: index,
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10.0,
              ),
              itemCount: cubit.categories.length,
            ),
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
