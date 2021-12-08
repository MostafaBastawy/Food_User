import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/my_orders_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Order Complete'),
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
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[400]!, width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/complete-icon.png'),
                              fit: BoxFit.fill)),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(top: 20.0),
                      child: Text(
                        'Payment Completed',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 10.0,
                        start: 32.0,
                        end: 32.0,
                        bottom: 40.0,
                      ),
                      child: Text(
                        'We\'ve sent you an email with all the details of your order & remember you can track your order using this app!',
                        style: TextStyle(
                          color: Colors.grey[600]!,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    const Text(
                      'Your Order Number:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '123456789',
                      style: TextStyle(
                        color: Colors.grey[600]!,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(top: 50.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/smile-icon.png'),
                          fit: BoxFit.fill)),
                ),
              ),
              const Text(
                'Thank You!',
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0),
                child: DefaultButton(
                  onPressed: () {
                    navigateAndFinish(
                      widget: MyOrdersScreen(),
                      context: context,
                    );
                  },
                  labelText: 'Go to My Orders',
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
