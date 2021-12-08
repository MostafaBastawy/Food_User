import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

class OrderTypeDelivery extends StatelessWidget {
  var fullNameController = TextEditingController();
  var flatNumberController = TextEditingController();
  var areaController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  OrderTypeDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    fullNameController.text =
        cubit.userData[0].userAddress['receiverName'].toString();
    phoneController.text =
        cubit.userData[0].userAddress['receiverNumber'].toString();
    flatNumberController.text =
        cubit.userData[0].userAddress['houseNumber'].toString();
    areaController.text = cubit.userData[0].userAddress['area'].toString();
    addressController.text =
        cubit.userData[0].userAddress['address'].toString();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(
              width: 1.0,
              color: Colors.grey[400]!,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Address Details',
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
              TextFormField(
                cursorColor: defaultColor,
                keyboardType: TextInputType.text,
                controller: fullNameController,
                decoration: const InputDecoration(
                  hintText: 'Receiver Name',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Required *';
                  }
                },
                onChanged: (value) {
                  CacheHelper.setData(key: 'receiverName', value: value);
                },
              ),
              TextFormField(
                cursorColor: defaultColor,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Receiver Number',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Required *';
                  }
                },
                onChanged: (value) {
                  CacheHelper.setData(key: 'receiverNumber', value: value);
                },
              ),
              TextFormField(
                cursorColor: defaultColor,
                keyboardType: TextInputType.number,
                controller: flatNumberController,
                decoration: const InputDecoration(
                  hintText: 'House/Flat No.',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Required *';
                  }
                },
                onChanged: (value) {
                  CacheHelper.setData(key: 'houseNumber', value: value);
                },
              ),
              TextFormField(
                cursorColor: defaultColor,
                keyboardType: TextInputType.text,
                controller: areaController,
                decoration: const InputDecoration(
                  hintText: 'Locality/Area',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Required *';
                  }
                },
                onChanged: (value) {
                  CacheHelper.setData(key: 'area', value: value);
                },
              ),
              TextFormField(
                cursorColor: defaultColor,
                keyboardType: TextInputType.text,
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Required *';
                  }
                },
                onChanged: (value) {
                  CacheHelper.setData(key: 'address', value: value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
