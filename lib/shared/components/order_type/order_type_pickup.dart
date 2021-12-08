import 'package:flutter/material.dart';
import 'package:food_user_interface/cubit/cubit.dart';

class OrderTypePickUp extends StatelessWidget {
  const OrderTypePickUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name: ',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          Text(
            '  ${AppCubit.get(context).userData[0].userFullName}',
            style: TextStyle(fontSize: 15.0, color: Colors.grey[400]!),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 30.0),
            child: Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          const Text(
            'Phone Number: ',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          Text(
            '  ${AppCubit.get(context).userData[0].userPhoneNumber}',
            style: TextStyle(fontSize: 15.0, color: Colors.grey[400]!),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 30.0),
            child: Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          const Text(
            'Email Address: ',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          Text(
            '  ${AppCubit.get(context).userData[0].userEmail}',
            style: TextStyle(fontSize: 15.0, color: Colors.grey[400]!),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8.0),
            child: Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
