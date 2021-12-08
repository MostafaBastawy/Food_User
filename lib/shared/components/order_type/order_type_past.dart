import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/order_model.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class PastOrders extends StatelessWidget {
  int? index;
  OrderDataModel? orderDataModel;
  PastOrders({Key? key, required this.orderDataModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConditionalBuilder(
          condition: cubit.userOrders[index!].orderStatus == 'Picked' ||
              cubit.userOrders[index!].orderStatus == 'Delivered' ||
              cubit.userOrders[index!].orderStatus == 'Cancelled',
          builder: (BuildContext context) => Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: pastOrderColor,
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
                      children: [
                        Row(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.userOrders[index!].orderReceiverName
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cubit.userOrders[index!].orderDateTime
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Order id: ${cubit.userOrders[index!].orderNumber}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: \$ ${cubit.userOrders[index!].orderTotalValue}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                        width: 35.0,
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
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Order Status: Order ${cubit.userOrders[index!].orderStatus}',
                  style: const TextStyle(
                    color: priceColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
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
