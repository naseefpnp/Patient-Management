import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/app_route.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/presentation/splash/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SizeUtils.init(context);
        return child!;
      },
      home: const SplashScreen(),
    );
  }
}
