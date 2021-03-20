import 'package:flutter/cupertino.dart';
import 'package:inventory_management_system/Screens/Home/home_screen.dart';
import 'package:inventory_management_system/Screens/sign_in/sign_in_screen.dart';
import 'package:inventory_management_system/main.dart';

import 'Screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
};
