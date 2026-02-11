// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:patient_management/core/images/images.dart';
import 'package:patient_management/core/utils/app_route.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/presentation/login/controller/login_controller.dart';
import 'package:patient_management/presentation/widgets/elevated_button.dart';
import 'package:patient_management/presentation/widgets/snackbar.dart';
import 'package:patient_management/presentation/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = LoginController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: SizeUtils.h(230),
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(Images.loginBackground, fit: BoxFit.cover),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(color: Colors.black.withOpacity(0.08)),
                  ),
                ),
                Center(child: Image.asset(Images.logo, width: SizeUtils.w(90))),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                SizeUtils.w(20),
                SizeUtils.h(16),
                SizeUtils.w(20),
                MediaQuery.of(context).viewInsets.bottom + SizeUtils.h(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeUtils.h(24)),
                  Text(
                    'Login Or Register To Book\nYour Appointments',
                    style: TextStyle(
                      fontSize: SizeUtils.sp(20),
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: SizeUtils.h(20)),
                  const Text('Email'),
                  SizedBox(height: SizeUtils.h(8)),
                  AppTextField(
                    controller: controller.emailController,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: SizeUtils.h(12)),
                  const Text('Password'),
                  SizedBox(height: SizeUtils.h(8)),
                  AppTextField(
                    controller: controller.passwordController,
                    hintText: 'Enter password',
                    obscureText: true,
                  ),

                  SizedBox(height: SizeUtils.h(80)),
                  SizedBox(
                    width: double.infinity,
                    height: SizeUtils.h(48),
                    child: CustomElevatedButton(
                      label: 'Login',
                      isLoading: controller.isLoading,
                      onPressed: controller.isLoading
                          ? null
                          : () async {
                              final success = await controller.login();
                              if (!mounted) return;

                              if (success) {
                                AppSnackBar.show(
                                  context,
                                  message:
                                      controller.successMessage ??
                                      'Login success',
                                  type: SnackType.success,
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.homeScreen,
                                  (route) => false,
                                );
                              } else {
                                AppSnackBar.show(
                                  context,
                                  message:
                                      controller.errorMessage ?? 'Login failed',
                                  type: SnackType.error,
                                );
                              }
                            },
                    ),
                  ),

                  SizedBox(height: SizeUtils.h(40)),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: SizeUtils.sp(11),
                          color: Colors.grey.shade500,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(
                            text:
                                'By creating or logging into an account you are agreeing\nwith our ',
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
