import 'package:flutter/material.dart';
import 'package:patient_management/presentation/register/controller/register_controller.dart';
import 'package:patient_management/presentation/register/widgets/register_form.dart';
import 'package:patient_management/presentation/widgets/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = RegisterController();

  @override
  void initState() {
    super.initState();
    controller.loadBranches();
    controller.loadTreatments();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.show(
                context,
                message: controller.errorMessage!,
                type: SnackType.error,
              );
              controller.errorMessage = null;
            });
          }

          if (controller.isRegistrationSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.show(
                context,
                message: 'Created Successfully',
                type: SnackType.success,
              );
              Navigator.pop(context, true);
            });
          }
          return RegisterForm(controller: controller);
        },
      ),
    );
  }
}
