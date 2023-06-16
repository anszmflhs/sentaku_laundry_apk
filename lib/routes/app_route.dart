import 'package:flutter/material.dart';
import 'package:sentaku_laundry_apk/main.dart';
import 'package:sentaku_laundry_apk/pages/login_page.dart';
import 'package:sentaku_laundry_apk/pages/order_page.dart';
import 'package:sentaku_laundry_apk/pages/register_page.dart';

class AppRoutes {
  AppRoutes._();

  static const orderPage = '/order';
  static const loginPage = '/login-user';
  static const registerPage = '/register';
  static const myApp = '/myApp';

  static final routes = <String, WidgetBuilder>{
    loginPage: (_) => const LoginPage(),
    registerPage: (_) => const RegisterPage(),
    orderPage: (_) => const OrderPage(),
    myApp: (_) => const MyApp(),
  };
}