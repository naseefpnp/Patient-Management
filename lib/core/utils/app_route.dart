import 'package:flutter/material.dart';
import 'package:patient_management/presentation/home/view/home_screen.dart';
import 'package:patient_management/presentation/login/view/login.dart';
import 'package:patient_management/presentation/register/view/register.dart';
import 'package:patient_management/presentation/splash/view/splash.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String homeScreen = '/home_screen';
  static const String register = '/register';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    homeScreen: (context) => const HomeScreen(),
    register: (context) => const RegisterScreen(),
  };
}
