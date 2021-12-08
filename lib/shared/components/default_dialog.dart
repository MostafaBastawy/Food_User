import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/models/product_model.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class DefaultDialog extends StatelessWidget {
  ProductDataModel? productDataModel;

  DefaultDialog({Key? key, required this.productDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productDataModel!.productSmallSizePrice != null) {
      AppCubit.get(context).categoryProductSize.add('Small');
    }
    if (productDataModel!.productMediumSizePrice != null) {
      AppCubit.get(context).categoryProductSize.add('Medium');
    }
    if (productDataModel!.productLargeSizePrice != null) {
      AppCubit.get(context).categoryProductSize.add('Large');
    }

    String? productSize = AppCubit.get(context).categoryProductSize[0];
    String? productQuantity = '1';
    int? productPrice;
    if (productSize.contains('Small')) {
      productPrice = productDataModel!.productSmallSizePrice;
    }
    if (productSize.contains('Medium')) {
      productPrice = productDataModel!.productMediumSizePrice;
    }
    if (productSize.contains('Large')) {
      productPrice = productDataModel!.productLargeSizePrice;
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppAddToCartSuccessState) {
          defaultToast(
            message:
                '${productDataModel!.productName} added to your cart successfully',
            color: Colors.green,
            context: context,
          );
          Navigator.pop(context);
          AppCubit.get(context).updateUserCartTotal(
              total: ((AppCubit.get(context).userData[0].userCartTotal)! +
                  (int.parse(productQuantity!) * productPrice!)));
        }
      },
      builder: (BuildContext context, state) => AlertDialog(
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.all(0.0),
        elevation: 50.0,
        backgroundColor: Colors.white,
        title: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(4.0),
              topLeft: Radius.circular(4.0),
            ),
            image: DecorationImage(
              image: NetworkImage(productDataModel!.productImage.toString()),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 80.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: priceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '\$ $productPrice',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(18.0),
          height: MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDataModel!.productName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 8.0),
                    child: Text(
                      productDataModel!.productRecipe.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey[400]!, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton<String>(
                              style: const TextStyle(color: Colors.black),
                              value: productQuantity,
                              underline: Container(
                                height: 0.0,
                              ),
                              onChanged: (String? value) {
                                productQuantity = value;
                                AppCubit.get(context).emit(AppRefreshState());
                              },
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey[400]!, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton<String>(
                              style: const TextStyle(color: Colors.black),
                              value: productSize,
                              underline: Container(
                                height: 0.0,
                              ),
                              onChanged: (value) {
                                productSize = value;
                                if (productSize!.contains('Small')) {
                                  productPrice =
                                      productDataModel!.productSmallSizePrice;
                                }
                                if (productSize!.contains('Medium')) {
                                  productPrice =
                                      productDataModel!.productMediumSizePrice;
                                }
                                if (productSize!.contains('Large')) {
                                  productPrice =
                                      productDataModel!.productLargeSizePrice;
                                }
                                AppCubit.get(context).emit(AppRefreshState());
                              },
                              items: AppCubit.get(context)
                                  .categoryProductSize
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border:
                            Border.all(color: Colors.grey[400]!, width: 2.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).userCart.add({
                            'productImage': productDataModel!.productImage,
                            'productName': productDataModel!.productName,
                            'productPrice': productPrice,
                            'productQuantity': int.parse(productQuantity!),
                            'productTotalPrice':
                                (int.parse(productQuantity!) * productPrice!),
                          });
                          AppCubit.get(context).addToCart();
                        },
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
