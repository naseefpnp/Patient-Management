import 'package:flutter/material.dart';
import 'package:patient_management/core/images/images.dart';
import 'package:patient_management/core/utils/app_route.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/core/utils/auth_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _checkAuth());
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await AuthUtils.instance.isLoggedIn;
    final token = await AuthUtils.instance.readAccessToken;

    if (!mounted) return;

    if (isLoggedIn && token != null && token.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeScreen,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              Images.backGroundImage,
              height: SizeUtils.screenHeight,
              width: SizeUtils.screenWidth,
              fit: BoxFit.fill,
            ),
            Center(child: Image.asset(Images.logo, width: SizeUtils.w(180))),
          ],
        ),
      ),
    );
  }
}
