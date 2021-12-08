import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/order_details_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/default_cart_item.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getUserData();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Your Cart'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                navigateTo(
                  widget: const HomeMenu(),
                  context: context,
                );
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 20.0),
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: Image.asset(
                    'assets/images/home-icon.png',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (cubit.userData[0].userCart.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('Your cart is empty'),
                  ),
                ),
              if (cubit.userData[0].userCart.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        DefaultCartItem(
                      cartDataModel: cubit.userData[0].userCart[index],
                      index: index,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10.0),
                    itemCount: cubit.userData[0].userCart.length,
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0),
                child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 33.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: defaultColor, width: 2.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            navigateAndFinish(
                              widget: const HomeMenu(),
                              context: context,
                            );
                          },
                          child: const Text(
                            'Add more items',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Total: \$ ${AppCubit.get(context).userData[0].userCartTotal}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ],
                  ),
                ),
              ),
              if (cubit.userData[0].userCartTotal! > 0)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10.0),
                  child: DefaultButton(
                    onPressed: () {
                      navigateTo(
                        widget: OrderDetailsScreen(),
                        context: context,
                      );
                    },
                    labelText: 'CONTINUE',
                    color: defaultColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
