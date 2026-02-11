import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/auth_utils.dart';
import 'package:patient_management/infrastructure/login/login_repository.dart';

class LoginController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository _repo = AuthRepository();

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage = 'Please enter username and password';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    errorMessage = null;

    try {
      final res = await _repo.login(
        username: emailController.text.trim(),
        password: passwordController.text,
      );

      final data = res.data;

      if (data['status'] == true) {
        await AuthUtils.instance.saveTokens(accessToken: data['token']);
        _setLoading(false);
        successMessage = data['message'] ?? 'Login Success';
        return true;
      }

      errorMessage = data['message'] ?? 'Login failed';
    } on DioException catch (e) {
      errorMessage = e.response?.data['message'] ?? 'Network error';
    } catch (_) {
      errorMessage = 'Something went wrong';
    }

    _setLoading(false);
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
