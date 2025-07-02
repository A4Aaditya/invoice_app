import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/pages/login_screen.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/snackbar.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: ListView(
        children: [
          InputField(controller: emailController),
          InputField(controller: passwordController),
          Button(onPressed: register, child: const Text("Register")),
        ],
      ),
    );
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final registerParams = RegisterParams(email: email, password: password);
    final authService = GetIt.instance.get<AuthService>();

    final response = await authService.registerEmailPassword(registerParams);
    if (!mounted) return;
    switch (response) {
      case SucessResult<User, String>():
        SnackbarHelper.showSuccess(
          context,
          "User created successfully! Confirmation link sent to your register mail.",
        );
        navigateToLoginScreen();
      case FailureResult<User, String>(:final error):
        SnackbarHelper.showError(context, error);
    }
  }

  void navigateToLoginScreen() {
    final route = MaterialPageRoute(builder: (context) => const LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
