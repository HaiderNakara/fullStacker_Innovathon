import 'package:flutter/cupertino.dart';
import 'package:inventory_management_system/Screens/Home/home_screen.dart';
import 'package:inventory_management_system/Screens/add_category/add_category.dart';
import 'package:inventory_management_system/Screens/add_product/add_product.dart';
import 'package:inventory_management_system/Screens/camera_scanner/camera_scanner.dart';
import 'package:inventory_management_system/Screens/category_list/category_list.dart';
import 'package:inventory_management_system/Screens/product_detail/product_detail.dart';
import 'package:inventory_management_system/Screens/sign_in/sign_in_screen.dart';
import 'package:inventory_management_system/main.dart';
import 'Screens/edit_product/edit_product.dart';
import 'Screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
  AddCategory.routeName: (context) => AddCategory(),
  AddProduct.routeName: (context) => AddProduct(),
  CategoryList.routeName: (context) => CategoryList(),
  ProductDetail.routeName: (context) => ProductDetail(),
  CameraScanner.routeName: (context) => CameraScanner(),
  EditProduct.routeName: (context) => EditProduct(),
};
