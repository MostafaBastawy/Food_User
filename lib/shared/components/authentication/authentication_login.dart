import 'package:flutter/material.dart';
import 'package:food_user_interface/shared/design/colors.dart';

class LoginAuthentication extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginAuthentication(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return '  Required*';
              }
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value)) {
                return '  invalid email address format';
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Email Address',
              floatingLabelStyle: TextStyle(color: defaultColor),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: defaultColor,
              ),
            ),
            onTap: () {},
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
          ),
          Container(
            height: 1.0,
            color: Colors.grey[100],
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return '  Required*';
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
              floatingLabelStyle: TextStyle(color: defaultColor),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: defaultColor,
              ),
            ),
            onTap: () {},
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
          ),
        ],
      ),
    );
  }
}
