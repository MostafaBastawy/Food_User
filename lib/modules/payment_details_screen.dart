import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/cart_screen.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/order_complete_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';
import 'package:group_radio_button/group_radio_button.dart';

class PaymentDetailsScreen extends StatelessWidget {
  String paymentMethod = "Visa Debit Card";
  PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    if (CacheHelper.getData(key: 'orderType') == 'Delivery') {
      cubit.totalPayment =
          (cubit.userData[0].userCartTotal! + cubit.deliveryFees);
    }
    if (CacheHelper.getData(key: 'orderType') == 'Pick-up (in 30 minutes)') {
      cubit.totalPayment = cubit.userData[0].userCartTotal;
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppUserPurchaseOrderSuccessState) {
          defaultToast(
            message: 'Your order sent successfully',
            color: Colors.green,
            context: context,
          );
          cubit.userCart = [];
          cubit.addToCart();
          cubit.updateUserCartTotal(total: 0);
          cubit.paymentIntent = {};
          navigateAndFinish(
            widget: const OrderCompleteScreen(),
            context: context,
          );
        }
        if (state is AppUserPurchaseOrderErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(widget: const HomeMenu(), context: context);
        }
        if (state is AppMakePaymentSuccessState) {
          cubit.userPurchaseOrder(
            orderReceiverAddress: CacheHelper.getData(key: 'orderType') ==
                    'Delivery'
                ? '${cubit.userData[0].userAddress['houseNumber']}, ${cubit.userData[0].userAddress['area']}, ${cubit.userData[0].userAddress['address']}'
                : 'Pick-up',
            orderReceiverName:
                CacheHelper.getData(key: 'orderType') == 'Delivery'
                    ? cubit.userData[0].userAddress['receiverName']
                    : cubit.userData[0].userFullName,
            orderReceiverNumber:
                CacheHelper.getData(key: 'orderType') == 'Delivery'
                    ? cubit.userData[0].userAddress['receiverNumber']
                    : cubit.userData[0].userPhoneNumber,
            orderTotalValue: cubit.totalPayment.toString(),
            orderPaymentMethod: paymentMethod,
            orderType: CacheHelper.getData(key: 'orderType'),
            orderPaymentId: paymentMethod == 'Visa Debit Card'
                ? cubit.paymentIntent['id']
                : 'COD',
          );
        }
        if (state is AppMakePaymentErrorState ||
            state is AppMakePaymentIntentErrorState) {
          defaultToast(
            message: 'The payment has been Cancelled',
            color: Colors.red,
            context: context,
          );
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Payment Details'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment method',
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  color: defaultColor,
                  height: 1.0,
                  width: double.infinity,
                ),
              ),
              RadioGroup<String>.builder(
                groupValue: paymentMethod,
                onChanged: (String? value) {
                  paymentMethod = value!;
                  cubit.emit(AppRefreshState());
                },
                items: AppCubit.get(context).paymentMethod,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
                activeColor: defaultColor,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0),
                child: Container(
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
                              widget: const CartScreen(),
                              context: context,
                            );
                          },
                          child: const Text(
                            'View Order Summary',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (CacheHelper.getData(key: 'orderType') ==
                              'Delivery')
                            Text(
                              'Delivery fees: \$ ${cubit.deliveryFees}',
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          Text(
                            'Total: \$ ${cubit.totalPayment}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ConditionalBuilder(
                condition: state is! AppUserPurchaseOrderLoadingState,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10.0),
                  child: DefaultButton(
                    onPressed: () async {
                      if (paymentMethod == 'Cash on Delivery') {
                        cubit.userPurchaseOrder(
                          orderReceiverAddress: CacheHelper.getData(
                                      key: 'orderType') ==
                                  'Delivery'
                              ? '${cubit.userData[0].userAddress['houseNumber']}, ${cubit.userData[0].userAddress['area']}, ${cubit.userData[0].userAddress['address']}'
                              : 'Pick-up',
                          orderReceiverName: CacheHelper.getData(
                                      key: 'orderType') ==
                                  'Delivery'
                              ? cubit.userData[0].userAddress['receiverName']
                              : cubit.userData[0].userFullName,
                          orderReceiverNumber: CacheHelper.getData(
                                      key: 'orderType') ==
                                  'Delivery'
                              ? cubit.userData[0].userAddress['receiverNumber']
                              : cubit.userData[0].userPhoneNumber,
                          orderTotalValue: cubit.totalPayment.toString(),
                          orderPaymentMethod: paymentMethod,
                          orderType: CacheHelper.getData(key: 'orderType'),
                          orderPaymentId: paymentMethod == 'Visa Debit Card'
                              ? cubit.paymentIntent['id']
                              : 'COD',
                        );
                      }
                      if (paymentMethod == 'Visa Debit Card') {
                        AppCubit.get(context).makePaymentIntent();
                      }
                    },
                    labelText: 'CHECK OUT',
                    color: defaultColor,
                  ),
                ),
                fallback: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
