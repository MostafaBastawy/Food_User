import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/category_model.dart';
import 'package:food_user_interface/modules/cart_screen.dart';
import 'package:food_user_interface/shared/components/default_product.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class ProductsScreen extends StatelessWidget {
  CategoryDataModel? categoryDataModel;

  ProductsScreen({Key? key, required this.categoryDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getCategoryProducts(
        productCategory: categoryDataModel!.categoryName!);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              categoryDataModel!.categoryName.toString(),
            ),
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
        body: ConditionalBuilder(
          condition: state is! AppGetCategoryProductsLoadingState,
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (BuildContext context, int index) => DefaultProduct(
              productDataModel: cubit.categoryProducts[index],
            ),
            separatorBuilder: (BuildContext context, int index) => Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1.0,
            ),
            itemCount: cubit.categoryProducts.length,
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
