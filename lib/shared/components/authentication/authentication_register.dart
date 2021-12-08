import 'package:flutter/material.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/form_field_validator.dart';

class RegisterAuthentication extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  RegisterAuthentication(
      {Key? key,
      required this.passwordController,
      required this.emailController,
      required this.fullNameController,
      required this.phoneController})
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
            controller: fullNameController,
            keyboardType: TextInputType.name,
            validator: FormFieldValidate.fullNameValidator,
            decoration: const InputDecoration(
              border: InputBorder.none,
              floatingLabelStyle: TextStyle(color: defaultColor),
              hintText: 'Full Name',
              prefixIcon: Icon(
                Icons.person,
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
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return '  Required*';
              }
              String pattern =
                  r'\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
              if (!RegExp(pattern).hasMatch(value)) {
                return '  invalid phone number format';
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone Number',
              floatingLabelStyle: TextStyle(color: defaultColor),
              prefixIcon: Icon(
                Icons.phone,
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
              String pattern =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              if (!RegExp(pattern).hasMatch(value)) {
                return '  6 Characters & 1 UpperCase & 1 Special Character';
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
