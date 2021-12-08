import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_user_interface/cubit/bloc_observer.dart';
import 'package:food_user_interface/cubit/cubit.dart';
import 'package:food_user_interface/modules/authentication_screen/authentication_cubit.dart';
import 'package:food_user_interface/modules/home_menu_screen.dart';
import 'package:food_user_interface/modules/on_boarding_screen.dart';
import 'package:food_user_interface/shared/components/dio_helper/dio_helper.dart';
import 'package:food_user_interface/shared/constants.dart';
import 'package:food_user_interface/shared/design/themes.dart';
import 'package:food_user_interface/shared/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = publishableKey;
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  Widget startScreen;
  uid.isNotEmpty
      ? startScreen = const HomeMenu()
      : startScreen = const OnBoardingScreen();
  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  const MyApp({Key? key, this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getCategories()),
        BlocProvider(
            create: (BuildContext context) => AppAuthenticationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startScreen,
      ),
    );
  }
}
