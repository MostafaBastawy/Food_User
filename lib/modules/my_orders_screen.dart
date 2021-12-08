import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/shared/components/default_drawer.dart';
import 'package:food_user_interface/shared/components/order_type/order_type_ongoing.dart';
import 'package:food_user_interface/shared/components/order_type/order_type_past.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class MyOrdersScreen extends StatelessWidget {
  bool ongoingOrders = true;
  bool pastOrders = false;
  MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getUserOrders();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(end: 40.0),
            child: Center(
              child: Text('My Order\'s'),
            ),
          ),
        ),
        drawer: const DefaultDrawer(),
        body: Column(
          children: [
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        ongoingOrders = true;
                        pastOrders = false;
                        cubit.emit(AppRefreshState());
                      },
                      child: Text(
                        'Ongoing Orders',
                        style: TextStyle(
                          color: ongoingOrders ? defaultColor : Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        ongoingOrders = false;
                        pastOrders = true;
                        cubit.emit(AppRefreshState());
                      },
                      child: Text(
                        'Past Orders',
                        style: TextStyle(
                          color: pastOrders ? defaultColor : Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (ongoingOrders)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      OngoingOrders(
                    orderDataModel:
                        cubit.userOrders[index].orderStatus == 'Pending' ||
                                cubit.userOrders[index].orderStatus ==
                                    'Preparing' ||
                                cubit.userOrders[index].orderStatus == 'Shipped'
                            ? cubit.userOrders[index]
                            : null,
                    index: index,
                  ),
                  itemCount: cubit.userOrders.length,
                ),
              ),
            if (pastOrders)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) => PastOrders(
                    orderDataModel: cubit.userOrders[index].orderStatus ==
                                'Picked' ||
                            cubit.userOrders[index].orderStatus ==
                                'Delivered' ||
                            cubit.userOrders[index].orderStatus == 'Cancelled'
                        ? cubit.userOrders[index]
                        : null,
                    index: index,
                  ),
                  itemCount: cubit.userOrders.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
