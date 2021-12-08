import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/models/product_model.dart';
import 'package:food_user_interface/shared/components/default_dialog.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class DefaultProduct extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ProductDataModel? productDataModel;
  int? index;
  DefaultProduct({Key? key, required this.productDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 110.0,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        bottom: 20.0,
        top: 20.0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage:
                NetworkImage(productDataModel!.productImage.toString()),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    productDataModel!.productName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    productDataModel!.productRecipe.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                    productDataModel!.productMediumSizePrice != null
                        ? '\$ ${productDataModel!.productMediumSizePrice}'
                        : '\$ ${productDataModel!.productSmallSizePrice}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: GestureDetector(
                  onTap: () {
                    AppCubit.get(context).categoryProductSize = [];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => DefaultDialog(
                        productDataModel: productDataModel,
                      ),
                    );
                  },
                  child: Container(
                    height: 30.0,
                    width: 76.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: defaultColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
