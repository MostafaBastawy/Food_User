import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/payment_details_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/order_type/order_type_delivery.dart';
import 'package:food_user_interface/shared/components/order_type/order_type_pickup.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';
import 'package:group_radio_button/group_radio_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  String orderType = "Delivery";
  var formKey = GlobalKey<FormState>();
  OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppUpdateUserAddressSuccessState) {
          navigateTo(
            widget: PaymentDetailsScreen(),
            context: context,
          );
          CacheHelper.removeData(key: 'receiverName');
          CacheHelper.removeData(key: 'receiverNumber');
          CacheHelper.removeData(key: 'houseNumber');
          CacheHelper.removeData(key: 'area');
          CacheHelper.removeData(key: 'address');
          defaultToast(
            message: 'Receiver info updated successfully',
            color: Colors.green,
            context: context,
          );
        }
        if (state is AppUpdateUserAddressErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Order Details'),
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order type',
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
                    groupValue: orderType,
                    onChanged: (String? value) {
                      orderType = value!;
                      CacheHelper.setData(key: 'orderType', value: orderType);
                      cubit.emit(AppRefreshState());
                    },
                    items: cubit.orderType,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                    activeColor: defaultColor,
                  ),
                  if (orderType == "Delivery") OrderTypeDelivery(),
                  if (orderType == "Pick-up (in 30 minutes)")
                    const OrderTypePickUp(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 10.0),
                    child: DefaultButton(
                      onPressed: () {
                        if (orderType == "Delivery") {
                          if (formKey.currentState!.validate()) {
                            cubit.updateDeliveryAddress(
                              receiverName:
                                  CacheHelper.getData(key: 'receiverName') ??
                                      cubit.userData[0]
                                          .userAddress['receiverName']
                                          .toString(),
                              receiverNumber:
                                  CacheHelper.getData(key: 'receiverNumber') ??
                                      cubit.userData[0]
                                          .userAddress['receiverNumber']
                                          .toString(),
                              houseNumber:
                                  CacheHelper.getData(key: 'houseNumber') ??
                                      cubit.userData[0]
                                          .userAddress['houseNumber']
                                          .toString(),
                              area: CacheHelper.getData(key: 'area') ??
                                  cubit.userData[0].userAddress['area']
                                      .toString(),
                              address: CacheHelper.getData(key: 'address') ??
                                  cubit.userData[0].userAddress['address']
                                      .toString(),
                            );
                          }
                        } else {
                          navigateTo(
                            widget: PaymentDetailsScreen(),
                            context: context,
                          );
                        }
                      },
                      labelText: 'CONTINUE',
                      color: defaultColor,
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
