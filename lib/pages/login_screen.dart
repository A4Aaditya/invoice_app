import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/register_screen.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/snackbar.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: ListView(
        children: [
          InputField(controller: emailController),
          InputField(controller: passwordController),
          Button(onPressed: onSiginTap, child: const Text("Login")),
          TextButton(
            onPressed: onSignupTap,
            child: const Text("SignUp", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void onSignupTap() {
    final route = MaterialPageRoute(
      builder: (context) {
        return const RegisterScreen();
      },
    );
    Navigator.push(context, route);
  }

  Future<void> onSiginTap() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final loginParams = LoginParams(password: password, email: email);
    final authService = GetIt.instance.get<AuthService>();
    final response = await authService.signinWithPassword(loginParams);
    if (!mounted) return;
    switch (response) {
      case SucessResult<User, String>():
        final route = MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );

        Navigator.pushReplacement(context, route);
      case FailureResult<User, String>(:final error):
        SnackbarHelper.showError(context, error);
    }
  }
}
