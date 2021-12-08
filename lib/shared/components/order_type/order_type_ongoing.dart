import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/order_model.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class OngoingOrders extends StatelessWidget {
  int? index;
  OrderDataModel? orderDataModel;
  OngoingOrders({Key? key, required this.index, required this.orderDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConditionalBuilder(
          condition: cubit.userOrders[index!].orderStatus == 'Pending' ||
              cubit.userOrders[index!].orderStatus == 'Preparing' ||
              cubit.userOrders[index!].orderStatus == 'Shipped',
          builder: (BuildContext context) => Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Image.asset(
                            orderDataModel!.orderType == 'Delivery'
                                ? 'assets/images/delivery-icon.png'
                                : 'assets/images/preparation-icon.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order No: ${orderDataModel!.orderNumber.toString()}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderDataModel!.orderPaymentMethod.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderDataModel!.orderStatus.toString(),
                                style: const TextStyle(
                                  color: defaultColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                          child: Text(
                            '\$ ${orderDataModel!.orderTotalValue}',
                            style: const TextStyle(
                              color: defaultColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120.0,
                        child: Text(
                            '• ${orderDataModel!.orderProducts[index].productName}'),
                      ),
                      Text(
                          'Qty:${orderDataModel!.orderProducts[index].productQuantity}'),
                      SizedBox(
                        width: 40.0,
                        child: Text(
                            '\$ ${(orderDataModel!.orderProducts[index].productPrice)! * (orderDataModel!.orderProducts[index].productQuantity!)}'),
                      ),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemCount: orderDataModel!.orderProducts.length,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Track Order',
                    style: TextStyle(
                      color: defaultColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          fallback: (BuildContext context) => const Center(
            child: Text(''),
          ),
        ),
      ),
    );
  }
}
