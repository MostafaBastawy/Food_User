import 'package:flutter/material.dart';
import 'package:food_user_interface/cubit/cubit.dart';

class DefaultMenuBottom extends StatelessWidget {
  int? index;
  DefaultMenuBottom({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Container(
      height: 100.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey[200]!, width: 2.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0, end: 20.0),
            child: CircleAvatar(
              radius: 35.0,
              backgroundImage:
                  NetworkImage(cubit.categories[index!].imageUrl.toString()),
            ),
          ),
          Text(
            cubit.categories[index!].categoryName.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20.0),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/arrow-icon.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
