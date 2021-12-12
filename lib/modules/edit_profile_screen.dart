import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/cubit/states.dart';
import 'package:food_user_interface/modules/profile_screen.dart';
import 'package:food_user_interface/shared/components/default_button.dart';
import 'package:food_user_interface/shared/components/navigator.dart';
import 'package:food_user_interface/shared/components/show_toaster.dart';
import 'package:food_user_interface/shared/design/colors.dart';
import 'package:food_user_interface/shared/form_field_validator.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    nameController.text = cubit.userData[0].userFullName.toString();
    phoneController.text = cubit.userData[0].userPhoneNumber.toString();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppUserDataUpdateSuccessState) {
          defaultToast(
            message: 'your data updated successfully',
            color: Colors.green,
            context: context,
          );

          navigateAndFinish(context: context, widget: const ProfileScreen());
        }
        if (state is AppUserDataUpdateErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(
            widget: const ProfileScreen(),
            context: context,
          );
        }
      },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(end: 40.0),
            child: Center(
              child: Text('Edit Profile'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage(
                            cubit.userData[0].userProfileImage.toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              cubit.getProfileImage();
                            },
                            child: const Icon(
                              Icons.camera,
                              color: defaultColor,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: FormFieldValidate.fullNameValidator,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        floatingLabelStyle: TextStyle(color: defaultColor),
                        prefixIcon: Icon(
                          Icons.person,
                          color: defaultColor,
                        ),
                      ),
                      onTap: () {},
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
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
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.34),
                  ConditionalBuilder(
                    condition: state is! AppUserDataUpdateLoadingState,
                    builder: (BuildContext context) => DefaultButton(
                      onPressed: () {

                        if (formKey.currentState!.validate()) {
                          cubit.userDataUpdate(
                            userFullName: nameController.text ,
                            userPhoneNumber: phoneController.text,
                            userProfileImage: cubit.profileImageUrl.toString().isEmpty
                                ? cubit.userData[0].userProfileImage.toString()
                                : cubit.profileImageUrl.toString(),
                          );
                        }
                      },
                      labelText: 'Save Details',
                      color: defaultColor,
                    ),
                    fallback: (BuildContext context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
