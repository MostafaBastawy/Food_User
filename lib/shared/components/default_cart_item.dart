import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/cart_model.dart';

class DefaultCartItem extends StatelessWidget {
  int? index;
  CartDataModel cartDataModel;
  DefaultCartItem({Key? key, required this.cartDataModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${cartDataModel.productImage}'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  '${cartDataModel.productQuantity} PCs x ${cartDataModel.productName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  '${cartDataModel.productQuantity} Pcs x \$ ${cartDataModel.productPrice} = \$ ${cartDataModel.productTotalPrice}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              AppCubit.get(context).userCart.removeAt(index!);
              AppCubit.get(context).removeFromCart();
              AppCubit.get(context).updateUserCartTotal(
                  total: ((AppCubit.get(context).userData[0].userCartTotal)! -
                      (cartDataModel.productTotalPrice!)));
              print(cartDataModel.productTotalPrice);
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/trash-icon.png'),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
